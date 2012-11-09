<% ui.decorateWith("uilibrary", "standardPage") %>

<div style="float: right; width: 33%">
	<fieldset>
		<legend>Infobox</legend>
		${ ui.includeFragment("uilibrary", "infobox", [id: "infobox"]) }
	</fieldset>
</div>

<fieldset>
	<legend>Encounter Field</legend>
	
	${ ui.includeFragment("uilibrary", "widget/labeledField", [ label: "Choose an Encounter", class: "org.openmrs.Encounter", formFieldName: "encId" ]) }
	<input type="button" id="showEncounterButton" value="Show Encounter in Infobox"/>
</fieldset>
	 

Add more examples here.

<script>
    jq(function() {
        jq('#showEncounterButton').click(function() {
        	infobox.showEncounter(jq('input[name=encId]').val());
        });
    });
</script>