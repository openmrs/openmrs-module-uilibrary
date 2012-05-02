<script>
    \$(document).ready(function() {
        \$('#${ config.id }').datepicker({
            <% if (config.required) { %>
            onClose: function(dateText, inst) { clearErrors('${ config.id }-error'); validateRequired(dateText, '${ config.id }-error'); }
            <% } %>
        });
    });
</script>

<input id="${ config.id }" type="text" name="${ config.formFieldName }" value="${ config.initialValue ?: "" }" />
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