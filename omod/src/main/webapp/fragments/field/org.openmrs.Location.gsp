
<%= ui.includeFragment("uilibrary", "widget/selectList", [
        selected: [ config.initialValue?.id ],
        formFieldName: config.formFieldName,
        options: context.getLocationService().getAllLocations(),
        optionsDisplayField: 'name',
        optionsValueField: 'id',
        includeEmptyOption: true
]) %>

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