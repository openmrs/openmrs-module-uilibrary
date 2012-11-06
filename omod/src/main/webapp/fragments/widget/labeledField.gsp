<%
	def visibleFieldId = config.visibleFieldId ?: ui.randomId("field")
	config.visibleFieldId = visibleFieldId
	
	ui.decorateWith("uilibrary", "labeled", config)
%>

${ ui.includeFragment("uilibrary", "widget/field", config) }

<% if (config.afterField) { %>
	${ config.afterField }
<% } %>