<%
	config.require("formFieldName")
	config.require("source") // (url for remote json call)
	// config supports id (or generates a random one)
	// config supports labelFunction + valueFunction (overrides for standard jquery ui item rendering)
	// config supports disabled (default false)
	// config supports autoFocus (default false)
	// config supports delay (default 100)
	// config supports minLength (default 0)
	// config supports showGetAll (default false, controls whether there's a button for get-all)
	// config supports size (default 20, controls the size of the visible text field)
	// config supports selected (should be a Map or Object with label and value properties)
	
	// TODO consider visibleFieldId in original implementation

	def id = config.id ?: ui.randomId('autocomplete')
	def labelFunction = config.labelFunction ?: 'function(item) { return item.label }'
	def valueFunction = config.valueFunction ?: 'function(item) { return item.value }'
	def showGetAll = config.showGetAll ?: false
	def size = config.size ?: 20
%>

<script>
jq(function() {
	var labelFunction = ${ labelFunction };
	var valueFunction = ${ valueFunction };
	
	jq('#${ config.id }').autocomplete({
		disabled: ${ config.disabled ?: false },
		autoFocus: ${ config.autoFocus ?: false },
		delay: ${ config.delay ?: 100 },
		minLength: ${ config.minLength ?: 0 },
		source: '${ config.source }',
		select: function(event, ui) {
			jq('#${ config.id }_value').val(valueFunction(ui.item));
			jq('#${ config.id }').val(labelFunction(ui.item));
			return false;
		},
		change: function(event, ui) {
		    // TODO improve this so: that if they partially typed something,  
            // * if they left the field blank that's valid, and it sets the hidden value to ""
		    // * if they typed something that matches exactly one option, we select that
		    // * if they typed something that matches 0 or 2+ options, we leave the partial text there, but highlight it as bad
		    // * also change the select event to clear the 'bad' highlight
		    if (!ui.item) {
		        jq('#${ config.id }').val("");
		        jq('#${ config.id }_value').val("");
		    }
		}
	})
	.data('autocomplete')._renderItem = function(ul, item ) {
		return jq('<li></li>')
			.data('item.autocomplete', item)
			.append('<a>' + labelFunction(item) + '</a>')
			.appendTo(ul);
	};
});
</script>

<input type="hidden" name="${ config.formFieldName }" id="${ config.id }_value" <% if (config.selected) { %> value="${ config.selected.value }" <% } %>/>
<input type="text" id="${ config.id }" size="${ size }" <% if (config.selected) { %> value="${ config.selected.label }" <% } %>/>
<% if (showGetAll) { %>
	<a href="javascript:jq('#${ config.id }').autocomplete('search', '').focus();" tabindex="-1">
		<img src="${ ui.resourceLink("uilibrary", "images/search_16.png") }"/>
	</a>
<% } %>