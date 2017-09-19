/**
 * Transl
 */

(function() {

	'use strict';

	var app = angular.module('regTrad', ['formly', 'ngMessages', 'formlyMaterial','ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular']);
	app.constant('formlyExampleApiCheck', apiCheck());
	app.run(function(formlyConfig) {
		// NOTE: This next line is highly recommended. Otherwise Chrome's autocomplete will appear over your options!
		formlyConfig.extras.removeChromeAutoComplete = true;

		// Configure custom types
		formlyConfig.setType({
			name: 'ui-select-single',
			'extends': 'select',
			templateUrl: 'ui-select-single.html'
		});
		formlyConfig.setType({
			name: 'ui-select-multiple',
			'extends': 'select',
			templateUrl: 'ui-select-multiple.html'
		});
		formlyConfig.setType({
			name: 'ui-tagging',
			'extends': 'select',
			templateUrl: 'ui-tagging.html'
		});
		formlyConfig.setType({
			name: 'ui-tagging-single',
			'extends': 'select',
			templateUrl: 'ui-tagging-single.html'
		});

		formlyConfig.setType({
			name: 'richEditor',
			template: '<text-angular ng-model="model[options.key]" ta-disabled="{{to.disabled}}"></text-angular>'
		});

//		INIZIO BLOCCO VALIDAZIONE CAMPO FIELDTOMATCH
		formlyConfig.setType({
			name: 'matchField',
			apiCheck: function() {
				return {
					data: {
						fieldToMatch: formlyExampleApiCheck.string
					}
				}
			},
			apiCheckOptions: {
				prefix: 'matchField type'
			},
			defaultOptions: function matchFieldDefaultOptions(options) {
				return {
					extras: {
						validateOnModelChange: true
					},
					expressionProperties: {
						'templateOptions.disabled': function(viewValue, modelValue, scope) {
							var matchField = find(scope.fields, 'key', options.data.fieldToMatch);
							if (!matchField) {
								throw new Error('Could not find a field for the key ' + options.data.fieldToMatch);
							}
							var model = options.data.modelToMatch || scope.model;
							var originalValue = model[options.data.fieldToMatch];
							var invalidOriginal = matchField.formControl && matchField.formControl.$invalid;
							return !originalValue || invalidOriginal;
						}
					},
					validators: {
						fieldMatch: {
							expression: function(viewValue, modelValue, fieldScope) {
								var value = modelValue || viewValue;
								var model = options.data.modelToMatch || fieldScope.model;
								return value === model[options.data.fieldToMatch];
							},
							message: options.data.matchFieldMessage || '"Must match"'
						}
					}
				};

				function find(array, prop, value) {
					var foundItem;
					array.some(function(item) {
						if (item[prop] === value) {
							foundItem = item;
						}
						return !!foundItem;
					});
					return foundItem;
				}
			}
		});
//		FINE BLOCCO VALIDAZIONE CAMPO FIELDTOMATCH
	});
})();



