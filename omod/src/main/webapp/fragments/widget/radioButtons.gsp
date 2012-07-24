<%
config.require("formFieldName", "options")
// supports optionsValueField (defaults to "value")
// supports optionsDisplayField (defaults to "label")
// supports selected
// supports separator (defaults to "<br/>")
// supports onChange (javascript function to be executed when any of the radio buttons change)

def optionsValueField = config.optionsValueField ?: "value"
def optionsDisplayField = config.optionsDisplayField ?: "label"
def separator = config.separator ?: "<br/>"
%>

<span id="${ config.id }">
<% config.options.each {
	def id = ui.randomId("radio")
	def selected = config?.selected?.contains(it[optionsValueField])
%>
	<input type="radio"
		id="${ id }" name="${ config.formFieldName }"
		value="${ ui.escapeAttribute(it[optionsValueField].toString()) }"
		<% if (selected) { %> checked="true" <% } %>
	/>
	<label for="${ id }">${ it[optionsDisplayField] }</label>
	${ separator }
<% } %>
</span>

<% if (config.onChange) { %>
<script>
	jq(function() {
		jq('#${ config.id } > input').change(${ config.onChange });
	});
</script>
<% } %>