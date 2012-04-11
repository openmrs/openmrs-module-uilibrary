<% if (config.label) { %>
    <label <% if (config.visibleFieldId) { %>for="${ config.visibleFieldId }"<% } %> class="field-label">
        ${config.label}
    </label>
    <span class="field-content">
<% } %>

${ config.content }

<% if (config.label) { %>
    </span>
<% } %>