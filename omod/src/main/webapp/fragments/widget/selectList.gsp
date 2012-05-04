
<select name="${ config.formFieldName }" ${ config.multiple ? 'multiple' : '' } <% if (config.size) { %>size="${config.size}"<% } %>>

    <%  if (config.includeEmptyOption) { %>
        <option value=""/>
    <% } %>

    <% config.options.each { %>
    <option value="${ it[config.optionsValueField] }"
        ${ config.selected?.contains(it[config.optionsValueField]) ? 'selected' : ''}
    >${ it[config.optionsDisplayField] }</option>
    <% } %>

</select>