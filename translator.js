$.ajaxSetup( {
	async : false
});

var regexIso8601 = /^(\d{4}|\+\d{6})(?:-(\d{2})(?:-(\d{2})(?:T(\d{2}):(\d{2}):(\d{2})\.(\d{1,})(Z|([\-+])(\d{2}):(\d{2}))?)?)?)?$/;

function convertDateStringsToDates(input) {
	// Ignore things that aren't objects.
	if (typeof input !== "object") return input;

	for (var key in input) {
		if (!input.hasOwnProperty(key)) continue;

		var value = input[key];
		var match;
		// Check for string properties which look like dates.
		if (typeof value === "string" && (match = value.match(regexIso8601))) {
			var milliseconds = Date.parse(match[0])
			if (!isNaN(milliseconds)) {
				input[key] = new Date(milliseconds);
			}
		} else if (typeof value === "object") {
			// Recurse into object
			convertDateStringsToDates(value);
		}
	}
}
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


/*-----------------------APP-------------------*/

(function() {

	'use strict';

	var app = angular.module('PersonalApp', ['ngMessages', 'ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular','ui.bootstrap']);
	app.config(["$httpProvider", function ($httpProvider) {
		$httpProvider.defaults.transformResponse.push(function(responseData){
			convertDateStringsToDates(responseData);
			return responseData;
		});
	}]);

	var app = angular.module('EducationApp', ['ngMessages', 'ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular','ui.bootstrap','ngUpload']);

	var app = angular.module('SpecializationApp', ['ngMessages', 'ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular','ui.bootstrap','ngUpload']);
	app.config(["$httpProvider", function ($httpProvider) {
		$httpProvider.defaults.transformResponse.push(function(responseData){
			convertDateStringsToDates(responseData);
			return responseData;
		});
	}]);

	var app = angular.module('LanguagePairsApp', ['ngMessages', 'ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular','ui.bootstrap','ngUpload']);
	app.config(["$httpProvider", function ($httpProvider) {
		$httpProvider.defaults.transformResponse.push(function(responseData){
			convertDateStringsToDates(responseData);
			return responseData;
		});
	}]);

})();




/*-----------------------CTRL-------------------*/


