// we will migrate functionality from uiframework.js into here, refactoring it as we go 
var ui = (function($) {

	var setupAjaxPostDefaults = {
		dataType: "json",
		globalErrorContainer: ".global-error-container",
		globalErrorContent: ".global-error-content",
		onError: function(xhr, form, globalError) {
			try {
				var err = $.parseJSON(xhr.responseText);
				for (var i = 0; i < err.globalErrors.length; ++i) {
					globalError.append('<li>' + err.globalErrors[i] + '</li>');
				}
				for (key in err.fieldErrors) {
					var errorMsg =  err.fieldErrors[key].join(', ');
					var errorField = form.find('input[name="' + key + '"]').nextAll('.error');
					if (errorField.length == 0) {
						globalError.append('<li>' + errorMsg + '</li>');
					} else {
						errorField.append(errorMsg + '<br/>').show();
					}
				}
			} catch (ex) {
				notifyError("Failed " + ex + " (" + xhr.responseText + ")");
			}
		}
	}
	
	return {
		
		/*
		 * Takes an existing <form> element and sets it up to submit via AJAX and get a json response.
		 * 
		 * options:
		 * - onSuccess (required) should should be a one-arg function that called with a parsed json object
		 * - onError (optional) should a function(jqXHR, form, globalErrorContent). Defaults to trying to show field errors in .error and globalErrorContent elements.
		 * - dataType (default "json") should be a string representing the datatype of the returned data
		 * - globalErrorContainer (default ".global-error-container")
		 * - globalErrorContent (default ".global-error-content")
		 */
		setupAjaxPost: function(formSelector, options) {
			if (typeof options.onSuccess !== 'function') {
				throw "onSuccess is required";
			}
			
			var opts = $.extend({}, setupAjaxPostDefaults, options);
			
			$(formSelector).submit(function(event) {
				event.preventDefault();
				var form = $(this);

				// find error fields (and clear them)
				var globalError = form.find(opts.globalErrorContent).html('');
				var globalErrorContainer = form.find(opts.globalErrorContainer).hide();
				form.find('.error').html('').hide();
				
				// POST and get back the result as JSON
				$.post(form.attr('action'), form.serialize(), opts.onSuccess, opts.dataType).error(function(xhr) {
					globalErrorContainer.show();
					opts.onError(xhr, form, globalError);
				});
			});
		},
		
		applyAlternatingClasses: function(selector, first, second) {
			if (typeof first === 'string') {
				$(selector).children(':even').addClass(first);
			}
			if (typeof second === 'string') {
				$(selector).children(':odd').addClass(second);
			}
		},
		
		resourceLink: function(providerName, resourceName) {
			if (providerName == null)
				providerName = '*';
			return '/' + OPENMRS_CONTEXT_PATH + '/ms/uiframework/resource/' + providerName + '/' + resourceName; 
		},
		
		reloadPage: function() {
			var html = '<div id="reload-page-spinner"><img src="' + this.resourceLink('uilibrary', 'images/loading.gif') + '"/></div>';
			$('#content').append(html);
			location.href = location.href;
		}
	};

})(jQuery);