angular.module("resetController",[])
.controller("resetController",function resetController(){
	var ctrl=this;
	ctrl.$onInit=function(){
		ctrl.user="";
		ctrl.password="";
	};

	ctrl.onSubmit=function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange=function(){
			if(req.status==200){
				message('Thanks. We have sent you an email with instructions.');
			}else{

			}
			req.open("https://glifico.herokuapp.com/resetPassword.php?user="+ctrl.user,false);
			req.send();
		}
	};

	ctrl.onChangePassword=function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange=function(){
			if(req.status==200){
				if(JSON.encode(req.responseText)['statuscode']==200){
					message('Thanks. Password updated');
				}
			}else{

			}
			req.open("https://glifico.herokuapp.com/changePassword.php?"+"password="+ctrl.password+"&"+location.href.substring(startQuery,endQuery),false);
			req.send();
		}
	}


	function message(messageStr){
		$('#alertOK').fadeIn().delay(2000).fadeOut;
		$('#alertOK').html(messageStr);
	};
});

angular.element(document).ready(function() {
	console.log("registro reset");
	angular.bootstrap(document.getElementById('resetPassword'), ['resetController']);
});