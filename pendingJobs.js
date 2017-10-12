$(document).ready(function () {

});

var client = filestack.init('AY86cSRLQTreZccdDlJimz',{
	policy: "eyJoYW5kbGUiOiIiLCJleHBpcnkiOjE1MDYxNjEyMDh9=",
})

showPicker=function(id) {
	client.pick({
		accept: ['.pdf','.odt','.doc','.docx','.txt'],
		maxFiles: 1,
		onClose(){

		},
		onFileUploadFinished(){
			//uploaded
		},
	}).then(function(result) {
		var url = "setJobFinished.php?user="+getUsername()+"&token="+getToken()+"&id=" + id+"&url="+result.filesUploaded[0]["url"];

		var req = createXHTMLHttpRequest() ;
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var data=JSON.parse(req.responseText);
				if(data['statuscode']==200){
					$("#alertOK").html("Job finished!");
					$("#alertOK").fadeIn().delay(2000).fadeOut();
					$("#jobModal").hide();
					location.href=location.href;
				}
			}else{
				mostraDialogTimed('errorPanel');
			}
		}
		req.open("GET",url,true);
		req.send();
		
	},function(result){
		alert("Error while uploading");
	});

};

angular.module("pendingJobs",[]).controller("pendingJobs",function(){
	var ctrl=this;

	ctrl.getClass=function(doc){
		if (doc.status=="Pending") return "bg-danger";
		if (doc.status=="Completed") return "bg-success";
		if (doc.status=="Ongoing") return "bg-info";
		if (doc.status=="Finished") return "bg-warning";
		return "row";
	}

	ctrl.createTable=function(){
		var html="";	
		html+='<table class="table table-responsive">';
		html+='<thead class="thead-default">';
		html+='<tr class="row">';
		html+='<th class="col-md-4" style="text-align:center;">Job</th>';
		html+='<th class="col-md-4" style="text-align:center;">Price</th>';
		html+='<th class="col-md-4" style="text-align:center;">Status</th>';
		html+='<th class="col-md-4" style="text-align:center;"></th>';
		html+='</tr>';
		html+='</thead>';
		for (var i = 0; i < ctrl.documents.length; i++) {
			var doc=ctrl.documents[i];
			html+='<tr class="row '+ctrl.getClass(doc)+'">';
			html+='<td class="col-md-4">'+doc.job+'</td>';
			html+='<td class="col-md-4">'+doc.price+doc.currency+'</td>';
			if(doc.status=="Pending"){
				html+='<td class="col-md-4">'+"Accepted"+'</td>';
			}else{
				html+='<td class="col-md-4">'+doc.status+'</td>';
			}
			html+='<td class="col-md-4">';
			html+='<div id="'+doc.id+'">';
			if(doc.status=="Completed"){
				html+='<i class="fa fa-check" aria-hidden="true"></i></div>';
			}else if(doc.status=="Ongoing"){
				html+='<button type="button" class="btn btn-info" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-status="'+doc.status+'"';
				html+=' data-description="'+doc.description+'"';
				html+='>Show job</button>';
			}else if(doc.status=="Finished"){
				html+='Waiting payment...';
			}else if(doc.status=="Pending"){
				html+='Waiting approval...';
			}
			html+='</td>';
			html+='<tr>';
		}
		html+='</table>';
		$("#table").html(html);
	}

	ctrl.$onInit=function(){
		var url = "getPendingJobs.php?user=" + getUsername()+"&token="+getToken();

		var req = createXHTMLHttpRequest() ;
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var data=JSON.parse(req.responseText);
				ctrl.documents=data;
				ctrl.createTable();
				return(true);
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
		}
		req.open("GET",url,true);
		req.send();
	}

});



angular.element(document).ready(function() {
	console.log("registro pendingJobs");
	angular.bootstrap(document.getElementById('pendingJobs'), ['pendingJobs']);
});