( function() {

	'use strict';

	angular.module('regTrad').controller('MainController_regTrad',
			[ '$http','$timeout', MainController_regTrad ]);

	function MainController_regTrad($http,$timeout) {
		var vmMainController_regTrad = this;
//		$http.get('rest.xsp?api=newMail').success( function(data) {

//		});
		vmMainController_regTrad.fields = [ {
			className : "row",
			fieldGroup : [{
				className : "col-md-6",
				key : "FirstName",
				type : 'input',
				templateOptions : {
					label: "First Name",
					required: true
				}
			},{
				className : "col-md-6",
				key : "LastName",
				type : 'input',
				templateOptions : {
					label: "Last Name",
					required: true
				}
			},{
				className : "col-md-12",
				key : "VATCode",
				type : 'input',
				templateOptions : {
					label: "VAT Code/Fiscal Code",
					required: false
				}
			},{
				className : "col-md-12",
				key : "Email",
				type : 'input',
				templateOptions : {
					label: "Email",
					required: true
				}
			},{
				className : "col-md-12",
				key : "Username",
				type : 'input',
				templateOptions : {
					label: "Username",
					required: true,
					placeholder: "Must be at least 7 characters",
					minlength: 7,
					onKeydown: function(value, options) {
						options.validation.show = false;
					}
				}
			},{
				className : "col-md-12",
				key : "Password",
				type : 'input',
				templateOptions : {
					type : "password",
					label: "Password",
					required: true,
					placeholder: "Must be at least 7 characters",
					minlength: 7
				}
			},{
				className : "col-md-12",
				key : "RepeatPassword",
				type : 'input',
				optionsTypes: [
					"matchField"
					],
					model: vmMainController_regTrad.confirmationModel,
					templateOptions : {
						type: "password",
						label: "Repeat Password",
						"placeholder": "Please re-enter your password",
						required: true
					},
					data: {
						fieldToMatch: "Password",
						modelToMatch: vmMainController_regTrad.model
					}
			}
			]
		}];

		function storeTranslatorInfos(model){
			console.log(model);
			var req = createXHTMLHttpRequest();
			req.onreadystatechange = function(){
				if (req.status == 200&&JSON.parse(req.responseText)["statuscode"]==200){
					console.log("user created");
				}
			}
			req.open("GET", "https://glifico.herokuapp.com/storeTranslator.php"+"?user="+vmMainController_regTrad.model["Username"]+
					"&user="+vmMainController_regTrad.model["Username"]+
					"&name="+vmMainController_regTrad.model["FirstName"]+
					"&lastname="+vmMainController_regTrad.model["LastName"]+
					"&password="+vmMainController_regTrad.model["Password"]
					, false);
			req.send();
		};

		vmMainController_regTrad.submit = function() {
			var req = createXHTMLHttpRequest() ;
			req.onreadystatechange = function(){
				if (req.status == 200){
					$('#alertOK').fadeIn().delay(10000)
					.fadeOut();
					$('#alertOK').html(
					"Thanks. We have sent you an email with a confirmation link.");
					$("#loginModal").hide();
					location.href="index.html"
						return(true);
				}else{
					mostraDialogTimed('errorPanel');
					return(false);
				}
			};

			req.open("GET", "https://glifico.herokuapp.com/confirmmail.php"+"?to="+vmMainController_regTrad.model["Email"] , false);
			req.send();
			storeTranslatorInfos(vmMainController_regTrad.model);
		}

	}

})();


angular.element(document).ready(function() {
	console.log("registro regTrad");
	angular.bootstrap(document.getElementById('regTradAPP'), ['regTrad']);
});


/**
 * Agency
 */

(function() {

	'use strict';

	var app = angular.module('regAge', ['formly', 'ngMessages', 'formlyMaterial','ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular']);
	app.constant('formlyExampleApiCheck', apiCheck());
	app.run(function(formlyConfig) {
		// NOTE: This next line is highly recommended. Otherwise Chrome's autocomplete will appear over your options!
		formlyConfig.extras.removeChromeAutoComplete = true;

		// Configure custom types
		formlyConfig.setType({
			name: 'ui-select-single',
			'extends': 'select',
			templateUrl: 'ui-select-single.html'
		});
		formlyConfig.setType({
			name: 'ui-select-multiple',
			'extends': 'select',
			templateUrl: 'ui-select-multiple.html'
		});
		formlyConfig.setType({
			name: 'ui-tagging',
			'extends': 'select',
			templateUrl: 'ui-tagging.html'
		});
		formlyConfig.setType({
			name: 'ui-tagging-single',
			'extends': 'select',
			templateUrl: 'ui-tagging-single.html'
		});

		formlyConfig.setType({
			name: 'richEditor',
			template: '<text-angular ng-model="model[options.key]" ta-disabled="{{to.disabled}}"></text-angular>'
		});

//		INIZIO BLOCCO VALIDAZIONE CAMPO FIELDTOMATCH
		formlyConfig.setType({
			name: 'matchField',
			apiCheck: function() {
				return {
					data: {
						fieldToMatch: formlyExampleApiCheck.string
					}
				}
			},
			apiCheckOptions: {
				prefix: 'matchField type'
			},
			defaultOptions: function matchFieldDefaultOptions(options) {
				return {
					extras: {
						validateOnModelChange: true
					},
					expressionProperties: {
						'templateOptions.disabled': function(viewValue, modelValue, scope) {
							var matchField = find(scope.fields, 'key', options.data.fieldToMatch);
							if (!matchField) {
								throw new Error('Could not find a field for the key ' + options.data.fieldToMatch);
							}
							var model = options.data.modelToMatch || scope.model;
							var originalValue = model[options.data.fieldToMatch];
							var invalidOriginal = matchField.formControl && matchField.formControl.$invalid;
							return !originalValue || invalidOriginal;
						}
					},
					validators: {
						fieldMatch: {
							expression: function(viewValue, modelValue, fieldScope) {
								var value = modelValue || viewValue;
								var model = options.data.modelToMatch || fieldScope.model;
								return value === model[options.data.fieldToMatch];
							},
							message: options.data.matchFieldMessage || '"Must match"'
						}
					}
				};

				function find(array, prop, value) {
					var foundItem;
					array.some(function(item) {
						if (item[prop] === value) {
							foundItem = item;
						}
						return !!foundItem;
					});
					return foundItem;
				}
			}
		});
//		FINE BLOCCO VALIDAZIONE CAMPO FIELDTOMATCH
	});
})();




