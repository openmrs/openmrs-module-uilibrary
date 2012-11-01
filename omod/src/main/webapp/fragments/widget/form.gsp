<%
// supports url (submit as a form to that url)
// supports page (submit as a form to a page)
// supports fragment + action (submit as json to a fragment action)

// supports mode (form|json)
// supports cancelFunction
// supports successCallbacks (a list of js snippets wrapped in function(data) { ... })
// supports submitOnEvent (will subscribe to the given topic, and submit when it fires)
// supports resetOnSubmit (default true)
// supports submitLabel (button will only be shown if you provide this)
// supports cancelLabel (button will only be shown if you provide this)
// supports submitLoadingMessage (if specified, show a loading dialog with this message on ajax submit. this loading message will be closed on an error response, but on a success response it's up to the caller to close it)

// supports fields (list, whose elements can be)
//		[ label, formFieldName, class, fieldConfig ] ... delegates to the field fragment
//		[ fragment ] ... includes a fragment
//		[ value ] ... displays a value
//		[ hiddenInputName, value ] ... includes a hidden value
// supports commandObject + properties + hiddenProperties + prefix (introspects fields from a java object)
//     when using commandObject, supports fieldConfig (map from property name to config map for the field)
//     when using commandObject, supports propConfig (map from property name to config map, passed as config to the default field)
//     when using commandObject, supports extraFields 

// supports noDecoration

	import org.openmrs.ui.framework.fragment.FragmentConfiguration
	import org.apache.commons.beanutils.PropertyUtils

	ui.includeJavascript("coreFragments.js")
	
    def id = config.id ?: ui.randomId("form")
    
    def mode = config.mode ?: "form"
    def url = config.url
    def resetOnSubmit = config.resetOnSubmit == null ? true : config.resetOnSubmit
    
    if (config.pageProvider && config.page) {
		url = ui.pageLink(config.pageProvider, config.page)
	} else if (config.fragmentProvider && config.fragment && config.action) {
		mode = "json"
		url = ui.actionLink(config.fragmentProvider, config.fragment, config.action, [successUrl: config.returnUrl])
	}

	def fields = config.fields
	if (config.commandObject) {
		if (!fields)
    		fields = []
    	// make fields for: hiddenProperties, properties
    	// prefix all formFieldNames with: prefix
        def messagePrefix = config.commandObject.class.simpleName
    	def prefix = config.prefix ?: ""
    	if (config.hiddenProperties) {
    		config.hiddenProperties.each { propName ->
    			fields << [ hiddenInputName: "${ prefix }.${ propName }", value: ui.convert(config.commandObject."${ propName }", java.lang.String) ] 
    		}
    	}
    	if (config.properties) {
    		config.properties.each { propName ->
    			def override = config?.fieldConfig?."${ propName }"
    			def fieldOverride = new org.openmrs.ui.framework.fragment.FragmentConfiguration()
    			fieldOverride.mergeAttributes([
    						label: ui.message("${ messagePrefix }.${ propName }"),
    		                formFieldName: "${ prefix }.${ propName }",
    		                object: config.commandObject,
    		                property: propName,
    		                config: config?.propConfig?."${ propName }"
						]) 
    			if (override)
    				fieldOverride.mergeAttributes(override)
    		    fields << fieldOverride
    		}
    	}
    	if (config.extraFields) {
    		fields.addAll(config.extraFields)
    	}
    }  
%>

<form id="${ id }" action="${ url }" method="post"<% if (config.noDecoration) { %> style="display: inline"<% } %>>

    <div style="display: none" id="${ id }-globalerror" class="error"></div> 

<% fields.each {
    def fragment, fragmentProvider
    if (it.fragment) {
        fragment = it.fragment
		fragmentProvider = it.fragmentProvider
	}
	else if (it.class || (it.object && it.property)) {
        fragment = "widget/field"
		fragmentProvider = "uilibrary"
	}
    else if (it.value && !it.hiddenInputName) {
    	fragment = "widget/field"
		fragmentProvider = "uilibrary"
	}

	if (fragment) {
        fieldConfig = new FragmentConfiguration(it)
        fieldConfig.merge([ parentFormId: id, visibleFieldId: ui.randomId("field"), parentFormMode: mode ])
        if (!config.noDecoration)
            fieldConfig.merge([ decorator: "labeled", decoratorConfig: it ])
%>
		<% if (config.noDecoration && fieldConfig.label) { %>${ fieldConfig.label }<% } %>
        ${ ui.includeFragment(fragmentProvider, fragment, fieldConfig) }
        
<%  } else if (it.hiddenInputName) { %>
        <input type="hidden" name="${ it.hiddenInputName }" value="${ it.value }"/>
        
<%  } else { %>
        Don't know how to handle field ${ it }
        
<%  } %>
<% } %>

<% if (config.submitLabel) { %>
	<input type="submit" class="button" value="${ config.submitLabel }"/>
<% } %>

<% if (config.cancelLabel) { %>
    <input type="button" class="button" value="${ config.cancelLabel }" onClick="publish('${ id }.reset'); ${ config.cancelFunction }()"/>
<% } %>

</form>

<% if (mode == "json") { %>
    <script>
    	jq(function() {
	        jq('#${ id }').submit(function(e) {
	            e.preventDefault();
	            publish('${ id }.clear-errors');
	            <% if (config.submitLoadingMessage) { %>
	            	ui.openLoadingDialog('${ ui.escapeJs(config.submitLoadingMessage) }');
	            <% } %>
	            var form = jq(this);
	            var data = form.serialize();
	            jq.ajax({
	                type: "POST",
	                url: form.attr('action'),
	                data: data,
	                dataType: "json"
	            })
	            .success(function(data) {
	            	<% if (resetOnSubmit) { %>
	                	publish('${ id }.reset');
	                <% } %>
	               	<% if (config.successEvent) { %>
	                	publish('${ config.successEvent }', data);
	                <% } %>
	                ui.disableConfirmBeforeNavigating();
	            })
	            <% if (config.successCallbacks) config.successCallbacks.each { %>
	                .success(function(data) {
	                    ${ it }
	                })
	            <% } %>
	            .error(function(jqXHR, textStatus, errorThrown) {
	            	formWidget.handleSubmitError('${ id }', jqXHR);
	            	<% if (config.submitLoadingMessage) { %>
	                	ui.closeLoadingDialog();
	                <% } %>
	            });
	        });
		});
    </script>
<% } else { /* standard form submission */ %>
	<script>
		jq('#${ id }').submit(function(e) {
			ui.disableConfirmBeforeNavigating();
		});
	</script>
<% } %>

<% if (config.submitOnEvent) { %>
	<script>
		var timeoutId${ id } = null;
		subscribe('${ config.submitOnEvent }', function() {
			if (timeoutId${ id } != null) {
				clearTimeout(timeoutId${ id });
				timeoutId${ id } = null;
			}
			timeoutId${ id } = setTimeout(function() {
				jq('#${ id }').submit();
			}, 150);
		});
	</script>
<% } %>
