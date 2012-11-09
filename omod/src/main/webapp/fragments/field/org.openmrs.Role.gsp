<% ui.includeJavascript("uilibrary", "coreFragments.js") %>

<%= ui.includeFragment("uilibrary", "widget/selectList", [
		id: config.id,
        selected: [ config.initialValue?.role ],
        formFieldName: config.formFieldName,
        options: context.getUserService().getAllRoles(),
        optionsDisplayField: 'name',
        optionsValueField: 'role',
        includeEmptyOption: true
]) %>

<span id="${ config.id }-error" class="error" style="display: none"></span>
    
<% if (config.parentFormId) { %>
	<script>
	    FieldUtils.defaultSubscriptions('${ config.parentFormId }', '${ config.formFieldName }', '${ config.id }');
	    jq(function() {
	    	jq('#${ config.id }').change(function() {
	    		publish('${ config.parentFormId }/changed');
	    	});
	    });
	</script>
<% } %>