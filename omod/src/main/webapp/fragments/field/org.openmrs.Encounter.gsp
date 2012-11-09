<script>
function formatEncounter(encounter) {
	return encounter.encounterType + ' @' + encounter.location + ' @' + encounter.encounterDatetime;
}
</script>

<%= ui.includeFragment("uilibrary", "widget/autocomplete", [
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

<% if (config.parentFormId) { %>
<script>
    FieldUtils.defaultSubscriptions('${ config.parentFormId }', '${ config.formFieldName }', '${ config.id }');
    jq(function() {
    	jq('#${ config.id }').change(function() {
    		publish('${ config.parentFormId }/changed');
    	});
    });
</script>
<% } %>