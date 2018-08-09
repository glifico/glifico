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


angular.module("infoAgecontroller",[]).controller("infoAgecontroller",function($scope){

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

	ctrl.$onInit= function(){
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
					ctrl.LoadCountries();
					ctrl.companyname=ret[0].CompanyName;
					ctrl.vat=ret[0].VATCode;
					ctrl.street=ret[0].Street;
					ctrl.city=ret[0].City;
					ctrl.country=ret[0].Country;
					ctrl.zip=ret[0].ZIP;
					ctrl.email=ret[0].EmailReference;
					ctrl.IBAN=ret[0].IBAN;
					ctrl.swift=ret[0].swift;
					ctrl.phone=ret[0].PhoneReference;
					ctrl.phone_bil=ret[0].PhoneReferenceBilling;
					ctrl.email_bil=ret[0].EmailReferenceBilling;
					return (true);
				}
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
		}

		req.open("GET", 'getAgencyData.php?user='+getUsername()+'&token='+getToken(), true);
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

	ctrl.Agesubmit=function(){

		var arr={
				"user": getUsername(),
				"token": getToken(),
				"values": {
					"FiscalCode": ctrl.vat,
					"Street": ctrl.street,
					"City": ctrl.city,
					"Country": ctrl.country,
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

});

angular.element(document).ready(function() {
	console.log("registro infoAge");
	angular.bootstrap(document.getElementById('infoAgeForm'), ['infoAgecontroller']);
});