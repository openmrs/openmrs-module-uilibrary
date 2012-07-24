<%
config.require("formFieldName", "options", "optionsValueField", "optionsDisplayField")
// supports includeEmptyOption
// supports emptyOptionLabel
// supports multiple & size
// supports selected

def emptyOptionLabel = config.emptyOptionLabel ?: ""
%>
<select id="${ config.id }" name="${ config.formFieldName }" ${ config.multiple ? 'multiple' : '' } <% if (config.size) { %>size="${config.size}"<% } %>>

    <%  if (config.includeEmptyOption) { %>
        <option value="">${ emptyOptionLabel }</option>
    <% } %>

    <% config.options.each { %>
    <option value="${ it[config.optionsValueField] }"
        ${ config.selected?.contains(it[config.optionsValueField]) ? 'selected' : ''}
    >${ ui.format(it[config.optionsDisplayField]) }</option>
    <% } %>

</select>