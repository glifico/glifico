/**
 * captcha
 */


var widgetAge;
var widgetTrad;
var onloadCallback = function() {
	widgetTrad = grecaptcha.render('captchaTrad', {
		'sitekey' : '6Lf1wjEUAAAAAOf4MdQzLzsqsdp4t_Wzp6BzfXpu',
		'theme' : 'light'
	});
	widgetAge = grecaptcha.render('captchaAge', {
		'sitekey' : '6Lf1wjEUAAAAAOf4MdQzLzsqsdp4t_Wzp6BzfXpu',
		'theme' : 'light'
	});
};

var wrongCaptcha="Please complete captcha";


/**
 * Translator
 */

function showRegAge(){
	$("#regTrad").hide();
	$("#regAge").show();
}

function showRegTrad(){
	$("#regAge").hide();
	$("#regTrad").show();
}


angular.module("regTradcontroller",[]).controller("regTradcontroller",function($scope){
	var ctrl=this;

	ctrl.$onInit=function(){
		ctrl.password="";
		ctrl.tec=false;
	}

	ctrl.isuservalid = function(){
		return /[a-zA-Z0-9]{7,}/.test(ctrl.username);
	}

	ctrl.isemailvalid = function(){
		return /[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.+[a-z]{2,3}/.test(ctrl.email);
	}

	ctrl.ispasswordvalid = function(){
		return /[a-zA-Z0-9]{7,}/.test(ctrl.password);
	}

	ctrl.invalidForm = function(){
		return !(ctrl.ispasswordvalid()&&ctrl.isemailvalid()&&ctrl.isuservalid()&&ctrl.tec);
	}

	ctrl.passwordmatch = function() {
		return !(ctrl.password===ctrl.reppassword);	
	}

	ctrl.submit = function(){
		if(grecaptcha.getResponse(widgetTrad).length>1){
			var req = createXHTMLHttpRequest() ;
			req.onreadystatechange = function(){
				if (req.status == 200&&req.readyState==4){
					var response=convertJSON(req.responseText);
					if(response['statuscode']==200){
						$('#alertOK').fadeIn().delay(10000).fadeOut();
						$('#alertOK').html("Thanks. We have sent you an email with a confirmation link.");
						$("#loginModal").hide();
						location.href="index.html";
						return(true);
					}else if(response['statuscode']==408){
						alert("Username already got, please try another");
					}else if(response['statuscode']==409 || response['statuscode']==410){
						alert("Email already present in our systems, try forget password button");
					}else{
						$('#alertError').fadeIn().delay(10000).fadeOut();
						$('#alertError').html("Error from server");
						return(false);
					}
				}
			}
			req.open("GET", "confirmMailT.php"+"?"+
					"user="+ctrl.username+
					"&name="+ctrl.name+
					"&lastname="+ctrl.surname+
					"&password="+ctrl.password+
					"&email="+ctrl.email+
					"&VAT="+ctrl.vat
					, true);
			req.send();

		}else{
			alert(wrongCaptcha);
		}
	}


});


angular.element(document).ready(function() {
	console.log("registro regTradcontroller");
	angular.bootstrap(document.getElementById('regTradForm'), ['regTradcontroller']);
});



/**
 * Agency
 */


angular.module("regAgecontroller",[]).controller("regAgecontroller",function($scope){
	var ctrl=this;

	ctrl.$onInit=function(){
		ctrl.password="";
		ctrl.tec=false;
	}

	ctrl.isuservalid = function(){
		return /[a-zA-Z0-9]{7,}/.test(ctrl.username);
	}

	ctrl.isemailvalid = function(){
		return /[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.+[a-z]{2,3}/.test(ctrl.email);
	}

	ctrl.ispasswordvalid = function(){
		return /[a-zA-Z0-9]{7,}/.test(ctrl.password);
	}

	ctrl.invalidForm = function(){
		return !(ctrl.ispasswordvalid()&&ctrl.isemailvalid()&&ctrl.isuservalid()&&ctrl.tec);
	}

	ctrl.passwordmatch = function() {
		return !(ctrl.password===ctrl.reppassword);	
	}

	ctrl.Agesubmit = function(){
		if(grecaptcha.getResponse(widgetAge).length>1){
			var req = createXHTMLHttpRequest() ;
			req.onreadystatechange = function(){
				if (req.status == 200&&req.readyState==4){
					var response=convertJSON(req.responseText);
					if(response['statuscode']==200){
						$('#alertOK').fadeIn().delay(10000).fadeOut();
						$('#alertOK').html("Thanks. We have sent you an email with a confirmation link.");
						$("#loginModal").hide();
						location.href="index.html";
						return(true);
					}else if(response['statuscode']==408){
						alert("Username already got, please try another");
					}else if(response['statuscode']==409 || response['statuscode']==410){
						alert("Email already present in our systems, try forget password button");
					}else{
						$('#alertError').fadeIn().delay(10000).fadeOut();
						$('#alertError').html("Error from server");
						return(false);
					}
				}
			};

			req.open("GET", "confirmMailA.php"+"?"+
					"user="+ctrl.username+
					"&name="+ctrl.companyname+
					"&VAT="+ctrl.vat+
					"&password="+ctrl.password+
					"&email="+ctrl.email
					, true);
			req.send();
		}else{
			alert(wrongCaptcha);
		};
	}


});

angular.element(document).ready(function() {
	console.log("registro regAge");
	angular.bootstrap(document.getElementById('regAgeForm'), ['regAgecontroller']);
});
