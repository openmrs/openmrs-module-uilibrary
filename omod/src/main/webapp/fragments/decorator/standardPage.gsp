${ ui.includeFragment("uilibrary", "standardIncludes") }

<% if (config.beforeContent) { %>${ config.beforeContent }<% } %>

${ ui.includeFragment("uilibrary", "flashMessage") }

<div id="content">
	<%= config.content %>
</div>