/**
 *
 */

angular.module("uploadController",[])
.controller("uploadController",function upController(){
	var ctrl=this;

	var client = filestack.init('AY86cSRLQTreZccdDlJimz',{
		policy: "eyJoYW5kbGUiOiIiLCJleHBpcnkiOjE1MDYxNjEyMDh9=",
	});

	ctrl.$onInit=function(){
		ctrl.translator=getUsername();
		//document.getElementById("remove").style.visibility="hidden";
	}


	ctrl.showPicker=function() {
		client.pick({
			accept: ['.pdf','.odt','.doc','.docx','.txt'],
			maxFiles: 1,
			onClose(){

			},
			onFileUploadFinished(){

			},
		}).then(function(result) {

		},function(result){
			alert("error while uploading");
		});

	};

	
})


angular.element(document).ready(function() {
	console.log("registro upload");
	angular.bootstrap(document.getElementById('upController'), ['uploadController']);
});
