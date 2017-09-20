angular.module("glificoFooter",[])
.controller('glificoFooterController', function glificoFooter() {
	var ctrl=this;

	ctrl.address="...";
});

angular.element(document).ready(function() {
        console.log("registro glificoFooter");
        angular.bootstrap(document.getElementById('glificoFooter'), ['glificoFooter']);
    });