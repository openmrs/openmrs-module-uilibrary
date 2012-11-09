<%
    ui.includeJavascript("uilibrary", "coreFragments.js")
%>

<input id="${ config.id }" type="text" size="5" name="${ config.formFieldName }" value="${ config.initialValue ?: "" }"
    onBlur="clearErrors('${ config.id }-error'); <% if (config.required) { %>validateRequired(this.value, '${ config.id }-error'); <% } %> validateNumber(this.value, '${ config.id }-error')"/>

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