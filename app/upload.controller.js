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
		ctrl.title=ctrl.getTitle();
		ctrl.storedUrl="http://www.example.com";
		ctrl.uploaded=false;
		ctrl.translator=getUsername();
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
		document.getElementById("upDescr").style.visibility="visible";
		document.getElementById("remove").style.visibility="hidden";
	};

	
	ctrl.getTitle=function(){
	var start=location.href.indexOf("token=");
	start+=6;
	var end=location.href.length;
	var tok=location.href.substring(start,end);
	
	var toReturn=ctrl.askServer(tok);
	
	return toReturn;
	};
	
	ctrl.askServer=function(tok){
		return "Titolo da richiedere al server con il token"+tok;
	};
	
})


angular.element(document).ready(function() {
	console.log("registro upload");
	angular.bootstrap(document.getElementById('upController'), ['uploadController']);
});
