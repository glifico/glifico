angular.module('Authentication',[])

.controller('loginController', function loginController($scope, $document) {
	var ctrl=this;
	ctrl.username=getUsername();


	function getUsername() {
		var return_value = null;

		var pos_start = document.cookie.indexOf(maincookie+"=");

		if (pos_start != -1) { // Cookie already set, read it
			pos_start+=maincookie.length+1;
			var pos_end=document.cookie.indexOf("$", pos_start); // Find ";" after the start position
			if (pos_end == -1) pos_end = pos_start;
			//JSON object has at list two {}
			if(pos_end-pos_start<2){
				return null;
			}else{
				var string=document.cookie.substring(pos_start, pos_end);
				return_value = JSON.parse(string)['user'];
			}
		}
		return return_value; // null if cookie doesn't exist, string otherwise
	}
});

angular.element(document).ready(function() {
	console.log("registro Authentication");
	angular.bootstrap(document.getElementById('loginController'), ['Authentication']);
});
