<%
    ui.includeJavascript("uilibrary", "coreFragments.js")
%>

<script>
	jq(function() {
		jq('#${ config.id }').datepicker({
            dateFormat: 'dd-M-yy',
            altField: '#${ config.id }_hidden',
		    altFormat: 'yy-mm-dd',
		    changeMonth: true,
		    changeYear: true,
		    showButtonPanel: true,
            yearRange: '-110:+5',
		    autoSize: true
			<% if (config.required) { %>
				, onClose: function(dateText, inst) { clearErrors('${ config.id }-error'); validateRequired(dateText, '${ config.id }-error'); }
			<% } %>
            <% if (config.maxDate) { %>
                , maxDate: '${ config.maxDate }'
            <% } %>
            <% if (config.minDate) { %>
                , minDate: '${ config.minDate }'
            <% } %>
		});
	});
</script>

<input id="${ config.id }_hidden" type="hidden" name="${ config.formFieldName }" <% if (config.initialValue) { %>value="${ ui.dateToString(config.initialValue) }"<% } %>/>
<input id="${ config.id }" type="text" <% if (config.initialValue) { %>value="${ ui.format(config.initialValue) }"<% } %>/>
<span id="${ config.id }-error" class="error" style="display: none"></span>


<% if (config.parentFormId) { %>
<script>
	subscribe('${ config.parentFormId }.reset', function() {
		jq('#${ config.id }').datepicker('setDate', null);
	    jq('#${ config.id }-error').html("").hide();
	});
	subscribe('${ config.parentFormId }.clear-errors', function() {
	    jq('#${ config.id }-error').html("").hide();
	});
	subscribe('${ config.parentFormId }/${ config.formFieldName }.show-errors', function(message, payload) {
	    FieldUtils.showErrorList('${ config.id }-error', payload);
	});
	
	jq(function() {
    	jq('#${ config.id }').change(function() {
    		publish('${ config.parentFormId }/changed');
    	});
    });
</script>
<% } %>