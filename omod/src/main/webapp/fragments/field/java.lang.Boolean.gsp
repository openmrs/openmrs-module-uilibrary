<%
    ui.includeJavascript("uilibrary", "coreFragments.js")
%>

<input type="radio" name="${ config.formFieldName }" value="true" id="${ config.id }-true" <% if (config.initialValue) { %>checked="true"<% } %>/>
<label for="${ config.id }-true">Yes</label>
&nbsp;
<input type="radio" name="${ config.formFieldName }" value="false" id="${ config.id }-false" <% if (!config.initialValue) { %>checked="true"<% } %>/>
<label for="${ config.id }-true">No</label>

<span id="${ config.id }-error" class="error" style="display: none"></span>
    
<% if (config.parentFormId) { %>
<script>
    FieldUtils.defaultSubscriptions('${ config.parentFormId }', '${ config.formFieldName }', '${ config.id }');
    jq(function() {
    	jq('#${ config.id }-true, #${ config.id }-false').change(function() {
    		publish('${ config.parentFormId }/changed');
    	});
    });
</script>
<% } %>