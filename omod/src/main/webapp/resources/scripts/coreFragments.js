var formWidget = {
	handleSubmitError: function(id, jqXHR) {
    	try {
    	    var err = jq.parseJSON(jqXHR.responseText);
    	} catch (ex) {
    		notifyError("form submission failed, and response couldn't be interpreted: " + ex);
    		return;
    	}
	    if (err.globalErrors && err.globalErrors.length > 0) {
    	    var html = "";
    	    for (var i = 0; i < err.globalErrors.length; ++i)
                html += err.globalErrors[i] + "<br/>";
    	    jq('#' + id + '-globalerror').html(html).show();
	    }
        for (key in err.fieldErrors) {
        	publish(id + '/' + key + '.show-errors', err.fieldErrors[key]);
        }
	}
}

var FieldUtils = {
	showErrorList: function(divId, errorList) {
    	var html = "";
        for (var i = 0; i < errorList.length; ++i) {
        	var msg = errorList[i];
        	if (msg == null)
        		msg = "missing error message (programmer error)";
            html += msg + "<br/>";
        }
    	$('#' + divId).html(html).show();
	},

	defaultSubscriptions: function(formId, formFieldName, fieldId) {

		// Save default field value
		$('#' + fieldId).data('default-value', $('#' + fieldId).val());

		// On form reset, set field to it's default value
		subscribe(formId + '.reset', function() {
		    $('#' + fieldId).val($('#' + fieldId).data('default-value'));
		    $('#' + fieldId + '-error').html("").hide();
		});
		subscribe(formId + '.clear-errors', function() {
		    $('#' + fieldId + '-error').html("").hide();
		});
		subscribe(formId + '/' + formFieldName + '.show-errors', function(message, payload) {
		    FieldUtils.showErrorList(fieldId + '-error', payload);
		});
	}
}