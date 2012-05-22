<%
    String err = session.getAttribute(org.openmrs.ui.framework.WebConstants.OPENMRS_ERROR_ATTR, String.class);
    if (err) {
        session.setAttribute(org.openmrs.ui.framework.WebConstants.OPENMRS_ERROR_ATTR, null);
    }
    String msg = session.getAttribute(org.openmrs.ui.framework.WebConstants.OPENMRS_MSG_ATTR, String.class);
    if (msg) {
        session.setAttribute(org.openmrs.ui.framework.WebConstants.OPENMRS_MSG_ATTR, null);
    }
%>

<div id="errors" <% if (!err) { %>style="display: none"<% } %>>
    <div id="error-message" style="float: left">
        <% if (err) { %>${ err }<% } %>
    </div>
    <div style="clear: both"></div>
</div>

<div id="flash" <% if (!msg) { %>style="display: none"<% } %>>
    <div id="flash-message" style="float: left">
        <% if (msg) { %>${ msg }<% } %>
    </div>
    <div style="clear: both"></div>
</div>
