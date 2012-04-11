<%
	def visibleFieldId = config.visibleFieldId ?: ui.randomId("field")
	config.visibleFieldId = visibleFieldId
	
	ui.decorateWith("labeled", config)
%>

${ ui.includeFragment("widget/field", config ) }