<%
// supports propConfig.options (will use an autocomplete)
// supports propConfig.size
// supports config.type = textarea, config.rows, config.cols

	ui.includeJavascript("uilibrary", "coreFragments.js")
%>
<% if (config?.propConfig?.options) { %>
    ${ ui.includeFragment("widget/autocomplete", [
            id: config.id,
            formFieldName: config.formFieldName,
            options: config.propConfig.options,
            valueProperty: 'value',
            labelProperty: 'label'
        ]) }

<% } else if (config?.config?.type == 'textarea') {
	def rows = config?.config?.rows ?: 5
	def cols = config?.config?.cols ?: 40
%>
	<textarea id="${ config.id }" name="${ config.formFieldName }" rows="${ rows }" cols="${ cols }">${ config.initialValue ?: "" }</textarea>
	
<% } else {
	def size = config?.propConfig?.size ?: 40
%>
	<input id="${ config.id }" type="text" name="${ config.formFieldName }" size="${ size }" value="${ config.initialValue ?: "" }"/>
<% } %>

<span id="${ config.id }-error" class="error" style="display: none"></span>

<% if (config.parentFormId) { %>
<script>
    FieldUtils.defaultSubscriptions('${ config.parentFormId }', '${ config.formFieldName }', '${ config.id }');
    jq(function() {
    	jq('#${ config.id }').keyup(function() {
    		publish('${ config.parentFormId }/changed');
    	});
    });
</script>
<% } %>