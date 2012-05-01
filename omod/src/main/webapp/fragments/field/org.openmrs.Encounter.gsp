<script>
function formatEncounter(encounter) {
	return encounter.encounterType + ' @' + encounter.location + ' @' + encounter.encounterDatetime;
}
</script>

<%= ui.includeFragment("widget/autocomplete", [
	id: config.id,
	initialValue: config.initialValue,
	formFieldName: config.formFieldName,
	visibleFieldId: config.visibleFieldId,
	source: ui.actionLink("data", "findEncounters"),
	labelFunction: "formatEncounter",
	valueFunction: "function(encounter) { return encounter.encounterId }",
	size: 60
]) %>

<span id="${ config.id }-error" class="error" style="display: none"></span>

<% /* TODO copy and refactor if (config.parentFormId) section from prior implementation */ %>