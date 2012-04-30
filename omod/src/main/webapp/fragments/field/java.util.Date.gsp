<%
    def id = config.visibleFieldId ?: ui.randomId('field')
%>

<script>
    \$(document).ready(function() {
        \$('#${ id }').datepicker({
            <% if (config.required) { %>
            onClose: function(dateText, inst) { clearErrors('${ id }_error'); validateRequired(dateText, '${ id }_error'); }
            <% } %>
        });
    });
</script>

<input id="${ id }" type="text" name="${ config.formFieldName }" value="${ config.initialValue ?: "" }" />
<span id="${ id }_error" class="error" style="display: none"></span>