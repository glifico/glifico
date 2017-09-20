angular.module('Authentication',[])
  
.controller('loginController', function loginController($scope, $document) {
	var ctrl=this;
	ctrl.username=getUsername();
	
	
	function getUsername() {
    		var return_value = null;

    		var pos_start = document.cookie.indexOf(cookie_username+"=");

    		if (pos_start != -1) { // Cookie already set, read it
    			pos_start+=cookie_username.length+1;
			var pos_end=document.cookie.indexOf("$", pos_start); // Find ";" after the start position
        		if (pos_end == -1) pos_end = document.cookie.length;
        		return_value = unescape( document.cookie.substring(pos_start, pos_end) );
   		 }

   	 return return_value; // null if cookie doesn't exist, string otherwise
	}
});

angular.element(document).ready(function() {
        console.log("registro Authentication");
        angular.bootstrap(document.getElementById('loginController'), ['Authentication']);
    });
