//copied from
//http://ht5ifv.serprest.pt/extensions/tools/IBAN/

function isValidIBAN($v){ //This function check if the checksum if correct
	$v = $v.replace(/^(.{4})(.*)$/,"$2$1"); //Move the first 4 chars from left to the right
	$v = $v.replace(/[A-Z]/g,function($e){return $e.charCodeAt(0) - 'A'.charCodeAt(0) + 10}); //Convert A-Z to 10-25
	var $sum = 0;
	var $ei = 1; //First exponent 
	for(var $i = $v.length - 1; $i >= 0; $i--){
		$sum += $ei * parseInt($v.charAt($i),10); //multiply the digit by it's exponent 
		$ei = ($ei * 10) % 97; //compute next base 10 exponent  in modulus 97
	}; 
	return $sum % 97 == 1;
};  

var IBANRegex= /(?=[0-9A-Z]{28}$)AL\d{10}[0-9A-Z]{16}$|^(?=[0-9A-Z]{24}$)AD\d{10}[0-9A-Z]{12}$|^(?=[0-9A-Z]{20}$)AT\d{18}$|^(?=[0-9A-Z]{22}$)BH\d{2}[A-Z]{4}[0-9A-Z]{14}$|^(?=[0-9A-Z]{16}$)BE\d{14}$|^(?=[0-9A-Z]{20}$)BA\d{18}$|^(?=[0-9A-Z]{22}$)BG\d{2}[A-Z]{4}\d{6}[0-9A-Z]{8}$|^(?=[0-9A-Z]{21}$)HR\d{19}$|^(?=[0-9A-Z]{28}$)CY\d{10}[0-9A-Z]{16}$|^(?=[0-9A-Z]{24}$)CZ\d{22}$|^(?=[0-9A-Z]{18}$)DK\d{16}$|^FO\d{16}$|^GL\d{16}$|^(?=[0-9A-Z]{28}$)DO\d{2}[0-9A-Z]{4}\d{20}$|^(?=[0-9A-Z]{20}$)EE\d{18}$|^(?=[0-9A-Z]{18}$)FI\d{16}$|^(?=[0-9A-Z]{27}$)FR\d{12}[0-9A-Z]{11}\d{2}$|^(?=[0-9A-Z]{22}$)GE\d{2}[A-Z]{2}\d{16}$|^(?=[0-9A-Z]{22}$)DE\d{20}$|^(?=[0-9A-Z]{23}$)GI\d{2}[A-Z]{4}[0-9A-Z]{15}$|^(?=[0-9A-Z]{27}$)GR\d{9}[0-9A-Z]{16}$|^(?=[0-9A-Z]{28}$)HU\d{26}$|^(?=[0-9A-Z]{26}$)IS\d{24}$|^(?=[0-9A-Z]{22}$)IE\d{2}[A-Z]{4}\d{14}$|^(?=[0-9A-Z]{23}$)IL\d{21}$|^(?=[0-9A-Z]{27}$)IT\d{2}[A-Z]\d{10}[0-9A-Z]{12}$|^(?=[0-9A-Z]{20}$)[A-Z]{2}\d{5}[0-9A-Z]{13}$|^(?=[0-9A-Z]{30}$)KW\d{2}[A-Z]{4}22!$|^(?=[0-9A-Z]{21}$)LV\d{2}[A-Z]{4}[0-9A-Z]{13}$|^(?=[0-9A-Z]{,28}$)LB\d{6}[0-9A-Z]{20}$|^(?=[0-9A-Z]{21}$)LI\d{7}[0-9A-Z]{12}$|^(?=[0-9A-Z]{20}$)LT\d{18}$|^(?=[0-9A-Z]{20}$)LU\d{5}[0-9A-Z]{13}$|^(?=[0-9A-Z]{19}$)MK\d{5}[0-9A-Z]{10}\d{2}$|^(?=[0-9A-Z]{31}$)MT\d{2}[A-Z]{4}\d{5}[0-9A-Z]{18}$|^(?=[0-9A-Z]{27}$)MR13\d{23}$|^(?=[0-9A-Z]{30}$)MU\d{2}[A-Z]{4}\d{19}[A-Z]{3}$|^(?=[0-9A-Z]{27}$)MC\d{12}[0-9A-Z]{11}\d{2}$|^(?=[0-9A-Z]{22}$)ME\d{20}$|^(?=[0-9A-Z]{18}$)NL\d{2}[A-Z]{4}\d{10}$|^(?=[0-9A-Z]{15}$)NO\d{13}$|^(?=[0-9A-Z]{28}$)PL\d{10}[0-9A-Z]{,16}n$|^(?=[0-9A-Z]{25}$)PT\d{23}$|^(?=[0-9A-Z]{24}$)RO\d{2}[A-Z]{4}[0-9A-Z]{16}$|^(?=[0-9A-Z]{27}$)SM\d{2}[A-Z]\d{10}[0-9A-Z]{12}$|^(?=[0-9A-Z]{,24}$)SA\d{4}[0-9A-Z]{18}$|^(?=[0-9A-Z]{22}$)RS\d{20}$|^(?=[0-9A-Z]{24}$)SK\d{22}$|^(?=[0-9A-Z]{19}$)SI\d{17}$|^(?=[0-9A-Z]{24}$)ES\d{22}$|^(?=[0-9A-Z]{24}$)SE\d{22}$|^(?=[0-9A-Z]{21}$)CH\d{7}[0-9A-Z]{12}$|^(?=[0-9A-Z]{24}$)TN59\d{20}$|^(?=[0-9A-Z]{26}$)TR\d{7}[0-9A-Z]{17}$|^(?=[0-9A-Z]{,23}$)AE\d{21}$|^(?=[0-9A-Z]{22}$)GB\d{2}[A-Z]{4}\d{14}/;


