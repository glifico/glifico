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
		onFileUploadTranslated(){
			//uploaded
		},
	}).then(function(result) {
		var temp = {
				user : getUsername(),
				token : getToken(),
				id: id,
				url: result.filesUploaded[0]["url"]
		};

		var stringPass = JSON.stringify(temp);
		var data = stringPass;

		$.ajax( {
			type : "POST",
			dataType : "application/json",
			contentType : "application/json; charset=utf-8",
			data : data,
			url : "setJobTranslated.php",
			complete : function(ret) {
				var response=ret.responseText;
				$("#alertOK").html("Job Translated!");
				$("#alertOK").fadeIn().delay(2000).fadeOut();
				$("#jobModal").hide();
				location.href=location.href;
			},
			error : function(xhr) {
				if (xhr.status == 500) {
					$("#alertError").html("Error from server, please retry.");
					$("#alertError").fadeIn().delay(1000).fadeOut();
				}

			}
		});

	},function(result){
		alert("Error while uploading");
	});

};

acceptJob=function(id){
	var temp = {
			user : getUsername(),
			token : getToken(),
			id: id,
	};

	var stringPass = JSON.stringify(temp);
	var data = stringPass;
	
	$.ajax( {
		type : "POST",
		dataType : "application/json",
		contentType : "application/json; charset=utf-8",
		data : data,
		url : "setJobAssigned.php",
		complete : function(ret) {
			var response=ret.responseText;
			$("#alertOK").html("Job Translated!");
			$("#alertOK").fadeIn().delay(2000).fadeOut();
			$("#jobModal").hide();
			location.href=location.href;
		},
		error : function(xhr) {
			if (xhr.status == 500) {
				$("#alertError").html("Error from server, please retry.");
				$("#alertError").fadeIn().delay(1000).fadeOut();
			}

		}
	});

}

angular.module("pendingJobs",[]).controller("pendingJobs",function(){
	var ctrl=this;

	ctrl.getClass=function(doc){
		if (doc.status=="Pending") return "bg-info";
		if (doc.status=="Closed") return "bg-success";
		if (doc.status=="Assigned") return "bg-warning";
		if (doc.status=="Translated") return "bg-info";
		if(doc.status=="To Be Assigned") return "bg-danger";
		return "row";
	}

	ctrl.getToolTip=function(doc){
		if (doc.status=="Pending") return "Agency will pay this job";
		if (doc.status=="Closed") return "Job is Translated and payed";
		if (doc.status=="Assigned") return "When you have done you should update the translated document";
		if (doc.status=="Translated") return "Agency need to review and approve this job";
		if(doc.status=="To Be Assigned") return "You can accept this job";
		return "row";
	}
	
	ctrl.createTable=function(){
		var html="";	
		html+='<table class="table table-responsive">';
		html+='<thead class="thead-default">';
		html+='<tr class="row">';
		html+='<th class="col-md-3" style="text-align:center;">Job</th>';
		html+='<th class="col-md-3" style="text-align:center;">Price</th>';
		html+='<th class="col-md-3" style="text-align:center;">Status</th>';
		html+='<th class="col-md-3" style="text-align:center;"></th>';
		html+='</tr>';
		html+='</thead>';
		for (var i = 0; i < ctrl.documents.length; i++) {
			var doc=ctrl.documents[i];
			html+='<tr class="row '+ctrl.getClass(doc)+'">';
			html+='<td class="col-md-4">'+doc.job+'</td>';
			html+='<td class="col-md-4">'+doc.price+doc.currency+'</td>';
			if(doc.status=="Pending"){
				html+='<td class="col-md-4" data-toggle="tooltip" data-placement="top" title="'+ctrl.getToolTip(doc)+'">'+"Accepted"+'</td>';
			}else{
				html+='<td class="col-md-4" data-toggle="tooltip" data-placement="top" title="'+ctrl.getToolTip(doc)+'">'+doc.status+'</td>';
			}
			html+='<td class="col-md-4">';
			html+='<div id="'+doc.id+'">';
			if(doc.status=="Closed"){
				html+='<i class="fa fa-check" aria-hidden="true"></i></div>';
			}else if(doc.status=="Assigned"){
				html+='<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-status="'+doc.status+'"';
				html+=' data-description="'+doc.description+'"';
				html+='>Show job</button>';
			}else if(doc.status=="Translated"){
				html+='Waiting approval...';
			}else if(doc.status=="Pending"){
				html+='Waiting payment...';
			}else if(doc.status=="To Be Assigned"){
				html+='<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-status="'+doc.status+'"';
				html+=' data-description="'+doc.description+'"';
				html+='>Show job and accept it</button>';
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
