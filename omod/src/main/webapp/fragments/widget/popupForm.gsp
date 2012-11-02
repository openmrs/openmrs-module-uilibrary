<%
	config.require("buttonConfig | linkConfig", "popupTitle")
	// config should be like the config of widget/form plus a buttonConfig, which is passed to widget/button (or linkConfig for widget/link)
	
	// config supports dialogOpts (will be passed as opts to showDivAsDialog)
	
	def id = config.id ?: ui.randomId("popupForm")
	config.id = id

	config.cancelFunction = "closeDialog"
    
	def closeCallback = "closeDialog(false);"
	if (config.successCallbacks)
		config.successCallbacks << closeCallback
	else
		config.successCallbacks = [ closeCallback ]
	
	def onClick = """
		showDivAsDialog('#${ config.id }_form', '${ ui.escapeJs(config.popupTitle) }', ${ config.dialogOpts });
		ui.confirmBeforeNavigating('#${ config.id }_form'); 
	"""
%>

<% if (config.buttonConfig) {
	config.buttonConfig.onClick = onClick
%>
	${ ui.includeFragment("uilibrary", "widget/button", config.buttonConfig) }
<% } else {
	config.linkConfig.onClick = onClick
%>
	${ ui.includeFragment("uilibrary", "widget/link", config.linkConfig) }
<% } %>

<div id="${ id }_form" style="display: none">
    ${ ui.includeFragment("uilibrary", "widget/form", config) }
</div>