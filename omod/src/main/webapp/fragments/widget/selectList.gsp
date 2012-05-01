
<select name="${ config.formFieldName }" ${ config.multiple ? 'multiple' : '' }>
    <% config.options.each { %>
    <option value="${ it[config.optionsValueField] }"
        ${ config.selected?.contains(it[config.optionsValueField]) ? 'selected' : ''}
    >${ it[config.optionsDisplayField] }</option>
    <% } %>
</select>