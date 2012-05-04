${ ui.includeFragment("standardIncludes") }

<% if (config.beforeContent) {%>${ config.beforeContent }<% } %>

<div id="content">
	<%= config.content %>
</div>