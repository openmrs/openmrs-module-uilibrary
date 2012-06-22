<%
config.require("formFieldName", "options", "optionsValueField", "optionsDisplayField")
// supports selected
// supports separator (defaults to "<br/>")

def separator = config.separator ?: "<br/>"
%>

<% config.options.each {
	def id = ui.randomId("radio")
	def selected = config?.selected?.contains(it[config.optionsValueField])
%>
	<input type="radio"
		id="${ id }" name="${ config.formFieldName }"
		value="${ ui.escapeAttribute(it[config.optionsValueField].toString()) }"
		<% if (selected) { %> checked="true" <% } %>
	/>
	<label for="${ id }">${ it[config.optionsDisplayField] }</label>
	${ separator }
<% } %>