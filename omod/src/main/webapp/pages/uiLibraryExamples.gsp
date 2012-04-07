<% ui.decorateWith("standardPage") %>

<div style="float: right; width: 33%">
	${ ui.includeFragment("infobox", [id: "infobox"]) }
</div>

Add more examples here.

<script>
    jq(function() {
    	jQuery.getJSON('${ ui.actionLink('data', 'getEncounter', [encounterId: 3]) }', function(encounter) {
    		infobox.showEncounter(encounter);
    	});
    });
</script>