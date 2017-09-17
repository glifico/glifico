/**
 * 
 */

angular.module("upController",[])
.controller("uploadController",function uploadController(){
	var ctrl=this;
	
	var client = filestack.init('ALwn7aYCDTAConyTqVba8z');
	
	ctrl.$init=function(){
		ctrl.showpay=false;
		ctrl.storedUrl="";
	};
	
	ctrl.showPicker=function() {
		client.pick({
			accept: ['.pdf','.odt','.doc','.docx','.txt'],
			maxFiles: 1,
		}).then(function(result) {
			ctrl.storedUrl=result.filesUploaded[0]["url"];
			console.log(ctrl.storedUrl);
			ctrl.showpay=true;
		});
	};

})


angular.element(document).ready(function() {
        console.log("registro upload");
        angular.bootstrap(document.getElementById('upController'), ['upController']);
    });


