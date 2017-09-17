/**
 * 
 */

angular.module("uploadController",[])
.controller("uploadController",function upController(){
	var ctrl=this;

	var client = filestack.init('ALwn7aYCDTAConyTqVba8z',
			{
		policy:"eyJoYW5kbGUiOiJBTHduN2FZQ0RUQUNvbnlUcVZiYTh6IiwiZXhwaXJ5IjoxNTA1NjgyMzE5fQ",
			});

	ctrl.$onInit=function(){
		ctrl.storedUrl="http://www.example.com";
		ctrl.uploaded=false;
		document.getElementById("remove").style.visibility="hidden";
	}


	ctrl.showPicker=function() {
		client.pick({
			accept: ['.pdf','.odt','.doc','.docx','.txt'],
			maxFiles: 1,
			onClose(){
				console.debug("close");
			},
			onFileUploadFinished(){
				ctrl.storedUrl="endend";
				console.debug("finished");
			},
		}).then(function(result) {
			document.getElementById("url").innerHTML="<a href=\""+result.filesUploaded[0]["url"]+"\" target=\"_Blank\">Download File</a>";
			document.getElementById("remove").style.visibility="visible";
			document.getElementById("upDescr").style.visibility="hidden";
		},function(result){
			alert("error while uploading");
		});

	};

	ctrl.remove=function(){
		document.getElementById("url").innerHTML="";
		document.getElementById("upThanks").style.visibility="hidden";
	};

})


angular.element(document).ready(function() {
	console.log("registro upload");
	angular.bootstrap(document.getElementById('upController'), ['uploadController']);
});


