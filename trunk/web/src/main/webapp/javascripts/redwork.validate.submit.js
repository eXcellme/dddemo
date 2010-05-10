(function($){
	$.fn.redworkSubmit = function(settings){
		
		var debug = false; function log(message){if(!debug)return;console.log(message);}
		
		var form = this;
		
		// init config params
		var config = {
		};

		if (settings) jQuery.extend(config, settings);
		
		$(form.selector + " .submit").click(validate);
		
		function validate(){
			$.ajax({
				url: settings.url,
				type: "GET",
				dataType: "json",
				data: form.serialize(),
				complete: function(data, textStatus){
					var text = data.responseText;
					var errorsObject = StrutsUtils.getValidationErrors(text);
     
				    //show errors, if any
				    if(errorsObject && errorsObject.fieldErrors) {
				    	// collect errors
				    	var errorMap = {};
				    	$.each(errorsObject.fieldErrors, function(i, n){
				       		errorMap[i] = n[0];
				    	});
				    	
				    	form.validate().showErrors(errorMap);
				    	//$("#form input[name='" + i + "']").css("border", "red 2px solid");
					} else {
				    	if($.isFunction(config.success))
				    		config.success();
				    	else
				    		form.trigger("form-success");
				    }
				 } // complete
			});
		}// validate
	};
})(jQuery);