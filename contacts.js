var app

angular.module('ContactsAppCtrl',[]).controller('ContactsAppCtrl',function($scope) {

	var ctrl = this;
	
	ctrl.isemailvalid = function(){
		return /[a-zA-Z0-9.]+@[a-zA-Z0-9\.]+\.+[a-z]{2,3}/.test(ctrl.email);
	}
	
	ctrl.validForm = function(){
		return ctrl.isemailvalid();
	}
	
	ctrl.submit = function(){
		var req = createXHTMLHttpRequest() ;
		req.onreadystatechange = function(){
			if (req.status == 200){
				$('#alertOK').fadeIn().delay(10000).fadeOut();
				$('#alertOK').html("Message sent..");
				return(true);
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
		};

		req.open("GET", "message.php"+"?"+
				"name="+ctrl.name+
				"&subject="+ctrl.subject+
				"&message="+ctrl.message+
				"&email="+ctrl.email
		, true);
		req.send();
	}
	
});









angular.element(document).ready(function() {
	angular.bootstrap(document.getElementById('ContactsAppID'), ['ContactsAppCtrl']);
});

