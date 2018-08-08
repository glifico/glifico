$.ajaxSetup( {
	async : true
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


function strLeft(sourceStr, keyStr) {
	return (sourceStr.indexOf(keyStr) == -1 | keyStr == '') ? '' : sourceStr
			.split(keyStr)[0];
}


function doDelete(from, to){
	console.debug("deleting");
	var arr={
			"user": getUsername(),
			"token": getToken(),
			"values": {
				"LanguageFrom": from,
				"LanguageTo": to,
			}
	};

	var stringPass=JSON.stringify(arr);
	var data=stringPass;

	$.ajax( {
		type : "POST",
		dataType : "application/json",
		contentType : "application/json; charset=utf-8",
		data : data,
		url : "deleteLanguagePair.php",
		complete : function(ret) {
			var response=ret.responseText.replace(/\\/,"");
			if(convertJSON(response).statuscode==200){
				$('#alertOK').fadeIn().delay(5000).fadeOut();
				$('#alertOK').html("Your data was updated correctly.");
				refresh();
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

function createTable(pairs){
	var html="";
	html+='<table class="table">';
	html+='<thead>';
	html+='<tr class="row">';
	html+='<th class="col-md-3">From</th>';
	html+='<th class="col-md-3">To</th>';
	html+='<th class="col-md-3">Price</th>';
	html+='<th class="col-md-3">Field</th>';
	html+='<th class="col-md-1"></th>';
	html+='<th class="col-md-1"></th>';
	html+='</tr>';
	for (var i = 0; i < pairs.length; i++) {
		var edu=pairs[i];
		html+='<tr class="row">';
		html+='<td class=" col-md-3"><span style="font-size:18px;">'+edu.LanguageFrom+'</span></td>';
		html+='<td class=" col-md-3"><span style="font-size:18px;">'+ edu.LanguageTo +'</span></td>';
		html+='<td class=" col-md-3"><span style="font-size:18px;">'+edu.Price+' '+ edu.Currency+'</span></td>';
		html+='<td class=" col-md-3"><span style="font-size:18px;">'+edu.Field+'</span></td>';
		html+='<td class=" col-md-1"><button data-toggle="modal" data-target="#LanguageModal"  data-price="'+edu.Price+'" data-currency="'+edu.Currency+'" data-from="'+edu.LanguageFrom+'" data-to="'+edu.LanguageTo+'" data-field="'+edu.Field+'" data-service="'+edu.Service+'" class="md-secondary md-hue-3" aria-label="edit"><span><i class="fa fa-pencil fa-2x"></i></span></button></td>';
		html+='<td class=" col-md-1"><button onclick="doDelete('+"'"+edu.LanguageFrom+"'"+','+"'"+edu.LanguageTo+"'"+')"><span><i class="fa fa-trash fa-2x"></i></span></button></td>';
		html+='</tr>';
	}
	html+='</thead>';
	html+='</table>';	

	$("#pairsTable").html(html);
}

function refresh(){
	var req=createXHTMLHttpRequest();

	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var ret=convertJSON(req.responseText);
			createTable(ret);
		}
	}

	req.open("GET",'getLanguagePairsData.php?user='+getUsername()+"&token="+getToken(),true);
	req.send();
}

/*-----------------------APP--------------------*/

var app = angular.module('PersonalApp', ['ngMessages', 'ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular','ui.bootstrap']);
var app = angular.module('LanguagePairsApp', ['ngMessages', 'ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular','ui.bootstrap']);

/*-----------------------CTRL-------------------*/


angular.module('PersonalApp').controller('PersonalAppCtrl',function($http,$timeout,$scope) {

	var ctrl = this;

	ctrl.loadCountries = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret = convertJSON(req.responseText);
				ctrl.Countries=ret;
			}
		}

		req.open("GET","getCountries.php",true);
		req.send();
	}

	ctrl.loadLanguages = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret = convertJSON(req.responseText);
				ctrl.Languages=ret;
			}
		}

		req.open("GET","getLanguages.php",true);
		req.send();
	};

	ctrl.$onInit= function(){
		var req=createXHTMLHttpRequest();

		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret = convertJSON(req.responseText);
				ctrl.loadLanguages();
				ctrl.loadCountries();
				ctrl.fname=ret[0].FirstName;
				ctrl.lname=ret[0].LastName
				ctrl.street=ret[0].Street;
				ctrl.city=ret[0].City;
				ctrl.IdCountry=ret[0].IdCountry;
				ctrl.IdMothertongue=ret[0].IdMothertongue;
				ctrl.state=ret[0].StateProvince;
				ctrl.zip=ret[0].ZIP;
				ctrl.email=ret[0].Email;
				ctrl.IBAN=ret[0].IBAN;
				ctrl.swift=ret[0].swift;
				ctrl.phone=ret[0].PhoneReference;
				ctrl.phone_bil=ret[0].PhoneReferenceBilling;
				ctrl.email_bil=ret[0].EmailReferenceBilling;
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
		}

		req.open("GET", 'getTranslatorData.php?user='+getUsername()+'&token='+getToken(), true);
		req.send();	
	}
	
	ctrl.isibanvalid =function (){
		if(ctrl.IBAN){
			return isValidIBAN(ctrl.IBAN);
		}else{
			return false;
		}
	}
	
	ctrl.iszipvalid =function (){
		return /[0-9]{5}/.test(ctrl.zip);
	}
	
	
	ctrl.isemailvalid = function(){
		return /[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.+[a-z]{2,3}/.test(ctrl.email);
	}
	
	ctrl.isbilemailvalid = function(){
		return /[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.+[a-z]{2,3}/.test(ctrl.email);
	}
	
	ctrl.validForm = function(){
		return ctrl.isemailvalid() && ctrl.isibanvalid() && ctrl.iszipvalid();
	}

	ctrl.submit = function() {
		var arr={
				"user": getUsername(),
				"token": getToken(),
				"values": {
					"FirstName": ctrl.fname,
					"LastName": ctrl.lname,
					"FiscalCode": ctrl.vat,
					"Street": ctrl.street,
					"City": ctrl.city,
					"Country": ctrl.state,
					"ZIP": ctrl.zip,
					"email": ctrl.email,
					"email_bil": ctrl.email_bil,
					"phone": ctrl.phone,
					"phone_bil": ctrl.phone_bil,
					"IBAN": ctrl.IBAN,
				},
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



angular.module('LanguagePairsApp').controller('LanguagePairsAppCtrl',function($http,$timeout,$scope,$mdDialog) {

	$scope.nullModel = {IdLanguageFrom:null,IdLanguageTo:null,IdParametro_Field:null,IdParametro_Service:null,IdCurrency:null,PricePerCharacter:null};
	$scope.defaultModel = {IdLanguageFrom:'en',IdLanguageTo:'it',IdParametro_Field:0,IdParametro_Service:0,IdCurrency:'EUR',PricePerCharacter:0};


	var ctrl=this;

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


	ctrl.createTable=function(pairs){
		createTable(pairs);	
	};

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

	ctrl.refresh=function(){
		var req=createXHTMLHttpRequest();

		$scope.loadLanguages();
		$scope.loadFields();
		$scope.loadServices();
		$scope.loadCurrencies();

		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret=convertJSON(req.responseText);
				$scope.Pairs=ret;
				ctrl.createTable(ret);
			}
		}

		req.open("GET",'getLanguagePairsData.php?user='+getUsername()+"&token="+getToken(),true);
		req.send();
	}

	ctrl.$onInit=function(){
		ctrl.refresh();
		$scope.openedPrice=-1;
		$scope.model=$scope.defaultModel;
		console.debug($scope.model);
	}

	$scope.closeModal=function(){
		$('#LanguageModal').modal('hide');
		$scope.openedEdu=null;
	}


	$scope.submit= function(){
		console.debug($scope.model);

		if($scope.model.PricePerCharacter<0){
			alert("Price should be greater than zero!");
			return;
		}

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
			url : "addLanguagePair.php",
			complete : function(ret) {
				var response=ret.responseText.replace(/\\/,"");
				if(convertJSON(response).statuscode==200){
					$('#alertOK').fadeIn().delay(5000).fadeOut();
					$('#alertOK').html("Your data was saved correctly.");
					ctrl.refresh();
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



});


angular.element(document).ready(function() {
	angular.bootstrap(document.getElementById('PersonalAppID'), ['PersonalApp']);
	angular.bootstrap(document.getElementById('LanguagePairsAppID'), ['LanguagePairsApp']);

});
