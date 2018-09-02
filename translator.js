$.ajaxSetup( {
	async : true
});

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

function askAccountDeletion(){
	var req=createXHTMLHttpRequest();

	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			$('#DeleteModal').modal('hide');
			$('#alertOK').fadeIn().delay(15000).fadeOut();
			$('#alertOK').html("Your request has been sent to us.");
		}
	}

	req.open("GET",'askAccountDeletion.php?user='+getUsername()+"&token="+getToken(),true);
	req.send();
}

function doDelete(from, to){
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
			}else if(convertJSON(response).statuscode==301){
				$('#alertOK').fadeIn().delay(10000).fadeOut();
				$('#alertOK').html("Your data not uptdate because you have open jobs in that language.");
				notify("Your data not uptdate because you have open jobs in that language.");
			}else if(convertJSON(response).statuscode==302){
				$('#alertOK').fadeIn().delay(5000).fadeOut();
				$('#alertOK').html("Your was not uptdate because you have open jobs in that language.");
				notify("Your data not uptdate because you have open jobs in that language.");
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
	html+='<th style="text-align:center;" class="col-md-3">From</th>';
	html+='<th style="text-align:center;" class="col-md-3">To</th>';
	html+='<th style="text-align:center;" class="col-md-3">Price</th>';
	html+='<th style="text-align:center;" class="col-md-3">Field</th>';
	html+='<th class="col-md-1"></th>';
	html+='<th class="col-md-1"></th>';
	html+='</tr>';
	html+='</thead>';
	html+='<tbody>';
	for (var i = 0; i < pairs.length; i++) {
		var edu=pairs[i];
		html+='<tr class="row">';
		html+='<td class=" col-md-3"><span style="font-size:18px;">'+edu.LanguageFrom+'</span></td>';
		html+='<td class=" col-md-3"><span style="font-size:18px;">'+ edu.LanguageTo +'</span></td>';
		html+='<td class=" col-md-3"><span style="font-size:18px;">'+edu.Price+' '+ edu.Currency+'</span></td>';
		html+='<td class=" col-md-3"><span style="font-size:18px;">'+edu.Field+'</span></td>';
		//html+='<td class=" col-md-1"><button data-toggle="modal" data-target="#LanguageModal"  data-price="'+edu.Price+'" data-currency="'+edu.Currency+'" data-from="'+edu.LanguageFrom+'" data-to="'+edu.LanguageTo+'" data-field="'+edu.Field+'" data-service="'+edu.Service+'" class="md-secondary md-hue-3" aria-label="edit"><span><i class="fa fa-pencil fa-2x"></i></span></button></td>';
		html+='<td class=" col-md-1"><button data-toggle="modal" data-target="#LanguageModal"  data-price="'+edu.Price+'" data-currency="'+edu.Currency+'" data-from="'+edu.LanguageFrom+'" data-to="'+edu.LanguageTo+'" data-field="'+edu.Field+'" data-service="'+edu.Service+'" class="md-secondary md-hue-3" aria-label="edit"><span><i class="fa fa-search-plus fa-2x"></i></span></button></td>';
		html+='<td class=" col-md-1"><button onclick="doDelete('+"'"+edu.LanguageFrom+"'"+','+"'"+edu.LanguageTo+"'"+')"><span><i class="fa fa-trash fa-2x"></i></span></button></td>';
		html+='</tr>';
	}
	html+='</tbody>';
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

angular.module('PersonalAppCtrl',[]).controller('PersonalAppCtrl',function($scope) {

	var ctrl = this;

	ctrl.loadCountries = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				$scope.$apply(function () {
					var ret = convertJSON(req.responseText);
					ctrl.Countries=ret;
				});
				return true;
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
				$scope.$apply(function () {
					ctrl.Languages=ret;
				});
				return true;
			}
		}

		req.open("GET","getLanguages.php",true);
		req.send();
	};

	ctrl.init = function(){
		var req=createXHTMLHttpRequest();

		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				$scope.$apply(function () {
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
					ctrl.phone=ret[0].Phone;
					ctrl.phone_bil=ret[0].PhoneBilling;
					ctrl.email_bil=ret[0].EmailReferenceBilling;
					ctrl.nratings=ret[0].nratings;
					ctrl.info_bil=ret[0].InfoBilling;
				});
				return (true);
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
		}

		req.open("GET", 'getTranslatorData.php?user='+getUsername()+'&token='+getToken(), true);
		req.send();	
	}

	ctrl.$onInit= function(){
		ctrl.init();
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
		return /[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.+[a-z]{2,3}/.test(ctrl.email_bil);
	}
	

	ctrl.validForm = function(){
		return ctrl.isemailvalid() && ctrl.isibanvalid();
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
					"Email": ctrl.email,
					"EmailReferenceBilling": ctrl.email_bil,
					"phone": ctrl.phone,
					"phonebilling": ctrl.phone_bil,
					"IBAN": ctrl.IBAN,
					"IdMothertongue": ctrl.IdMothertongue,
					"IdCountry": ctrl.IdCountry,
					"SWIFT": ctrl.swift,
					"StateProvince": ctrl.state,
					"InfoBilling": ctrl.info_bil
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



angular.module('LanguagePairsAppCtrl',[]).controller('LanguagePairsAppCtrl',function($scope) {
	var ctrl=this;

	$scope.loadLanguages = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				$scope.$apply(function () {
					var ret = convertJSON(req.responseText);
					$scope.Languages=ret;
				});
			}
		}
		req.open("GET","getLanguages.php?",true);
		req.send();
	}


	$scope.loadFields = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				$scope.$apply(function () {
					var ret = convertJSON(req.responseText);
					$scope.Fields=ret;
				});
			}
		}
		req.open("GET","getFields.php",true);
		req.send();
	}

	$scope.loadServices = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				$scope.$apply(function () {
					var ret = convertJSON(req.responseText);
					$scope.Services=ret;
				});
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
				$scope.$apply(function () {
					var ret = convertJSON(req.responseText);
					$scope.Currencies=ret;
				});
				return true;
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
	}

	$scope.closeModal=function(){
		$('#LanguageModal').modal('hide');
	}


	$scope.submit= function(){

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
				}else if(convertJSON(response).statuscode==301){
					$('#alertOK').fadeIn().delay(10000).fadeOut();
					$('#alertOK').html("Your data was not updatet because you have open jobs in that language.");
					notify("Your data not uptdate because you have open jobs in that language.");
				}else if(convertJSON(response).statuscode==302){
					$('#alertOK').fadeIn().delay(5000).fadeOut();
					$('#alertOK').html("Your was was not updated because you have open jobs in that language.");
					notify("Your data not uptdate because you have open jobs in that language.");
				}else if(convertJSON(response).statuscode==305){
					$('#alertOK').fadeIn().delay(5000).fadeOut();
					$('#alertOK').html("Your was was not updated because you have already that language.");
					notify("Your data not uptdate because you have already that language.");
				}else {
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
	angular.bootstrap(document.getElementById('PersonalAppID'), ['PersonalAppCtrl']);
	angular.bootstrap(document.getElementById('LanguagePairsAppID'), ['LanguagePairsAppCtrl']);

});