( function() {

	'use strict';

	angular.module('regAge').controller('MainController_regAge',
			[ '$http','$timeout', MainController_regAge ]);

	function MainController_regAge($http,$timeout) {
		var vmMainController_regAge = this;
//		$http.get('rest.xsp?api=newMail').success( function(data) {

//		});
		vmMainController_regAge.fields = [ {
			className : "row",
			fieldGroup : [{
				className : "col-md-12",
				key : "CompanyName",
				type : 'input',
				templateOptions : {
					label: "Company Name",
					required: true
				}
			},{
				className : "col-md-12",
				key : "FiscalCode",
				type : 'input',
				templateOptions : {
					label: "Fiscal Code",
					required: false
				}
			},{
				className : "col-md-12",
				key : "VATCode",
				type : 'input',
				templateOptions : {
					label: "VAT Code",
					required: false
				}
			},{
				className : "col-md-12",
				key : "Email",
				type : 'input',
				templateOptions : {
					label: "Email",
					required: true
				}
			},{
				className : "col-md-12",
				key : "Username",
				type : 'input',
				templateOptions : {
					label: "Username",
					required: true,
					placeholder: "Must be at least 7 characters",
					minlength: 7,
					onKeydown: function(value, options) {
						options.validation.show = false;
					}
				}
			},{
				className : "col-md-12",
				key : "Password",
				type : 'input',
				templateOptions : {
					type : "password",
					label: "Password",
					required: true,
					placeholder: "Must be at least 7 characters",
					minlength: 7
				}
			},{
				className : "col-md-12",
				key : "RepeatPassword",
				type : 'input',
				optionsTypes: [
					"matchField"
					],
					model: vmMainController_regAge.confirmationModel,
					templateOptions : {
						type: "password",
						label: "Repeat Password",
						"placeholder": "Please re-enter your password",
						required: true
					},
					data: {
						fieldToMatch: "Password",
						modelToMatch: vmMainController_regAge.model
					}
			},
			]}
		];
		vmMainController_regAge.submit = function() {
			$http
			.post('rest.xsp?api=save&type=registraAgenzia&id=0', vmMainController_regAge.model)
			.success(
					function(data) {
						var ret = eval(data);
						if (ret == undefined || ret[0] == undefined
								|| ret[0].data == undefined) {
							$('#alertError').fadeIn().delay(10000)
							.fadeOut();
							$('#alertError')
							.html(
							"Si è verificato un errore inaspettato");
						} else if (ret[0].data.status != undefined
								&& ret[0].data.status.toLowerCase() == "error") {
							$('#alertError').fadeIn().delay(10000)
							.fadeOut();
							if (ret[0].data.msg == undefined
									|| ret[0].data.msg == "") {
								$('#alertError').html(
								"Si è verificato un errore.");
							} else {
								var stringval=ret[0].data.msg
								if(stringval.indexOf("Cannot insert duplicate key") != -1){
									var errorField = strRight(ret[0].data.msg,"Index:");
									errorField = strLeft(errorField,"_Unique");
									$('#alertError').html(errorField + " already exist. If you have lost your password use password recovery function.");
								}else{
									$('#alertError').html(ret[0].data.msg);
								}
							}
						} else {
							$('#alertOK').fadeIn().delay(10000)
							.fadeOut();
							$('#alertOK').html(
							"Thanks. We have sent you an email with a confirmation link.");
						}
						$('#loginModal').modal('hide');
					});
		}
	}

})();

angular.element(document).ready(function() {
	console.log("registro regAge");
	angular.bootstrap(document.getElementById('regAgeAPP'), ['regAge']);
});    