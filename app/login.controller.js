(function(){
	'use strict';
  
angular.module('Authentication')
  
.controller('LoginController',
    ['$scope', '$rootScope', '$location', 'AuthenticationService',
    function ($scope, $rootScope, $location, AuthenticationService) {
    	var ctrl=this;
    	
        // reset login status
        AuthenticationService.ClearCredentials();
  
        $scope.login = function () {
            $scope.dataLoading = true;
            AuthenticationService.Login($scope.username, $scope.password, function(response) {
                if(response.success) {
                    AuthenticationService.SetCredentials($scope.username, $scope.password);
                    ctrl.isLogged=true;
                    $location.path('/');
                } else {
                    $scope.error = response.message;
                    $scope.dataLoading = false;
                }
            });
        };
    }]);
})

angular.element(document).ready(function() {
        console.log("registro Authentication");
        angular.bootstrap(document.getElementById('LoginController'), ['Authentication']);
    });