(function() {

	'use strict';

	var app = angular.module('editAge', ['formly', 'ngMessages', 'formlyMaterial','ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular']);
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

	});
})();


var editMode = false;
var QueryString = function() {
	// This function is anonymous, is executed immediately and
	// the return value is assigned to QueryString!
	var query_string = {};
	var query = window.location.search.substring(1);
	var vars = query.split("&");
	for ( var i = 0; i < vars.length; i++) {
		var pair = vars[i].split("=");
		// If first entry with this name
		if (typeof query_string[pair[0]] === "undefined") {
			query_string[pair[0]] = decodeURIComponent(pair[1]);
			// If second entry with this name
		} else if (typeof query_string[pair[0]] === "string") {
			var arr = [ query_string[pair[0]], decodeURIComponent(pair[1]) ];
			query_string[pair[0]] = arr;
			// If third or later entry with this name
		} else {
			query_string[pair[0]].push(decodeURIComponent(pair[1]));
		}
	}
	return query_string;
}();
function strLeft(sourceStr, keyStr) {
	return (sourceStr.indexOf(keyStr) == -1 | keyStr == '') ? '' : sourceStr
			.split(keyStr)[0];
}

( function() {

	'use strict';

	angular.module('editAge').controller('MainController_editAge',
			[ '$http','$timeout', MainController_editAge ]);

	function MainController_editAge($http,$timeout) {
		var vmMainController_editAge = this;

		var ctrl=this;

		ctrl.$onInit=function(){
			var req=createXHTMLHttpRequest();

			req.onreadystatechange = function(){
				if (req.status == 200&req.readyState==4){
					var ret = convertJSON(req.responseText);
					if (ret[0].data!=undefined && ret[0].data.status != undefined && ret[0].data.status.toLowerCase() == "error") {
						$('#alertError').fadeIn().delay(10000).fadeOut();
						if (ret[0].data.msg == undefined || ret[0].data.msg == "") {
							$('#alertError').html("There was an error, please retry.");
						} else {
							$('#alertError').html(ret[0].data.msg);
						}
					} else {
						vmMainController_editAge.model=ret[0];	
					}
				}else{
					mostraDialogTimed('errorPanel');
					return(false);
				}
			}

			req.open("GET", 'getAgencyData.php?user='+getUsername()+'&token='+getToken(), true);
			req.send();
		}

		vmMainController_editAge.fields = [ {
			className : "row",
			fieldGroup : [{
				className : "col-md-12",
				key : "id",
				type : 'input',
				templateOptions : {
					label: "ID",
					required: true,
					disabled: true
				}
			},{
				className : "col-md-12",
				key : "CompanyName",
				type : 'input',
				templateOptions : {
					label: "Company Name",
					required: true,
					disabled: true
				}
			},{
				className : "col-md-6",
				key : "FiscalCode",
				type : 'input',
				templateOptions : {
					label: "Fiscal Code",
					required: false
				}
			},{
				className : "col-md-6",
				key : "VATCode",
				type : 'input',
				templateOptions : {
					label: "VAT Code",
					required: false
				}
			},{
				className : "col-md-10",
				key : "Street",
				type : 'input',
				templateOptions : {
					label: "Street",
					required: false
				}
			},{
				className : "col-md-2",
				key : "Number",
				type : 'input',
				templateOptions : {
					label: "Number",
					required: false
				}
			},{
				className : "col-md-6",
				key : "City",
				type : 'input',
				templateOptions : {
					label: "City",
					required: false
				}
			},{
				className : "col-md-6",
				key : "StateProvince",
				type : 'input',
				templateOptions : {
					label: "StateProvince",
					required: false
				}
			},{
				className : "col-md-4",
				key : "ZIP",
				type : 'input',
				templateOptions : {
					label: "ZIP",
					required: false
				}
			},{
				className : "col-md-8",
				key : "Country",
				type : 'input',
				templateOptions : {
					label: "Country",
					required: false
				}
			},{
				className : "col-md-12",
				key : "EmailReference",
				type : 'input',
				templateOptions : {
					label: "Email Reference",
					required: false
				},
				validators: {
					emailValidator: function($viewValue, $modelValue, scope) {
						var value = $modelValue || $viewValue;
						if(value) {
							return /[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.+[a-z]{2,3}/g.test(value)
						}
					}
				}
			},{
				className : "col-md-4",
				key : "Bank",
				type : 'input',
				templateOptions : {
					label: "Bank",
					required: false
				}
			},{
				className : "col-md-4",
				key : "PaymentMode",
				type : 'input',
				templateOptions : {
					label: "Payment Mode",
					required: false
				}
			},{
				className : "col-md-4",
				key : "IBAN",
				type : 'input',
				templateOptions : {
					label: "IBAN",
					required: false
				},
				validators: {
					emailValidator: function($viewValue, $modelValue, scope) {
						var value = $modelValue || $viewValue;
						if(value) {
							return IBANRegex.test(value)&&isValidIBAN(value);
						}
					}
				}
			},{
				className : "col-md-12",
				key : "EmailReferenceBilling",
				type : 'input',
				templateOptions : {
					label: "Email Reference Billing",
					required: false
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
		}
		];


		vmMainController_editAge.submit = function() {
			var arr={
					"user": getUsername(),
					"token": getToken(),
					"values": vmMainController_editAge.model,
			};

			var stringPass=JSON.stringify(arr);
			var data=stringPass;

			$.ajax( {
				type : "POST",
				dataType : "application/json",
				contentType : "application/json; charset=utf-8",
				data : data,
				url : "updateAgencyData.php",
				complete : function(ret) {
					var response=ret.responseText.replace(/\\/,"");
					if(convertJSON(response).statuscode==200){
						$('#alertOK').fadeIn().delay(10000).fadeOut();
						$('#alertOK').html("Your data was saved correctly.");	
					}else{
						$('#alertError').fadeIn().delay(1000).fadeOut();
						$('#alertOK').html("There was an error, please retry.");
					}
				},
				error : function(xhr) {
					if (xhr.status == 500) {
						$("#alertError").html("Error from server, please retry.");
						$("#alertError").fadeIn().delay(1000).fadeOut();
					}

				}
			});
		}
	}
})();

angular.element(document).ready(function() {
	console.log("registro editAge");
	angular.bootstrap(document.getElementById('editAgeAPP'), ['editAge']);
});

