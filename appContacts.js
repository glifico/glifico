//app.js

(function() {

	'use strict';

	var app = angular.module('contactsApp', ['formly', 'ngMessages', 'formlyMaterial','ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular']);
	app.controller("MainController_contacts",function MainController_contacts(){
		var ctrl = this;

		ctrl.fields=[
			{
				className : "row",
				fieldGroup : [{
					key : "FirstName",
					type : 'input',
					templateOptions : {
						label: "First Name",
						required: true
					}
				}]
			},
			{
				className : "row",
				fieldGroup : [{
					key : "Email",
					type : 'input',
					templateOptions : {
						label: "Your email",
						required: true
					},
					validators: {
						emailValidator: function($viewValue, $modelValue, scope) {
							var value = $modelValue || $viewValue;
							if(value) {
								return /[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.+[a-z]{2,3}/g.test(value)
							}
						}
					}
				}]
			},
			{
				className : "row",
				fieldGroup : [{
					key : "Subject",
					type : 'input',
					templateOptions : {
						label: "Subject",
						required: false
					}
				}]
			},
			{
				className : "row",
				fieldGroup : [{
					key : "Message",
					type : 'textarea',
					templateOptions : {
						label: "Your message",
						required: true,
						rows:4,
						placeholder: "Write here your message..."
					}
				}]
			}
			];

		ctrl.submit= function(){
			sendMessage();
			alert("Your message has been sent");
			location.href=location.href;
		};

		function sendMessage(){
			var req = createXHTMLHttpRequest() ;
			req.onreadystatechange = function(){
				if (req.status == 200){
					return(true);
				}else{
					mostraDialogTimed('errorPanel');
					return(false);
				}
			};

			req.open("GET", "https://glifico.herokuapp.com/message.php"+"?"+
					"name="+ctrl.model["FirstName"]+
					"&subject="+ctrl.model["Subject"]+
					"&message="+ctrl.model["Message"]+
					"&email="+ctrl.model["Email"]
			, true);
			req.send();
		};


	});

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
	});



})();
