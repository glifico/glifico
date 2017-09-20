angular.module("resetController",[])
.controller("resetController",function resetController(){
	var ctrl=this;
	ctrl.$onInit=function(){
		ctrl.user="";
		ctrl.password="";
		ctrl.resetCompleted=false;
		ctrl.submitCompleted=false;
		
		if(getLogged()){
			alert("You're loged in!");
			location.href="index.html";
		}
	};

	ctrl.onSubmit=function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange=function(){
			if(req.status==200&&req.readyState==4){
				ctrl.submitCompleted=true;
				$("#form").hide();
			}else{

			}
		}
		req.open("GET","https://glifico.herokuapp.com/resetPassword.php?user="+ctrl.user,true);
		req.send();
		message('Thanks. We have sent you an email with instructions.');
	};

	ctrl.onChangePassword=function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange=function(){
			if(req.status==200&&req.readyState==4){
				if(JSON.parse(req.responseText)['statuscode']==200){
					ctrl.resetCompleted=true;
					$("#form").hide();
					message('Thanks. Password updated');
				}else{
					errorMessage("Wrong token");
				}
			}else{
				errorMessage("There was an error, please retry");
			}
		}

		var startQuery=location.href.indexOf("?",0)+1;
		var endQuery=location.href.length;
		req.open("GET","https://glifico.herokuapp.com/changePassword.php?"+"password="+ctrl.password+"&"+location.href.substring(startQuery,endQuery),true);
		req.send();
	}


	function message(messageStr){
		$('#alertOK').fadeIn().delay(2000).fadeOut;
		$('#alertOK').html(messageStr);
	};

	function errorMessage(messageStr){
		$('#alertError').html(messageStr);
		$('#alertError').fadeIn().delay(1000).fadeOut();
	}
});

angular.element(document).ready(function() {
	console.log("registro reset");
	angular.bootstrap(document.getElementById('resetPassword'), ['resetController']);
});