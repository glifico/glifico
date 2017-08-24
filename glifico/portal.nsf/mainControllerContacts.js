// scripts/MainController.js

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

	angular.module('contactsApp').controller('MainController_contacts',
			[ '$http', MainController_contacts ]);

	function MainController_contacts($http) {
		var vmMainController_contacts = this;
//		$http.get('rest.xsp?api=newMail').success( function(data) {
//			
//			});
		vmMainController_contacts.fields = [ {
			className : "row",
			fieldGroup : [ {
				className : "col-md-4",
				key : 'Mittente',
				type : 'input',
				templateOptions : {
					label : 'Name/Company Name',
					required : true
				}
			}, {
				className : "col-md-4",
				key : 'EmailMittente',
				type : 'input',
				templateOptions : {
					label : 'Email',
					style : "width:100%",
					required : true
				}
			}, {
				className : "col-md-4",
				key : 'TelMittente',
				type : 'input',
				templateOptions : {
					label : 'Phone',
					style : "width:100%",
					required : true
				}
			} ]
		}, {
			key : 'Subject',
			type : 'input',
			templateOptions : {
				label : 'Subject',
				required : true
			}
		}, {
			key : 'Body',
			type : 'textarea',
			templateOptions : {
				label : 'Your message',
				required : true
			}
		} ];		
		vmMainController_contacts.submit = function() {
			$http
					.post('rest.xsp?api=save&type=sendMail&id=0', vmMainController_contacts.model)
					.success(
							function(data) {
								var ret = eval(data);
								if (ret == undefined || ret[0] == undefined
										|| ret[0].data == undefined) {
									$('#alertError').fadeIn().delay(10000)
											.fadeOut();
									$('#alertError')
											.html(
													"Si \u00E8 verificato un errore inaspettato");
								} else if (ret[0].data.status != undefined
										&& ret[0].data.status.toLowerCase() == "error") {
									$('#alertError').fadeIn().delay(10000)
											.fadeOut();
									if (ret[0].data.msg == undefined
											|| ret[0].data.msg == "") {
										$('#alertError').html(
												"Si \u00E8 verificato un errore.");
									} else {
										$('#alertError').html(ret[0].data.msg);
									}
								} else {
									$('#alertOK').fadeIn().delay(10000)
											.fadeOut();
									$('#alertOK').html(
											"Thanks. Your message was sent.");
								}
							});
		}
	}

})();