( function() {

	'use strict';

	angular.module('PersonalApp').controller('PersonalAppCtrl',function($http,$timeout,$scope) {


		$scope.loadCountries = function(){
			var req=createXHTMLHttpRequest();
			req.onreadystatechange = function(){
				if (req.status == 200&req.readyState==4){
					var ret = convertJSON(req.responseText);
					$scope.Countries=ret;
				}
			}

			req.open("GET","getCountries.php",true);
			req.send();
		}

		$scope.loadLanguages = function(){
			var req=createXHTMLHttpRequest();
			req.onreadystatechange = function(){
				if (req.status == 200&req.readyState==4){
					var ret = convertJSON(req.responseText);
					$scope.Languages=ret;
				}
			}

			req.open("GET","getLanguages.php",true);
			req.send();
		};

		var ctrl=this;



		var req=createXHTMLHttpRequest();

		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret = convertJSON(req.responseText);
				$scope.loadLanguages();
				$scope.loadCountries();
				$scope.model=ret[0];
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
		}

		req.open("GET", 'getTranslatorData.php?user='+getUsername()+'&token='+getToken(), true);
		req.send();



		$scope.submit = function() {
			var arr={
				"user": getUsername(),
				"token": getToken(),
				"values": $scope.model,
			};

			var stringPass=JSON.stringify(arr);
			var data=stringPass;

			$.ajax( {
				type : "POST",
				dataType : "application/json",
				contentType : "application/json; charset=utf-8",
				data : data,
				url : "updateTranslatorData.php",
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

		};



	});




	//	angular.module('EducationApp').controller('EducationAppCtrl',function($http,$timeout,$scope,$mdDialog) {

	//	$scope.model = {Id:null,Field:"",Institute:"",AttachmentDoc:""};

	//	$http.get('rest.xsp?api=getDatiEducations&id='+QueryString.id).success( function(data) {
	//	var ret = convertJSON(data);
	//	if (ret[0].data!=undefined && ret[0].data.status != undefined && ret[0].data.status.toLowerCase() == "error") {
	//	$('#alertError').fadeIn().delay(10000).fadeOut();
	//	if (ret[0].data.msg == undefined || ret[0].data.msg == "") {
	//	$('#alertError').html("There was an error, please retry.");
	//	} else {
	//	$('#alertError').html(ret[0].data.msg);
	//	}
	//	} else {
	//	$scope.edus=ret;
	//	}
	//	});

	//	$scope.loadEducation = function(edu){
	//	angular.copy(edu,$scope.model);
	//	}

	//	$scope.doDelete = function(edu){
	//	$http.post('rest.xsp?api=save&type=deleteEducation&id=' + QueryString.id, edu).success(
	//	function(data) {
	//	var ret = eval(data);
	//	if (ret == undefined || ret[0] == undefined ||
	//	ret[0].data == undefined) {
	//	$('#alertError').fadeIn().delay(10000)
	//	.fadeOut();
	//	$('#alertError')
	//	.html(
	//	"There was an error, please retry inaspettato");
	//	} else if (ret[0].data.status != undefined &&
	//	ret[0].data.status.toLowerCase() == "error") {
	//	$('#alertError').fadeIn().delay(10000)
	//	.fadeOut();
	//	if (ret[0].data.msg == undefined ||
	//	ret[0].data.msg == "") {
	//	$('#alertError').html(
	//	"There was an error, please retry.");
	//	} else {
	//	var stringval = ret[0].data.msg
	//	if (stringval.indexOf("Cannot insert duplicate key") != -1) {
	//	var errorField = strRight(ret[0].data.msg, "Index:");
	//	errorField = strLeft(errorField, "_Unique");
	//	$('#alertError').html(errorField + " already exist. If you have lost your password use password recovery function.");
	//	} else {
	//	$('#alertError').html(ret[0].data.msg);
	//	}
	//	}
	//	} else {
	//	$('#alertOK').fadeIn().delay(10000)
	//	.fadeOut();
	//	$('#alertOK').html(
	//	"Your data was saved correctly.");
	//	$scope.model = {
	//	Id: null,
	//	Field: "",
	//	Institute: ""
	//	};
	//	$scope.edus = ret[0].data.Educations;
	//	}
	//	});

	//	}

	//	$scope.isToShow=function(edu) {
	//	if(edu.AttachmentDoc==null){
	//	return false;
	//	}
	//	if(edu.AttachmentDoc==""){
	//	return false;
	//	}
	//	return true;
	//	}
	//	$scope.download=function(edu) {
	//	console.log("qui si");
	//	location.href = "xsp/download?id=" + edu.AttachmentDoc;
	//	}
	//	$scope.showAdvanced = function(ev,edu) {
	//	angular.copy(edu,$scope.model);
	//	$mdDialog.show({
	//	controller: DialogController,
	//	templateUrl: 'templates/dialog1.tmpl.html',
	//	parent: angular.element(document.body),
	//	targetEvent: ev,
	//	clickOutsideToClose:false,
	//	fullscreen: $scope.customFullscreen // Only for -xs, -sm breakpoints.
	//	}).then(function(answer,edu) {
	//	if(answer.success==true){
	//	if(answer.files[0].Checksum != undefined){
	//	$scope.model.AttachmentDoc=answer.files[0].Checksum;
	//	$scope.submit();
	//	$scope.model = {Id:null,Field:"",Institute:"",AttachmentDoc:""};
	//	}
	//	}
	//	}, function() {
	//	console.log("cancel");
	//	});
	//	};

	//	function DialogController($scope, $mdDialog) {
	//	$scope.hide = function() {
	//	$mdDialog.hide();
	//	};

	//	$scope.cancel = function() {
	//	$mdDialog.cancel();
	//	};

	//	$scope.uploadComplete = function(answer) {
	//	$mdDialog.hide(answer);
	//	};
	//	}


	//	$scope.submit = function() {
	//	$http
	//	.post('rest.xsp?api=save&type=modificaEducation&id='+QueryString.id, $scope.model)
	//	.success(
	//	function(data) {
	//	var ret = eval(data);
	//	if (ret == undefined || ret[0] == undefined
	//	|| ret[0].data == undefined) {
	//	$('#alertError').fadeIn().delay(10000)
	//	.fadeOut();
	//	$('#alertError')
	//	.html(
	//	"There was an error, please retry inaspettato");
	//	} else if (ret[0].data.status != undefined
	//	&& ret[0].data.status.toLowerCase() == "error") {
	//	$('#alertError').fadeIn().delay(10000)
	//	.fadeOut();
	//	if (ret[0].data.msg == undefined
	//	|| ret[0].data.msg == "") {
	//	$('#alertError').html(
	//	"There was an error, please retry.");
	//	} else {
	//	var stringval=ret[0].data.msg
	//	if(stringval.indexOf("Cannot insert duplicate key") != -1){
	//	var errorField = strRight(ret[0].data.msg,"Index:");
	//	errorField = strLeft(errorField,"_Unique");
	//	$('#alertError').html(errorField + " already exist. If you have lost your password use password recovery function.");
	//	}else{
	//	$('#alertError').html(ret[0].data.msg);
	//	}
	//	}
	//	} else {
	//	$('#alertOK').fadeIn().delay(10000)
	//	.fadeOut();
	//	$('#alertOK').html(
	//	"Your data was saved correctly.");
	//	$scope.model = {Id:null,Field:"",Institute:"",AttachmentDoc:""};
	//	$scope.edus=ret[0].data.Educations;
	//	}
	//	$('#loginModal').modal('hide');
	//	});
	//	}
	//	});




	//	angular.module('SpecializationApp').controller('SpecializationAppCtrl',function($http,$timeout,$scope,$mdDialog) {

	//	$scope.model = {Id:null,Institution:null,Specialization:null,Level:null,AttachmentDoc:""};

	//	$scope.loadLevels = function(){
	//	$scope.Levels=[
	//	{Id:"Basic",Level:"Basic"},
	//	{Id:"Intermediate",Level:"Intermediate"},
	//	{Id:"Fluency",Level:"Fluency"}
	//	];
	//	}

	//	$http.get('rest.xsp?api=getDatiSpecializations&id='+QueryString.id).success( function(data) {
	//	var ret = convertJSON(data);
	//	if (ret[0].data!=undefined && ret[0].data.status != undefined && ret[0].data.status.toLowerCase() == "error") {
	//	$('#alertError').fadeIn().delay(10000).fadeOut();
	//	if (ret[0].data.msg == undefined || ret[0].data.msg == "") {
	//	$('#alertError').html("There was an error, please retry.");
	//	} else {
	//	$('#alertError').html(ret[0].data.msg);
	//	}
	//	} else {
	//	$scope.Specializations=ret;
	//	$scope.loadLevels();
	//	}
	//	});

	//	$scope.loadSpecializations = function(edu){
	//	angular.copy(edu,$scope.model);
	//	}



	//	$scope.doDelete = function(edu){
	//	$http.post('rest.xsp?api=save&type=deleteSpecialization&id=' + QueryString.id, edu).success(
	//	function(data) {
	//	var ret = eval(data);
	//	if (ret == undefined || ret[0] == undefined ||
	//	ret[0].data == undefined) {
	//	$('#alertError').fadeIn().delay(10000)
	//	.fadeOut();
	//	$('#alertError')
	//	.html(
	//	"There was an error, please retry inaspettato");
	//	} else if (ret[0].data.status != undefined &&
	//	ret[0].data.status.toLowerCase() == "error") {
	//	$('#alertError').fadeIn().delay(10000)
	//	.fadeOut();
	//	if (ret[0].data.msg == undefined ||
	//	ret[0].data.msg == "") {
	//	$('#alertError').html(
	//	"There was an error, please retry.");
	//	} else {
	//	var stringval = ret[0].data.msg
	//	if (stringval.indexOf("Cannot insert duplicate key") != -1) {
	//	var errorField = strRight(ret[0].data.msg, "Index:");
	//	errorField = strLeft(errorField, "_Unique");
	//	$('#alertError').html(errorField + " already exist. If you have lost your password use password recovery function.");
	//	} else {
	//	$('#alertError').html(ret[0].data.msg);
	//	}
	//	}
	//	} else {
	//	$('#alertOK').fadeIn().delay(10000)
	//	.fadeOut();
	//	$('#alertOK').html(
	//	"Your data was saved correctly.");
	//	$scope.model = {Id:null,Institution:null,Specialization:null,Level:null,AttachmentDoc:""};
	//	$scope.Specializations = ret[0].data.Specializations;
	//	}
	//	});

	//	}

	//	$scope.isToShow=function(edu) {
	//	if(edu.AttachmentDoc==null){
	//	return false;
	//	}
	//	if(edu.AttachmentDoc==""){
	//	return false;
	//	}
	//	return true;
	//	}
	//	$scope.download=function(edu) {
	//	console.log("qui si");
	//	location.href = "xsp/download?id=" + edu.AttachmentDoc;
	//	}


	//	$scope.showAdvanced = function(ev,edu) {
	//	angular.copy(edu,$scope.model);
	//	$mdDialog.show({
	//	controller: DialogController,
	//	templateUrl: 'templates/dialog2.tmpl.html',
	//	parent: angular.element(document.body),
	//	targetEvent: ev,
	//	clickOutsideToClose:false,
	//	fullscreen: $scope.customFullscreen // Only for -xs, -sm breakpoints.
	//	}).then(function(answer,edu) {
	//	if(answer.success==true){
	//	if(answer.files[0].Checksum != undefined){
	//	$scope.model.AttachmentDoc=answer.files[0].Checksum;
	//	$scope.submit();
	//	$scope.model = {Id:null,Institution:null,Specialization:null,Level:null,AttachmentDoc:""};
	//	}
	//	}
	//	}, function() {
	//	console.log("cancel");
	//	});
	//	};

	//	function DialogController($scope, $mdDialog) {
	//	$scope.hide = function() {
	//	$mdDialog.hide();
	//	};

	//	$scope.cancel = function() {
	//	$mdDialog.cancel();
	//	};

	//	$scope.uploadComplete = function(answer) {
	//	$mdDialog.hide(answer);
	//	};
	//	}


	//	$scope.submit = function() {
	//	$http
	//	.post('rest.xsp?api=save&type=modificaSpecialization&id='+QueryString.id, $scope.model)
	//	.success(
	//	function(data) {
	//	var ret = eval(data);
	//	if (ret == undefined || ret[0] == undefined
	//	|| ret[0].data == undefined) {
	//	$('#alertError').fadeIn().delay(10000)
	//	.fadeOut();
	//	$('#alertError')
	//	.html(
	//	"There was an error, please retry inaspettato");
	//	} else if (ret[0].data.status != undefined
	//	&& ret[0].data.status.toLowerCase() == "error") {
	//	$('#alertError').fadeIn().delay(10000)
	//	.fadeOut();
	//	if (ret[0].data.msg == undefined
	//	|| ret[0].data.msg == "") {
	//	$('#alertError').html(
	//	"There was an error, please retry.");
	//	} else {
	//	var stringval=ret[0].data.msg
	//	if(stringval.indexOf("Cannot insert duplicate key") != -1){
	//	var errorField = strRight(ret[0].data.msg,"Index:");
	//	errorField = strLeft(errorField,"_Unique");
	//	$('#alertError').html(errorField + " already exist. If you have lost your password use password recovery function.");
	//	}else{
	//	$('#alertError').html(ret[0].data.msg);
	//	}
	//	}
	//	} else {
	//	$('#alertOK').fadeIn().delay(10000)
	//	.fadeOut();
	//	$('#alertOK').html(
	//	"Your data was saved correctly.");
	//	$scope.model = {Id:null,Institution:null,Specialization:null,Level:null,AttachmentDoc:""};
	//	$scope.Specializations=ret[0].data.Specializations;
	//	}
	//	$('#loginModal').modal('hide');
	//	});
	//	}
	//	});





	angular.module('LanguagePairsApp').controller('LanguagePairsAppCtrl',function($http,$timeout,$scope,$mdDialog) {

		$scope.nullModel = {IdLanguageFrom:null,IdLanguageTo:null,IdParametro_Field:null,IdParametro_Service:null,IdCurrency:null,PricePerCharacter:null};

		var ctrl=this;

		var req=createXHTMLHttpRequest();

		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				angular.copy($scope.nullModel,$scope.model);
				var ret=convertJSON(req.responseText);
				$scope.Pairs=ret;
				$scope.loadLanguages();
				$scope.loadFields();
				$scope.loadServices();
				$scope.loadCurrencies();
			}
		}

		req.open("GET",'getLanguagePairsData.php?user='+getUsername()+"&token="+getToken(),true);
		req.send();


		$scope.loadLanguages = function(){
			var req=createXHTMLHttpRequest();
			req.onreadystatechange = function(){
				if (req.status == 200&req.readyState==4){
					var ret = convertJSON(req.responseText);
					$scope.Languages=ret;
				}
			}
			req.open("GET","getLanguages.php?",true);
			req.send();
		}


		$scope.loadFields = function(){
			var req=createXHTMLHttpRequest();
			req.onreadystatechange = function(){
				if (req.status == 200&req.readyState==4){
					var ret = convertJSON(req.responseText);
					$scope.Fields=ret;
				}
			}
			req.open("GET","getFields.php",true);
			req.send();
		}

		$scope.loadServices = function(){
			var req=createXHTMLHttpRequest();
			req.onreadystatechange = function(){
				if (req.status == 200&req.readyState==4){
					var ret = convertJSON(req.responseText);
					$scope.Services=ret;
				}
			}
			req.open("GET","getServices.php",true);
			req.send();
		}

		$scope.loadCurrencies = function(){
			var req=createXHTMLHttpRequest();
			req.onreadystatechange = function(){
				if (req.status == 200&req.readyState==4){
					var ret = convertJSON(req.responseText);
					$scope.Currencies=ret;
				}
			}
			req.open("GET","getCurrencies.php",true);
			req.send();
		}


		ctrl.$onInit=function(){
		}


		$scope.loadPairs = function(edu){
			console.log(edu);
			angular.copy(edu,$scope.model);
			console.log($scope.model);
			$scope.model=edu;
		}



		// $scope.doDelete = function(edu){
		// 	$http.post('rest.xsp?api=save&type=deleteLanguagePair&id=' + QueryString.id, edu).success(
		// 			function(data) {
		// 				var ret = eval(data);
		// 				if (ret == undefined || ret[0] == undefined ||
		// 						ret[0].data == undefined) {
		// 					$('#alertError').fadeIn().delay(10000)
		// 					.fadeOut();
		// 					$('#alertError')
		// 					.html(
		// 					"There was an error, please retry inaspettato");
		// 				} else if (ret[0].data.status != undefined &&
		// 						ret[0].data.status.toLowerCase() == "error") {
		// 					$('#alertError').fadeIn().delay(10000)
		// 					.fadeOut();
		// 					if (ret[0].data.msg == undefined ||
		// 							ret[0].data.msg == "") {
		// 						$('#alertError').html(
		// 						"There was an error, please retry.");
		// 					} else {
		// 						var stringval = ret[0].data.msg
		// 						if (stringval.indexOf("Cannot insert duplicate key") != -1) {
		// 							var errorField = strRight(ret[0].data.msg, "Index:");
		// 							errorField = strLeft(errorField, "_Unique");
		// 							$('#alertError').html(errorField + " already exist. If you have lost your password use password recovery function.");
		// 						} else {
		// 							$('#alertError').html(ret[0].data.msg);
		// 						}
		// 					}
		// 				} else {
		// 					$('#alertOK').fadeIn().delay(10000)
		// 					.fadeOut();
		// 					$('#alertOK').html(
		// 					"Your data was saved correctly.");
		// 					angular.copy($scope.nullModel,$scope.model);
		// 					$scope.Pairs = ret[0].data.Pairs;
		// 				}
		// 			});
		//
		// }




		// 	$scope.submit = function() {
		// 		$http
		// 		.post('rest.xsp?api=save&type=modificaLanguagePair&id='+QueryString.id, $scope.model)
		// 		.success(
		// 				function(data) {
		// 					var ret = eval(data);
		// 					if (ret == undefined || ret[0] == undefined
		// 							|| ret[0].data == undefined) {
		// 						$('#alertError').fadeIn().delay(10000)
		// 						.fadeOut();
		// 						$('#alertError')
		// 						.html(
		// 						"There was an error, please retry inaspettato");
		// 					} else if (ret[0].data.status != undefined
		// 							&& ret[0].data.status.toLowerCase() == "error") {
		// 						$('#alertError').fadeIn().delay(10000)
		// 						.fadeOut();
		// 						if (ret[0].data.msg == undefined
		// 								|| ret[0].data.msg == "") {
		// 							$('#alertError').html(
		// 							"There was an error, please retry.");
		// 						} else {
		// 							var stringval=ret[0].data.msg
		// 							if(stringval.indexOf("Cannot insert duplicate key") != -1){
		// 								var errorField = strRight(ret[0].data.msg,"Index:");
		// 								errorField = strLeft(errorField,"_Unique");
		// 								$('#alertError').html(errorField + " already exist. If you have lost your password use password recovery function.");
		// 							}else{
		// 								$('#alertError').html(ret[0].data.msg);
		// 							}
		// 						}
		// 					} else {
		// 						$('#alertOK').fadeIn().delay(10000)
		// 						.fadeOut();
		// 						$('#alertOK').html(
		// 						"Your data was saved correctly.");
		// 						angular.copy($scope.nullModel,$scope.model);
		// 						$scope.Pairs=ret[0].data.Pairs;
		// 					}
		// 					$('#loginModal').modal('hide');
		// 				});
		// 	}
	});



})();

angular.element(document).ready(function() {
	angular.bootstrap(document.getElementById('PersonalAppID'), ['PersonalApp']);
	//angular.bootstrap(document.getElementById('EducationAppID'), ['EducationApp']);
	//angular.bootstrap(document.getElementById('SpecializationAppID'), ['SpecializationApp']);
	angular.bootstrap(document.getElementById('LanguagePairsAppID'), ['LanguagePairsApp']);

});
