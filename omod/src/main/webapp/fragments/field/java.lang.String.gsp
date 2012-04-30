<%
    def id = config.visibleFieldId ?: ui.randomId('field')
%>
<% if (config?.config?.type == 'textarea') {
    def rows = config?.config?.rows ?: 5
    def cols = config?.config?.cols ?: 40
%>
<textarea id="${ id }" name="${ config.formFieldName }" rows="${ rows }" cols="${ cols }">${ config.initialValue ?: "" }</textarea>
<% } else {
    def size = config?.propConfig?.size ?: 40
%>
<input id="${ id }" type="text" name="${ config.formFieldName }" size="${ size }" value="${ config.initialValue ?: "" }"/>
<% } %>
