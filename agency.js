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
    			$scope.loadLanguages();
    			$scope.loadCountries();
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
                    }
                },{
                    className : "col-md-12",
                    key : "EmailReferenceBilling",
                    type : 'input',
                    templateOptions : {
                        label: "Email Reference Billing",
                        required: false
                    }
                }]
            }
            ];
            vmMainController_editAge.submit = function() {
                $http
                        .post('rest.xsp?api=save&type=modificaAgenzia&id='+QueryString.id, vmMainController_editAge.model)
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
                                                "Your data was saved correctly.");
                                    }
                                    $('#loginModal').modal('hide');
                                });
            }
        }

    })();

    angular.element(document).ready(function() {
        console.log("registro editAge");
        angular.bootstrap(document.getElementById('editAgeAPP'), ['editAge']);
    });

