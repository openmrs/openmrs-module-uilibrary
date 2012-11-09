<%
	def id = config.id ?: ui.randomId("infobox")
	
	ui.includeCss("uilibrary", "jquery-ui.css")
	ui.includeJavascript("uilibrary", "jquery.js")
	ui.includeJavascript("uilibrary", "jquery-ui.js")
%>

<script>
// TODO rewrite this and move it to the static js file
function Infobox(id) {
	var rootId = id;
	
	jQuery('#' + rootId)
		.addClass('ui-widget ui-widget-content ui-corner-all')
		.html('<div class="title ui-widget-header ui-corner-all"><img src="${ ui.resourceLink("uilibrary", "images/info_16.png") }"/>Info Box</div><div class="content"></div>');
	
	this.setTitle = function(html) {
		jQuery('#' + rootId + ' > .title').html(html);
	};
	
	this.setContent = function(html) {
		jQuery('#' + rootId + ' > .content').html(html);
	};
	
	this.showEncounter = function(encounter) {
		if (typeof encounter == 'number' || typeof encounter == 'string') {
			var that = this;
			getFragmentActionAsJson('data', 'getEncounter', { encounterId: encounter }, function(enc) {
				that.showEncounter(enc);
			});
			return;
		}
		
		var title = encounter.encounterType + '<br/>';
		title += 'Date: ' + encounter.encounterDatetime + '<br/>';
		title += 'Location: ' + encounter.location + '<br/>';
		this.setTitle(title);
		
		var content = '<table>';
		for (var i = 0; i < encounter.obs.length; ++i) {
			content += '<tr><td class="small">' + encounter.obs[i].concept + ':</td><td>' + encounter.obs[i].value + '</td></tr>';
		}
		content += '</table>';
		this.setContent(content);
	};
}
</script>

<div id="${ id }"></div>

<script>
	var ${ id } = new Infobox('infobox');
</script>