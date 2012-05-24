${ ui.includeFragment("standardIncludes") }

<% if (config.beforeContent) { %>${ config.beforeContent }<% } %>

${ ui.includeFragment("flashMessage") }

<div id="content">
	<%= config.content %>
</div>