<%
// supports config.options (will use an autocomplete)
// supports config.size
// supports config.type = textarea, config.type=password, config.rows, config.cols

	ui.includeJavascript("uilibrary", "coreFragments.js")
%>
<% if (config?.config?.options) { %>
    ${ ui.includeFragment("uilibrary", "widget/selectList", [
            id: config.id,
            formFieldName: config.formFieldName,
            options: config.config.options,
            optionsValueField: 'value',
            optionsDisplayField: 'label',
            selected: config.initialValue,
            includeEmptyOption: true
        ]) }

<% } else if (config?.config?.type == 'textarea') {
	def rows = config?.config?.rows ?: 5
	def cols = config?.config?.cols ?: 40
%>
	<textarea id="${ config.id }" name="${ config.formFieldName }" rows="${ rows }" cols="${ cols }">${ config.initialValue ?: "" }</textarea>
	
<% } else {
	def size = config?.config?.size ?: 40
	def inputType = config?.config?.type == "password" ? "password" : "text"
%>
	<input id="${ config.id }" type="${ inputType }" name="${ config.formFieldName }" size="${ size }" value="${ config.initialValue ?: "" }"/>
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