// we will migrate functionality from uiframework.js into here, refactoring it as we go 
var ui = (function($) {

	return {
		
		/*
		 * Takes an existing <form> element and sets it up to submit via AJAX and get a json response.
		 * 
		 * onSuccess is required, and should should be a one-arg function that called with a parsed json object
		 * 
		 * onError is optional and should be a one-arg function that is called with a jqXHR object.
		 * if unspecified, the default behavior is to try to show field errors in .error and .global-error elements.
		 */
		setupJsonPost: function(formSelector, onSuccess, onError) {
			$(formSelector).submit(function(event) {
				event.preventDefault();
				var form = $(this);

				// find error fields (and clear them)
				var globalError = form.find('.global-error').html('').hide();
				form.find('.error').html('').hide();
				
				if (typeof onError !== 'function') {
					onError = function(xhr) {
						try {
							var err = $.parseJSON(xhr.responseText);
							for (var i = 0; i < err.globalErrors.length; ++i) {
								globalError.append(err.globalErrors[i] + '<br/>').show();
							}
							for (key in err.fieldErrors) {
								var errorMsg =  err.fieldErrors[key].join(', ');
								var errorField = form.find('input[name="' + key + '"]').nextAll('.error');
								if (errorField.length == 0) {
									errorField = globalError;
								}
								errorField.append(errorMsg + '<br/>').show();
							}
						} catch (ex) {
							notifyError("Failed " + xhr.responseText);
						}
					}
				}
				
				// POST and get back the result as JSON
				$.post(form.attr('action'), form.serialize(), onSuccess, "json").error(onError);
			});
		}
	
	};

})(jQuery);