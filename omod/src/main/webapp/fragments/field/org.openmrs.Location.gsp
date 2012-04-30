
<%= ui.includeFragment("widget/selectList", [
        selected: [config.initialValue],
        formFieldName: config.formFieldName,
        options: context.getLocationService().getAllLocations(),
        optionsDisplayField: 'name',
        optionsValueField: 'id'
]) %>