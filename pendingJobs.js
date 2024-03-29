$(document).ready(function () {

});

var client = filestack.init('AY86cSRLQTreZccdDlJimz',{
	policy: "eyJoYW5kbGUiOiIiLCJleHBpcnkiOjE1MDYxNjEyMDh9=",
})

var acceptableFormats=['.pdf','.odt','.doc','.docx','.txt']
var NacceptableFiles=1

var isPreviewUploaded=false;
var previewURL="";

uploadFull=function(id, choice) {
	if(!isPreviewUploaded){
		alert("Please upload a preview of the document")
	}else{
		client.pick({
			accept: acceptableFormats,
			maxFiles: NacceptableFiles,
			onClose(){

			}
		}).then(function(result) {
			translateJob(id, choice, result);
		},function(result){
			alert("Error while uploading");
		});
	}
}

uploadPreview=function(id){
	client.pick({
		accept: acceptableFormats,
		maxFiles: NacceptableFiles,
		onClose(){

		}
	}).then(function(result) {
		previewURL=result.filesUploaded[0]["url"]
		isPreviewUploaded=true
		$("#preview").html('<i class="fas fa-check"></i> preview uploaded');
		$("#full").show();
		notify("Preview correctly uploaded");
	},function(result){
		alert("Error while uploading");
	});
}

translateJob=function(id, choice, result){
	var temp = {
			user : getUsername(),
			token : getToken(),
			id: id,
			choice: choice,
			url: result.filesUploaded[0]["url"],
			preview: previewURL
	}

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
			$("#alertOK").fadeIn().delay(5000).fadeOut();
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

acceptJob=function(id, choice){
	var temp = {
			user : getUsername(),
			token : getToken(),
			choice: choice,
			id: id,
	}

	var stringPass = JSON.stringify(temp);
	var data = stringPass;

	$.ajax( {
		type : "POST",
		dataType : "application/json",
		contentType : "application/json; charset=utf-8",
		data : data,
		url : "setJobAccepted.php",
		complete : function(ret) {
			var response=ret.responseText;
			$("#alertOK").html("Job correctly set as assigned!");
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


refuseJob=function(id, choice){
	var temp = {
			user : getUsername(),
			token : getToken(),
			choice: choice,
			id: id,
	}

	var stringPass = JSON.stringify(temp);
	var data = stringPass;

	$.ajax( {
		type : "POST",
		dataType : "application/json",
		contentType : "application/json; charset=utf-8",
		data : data,
		url : "setJobRefused.php",
		complete : function(ret) {
			var response=ret.responseText;
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
		if (doc.status=="To Be Assigned") return "bg-warning";
		if (doc.status=="Assigned") return "bg-info";
		if (doc.status=="Refused") return "bg-danger";
		if (doc.status=="Translated") return "bg-warning";
		if (doc.status=="Approved") return "bg-info";
		if (doc.status=="Not Accepted") return "bg-danger";
		if (doc.status=="Paid") return "bg-success";
		if (doc.status=="Completed") return "bg-success";
		return "";
	}

	ctrl.getToolTip=function(doc){
		if (doc.status=="To Be Assigned") return "Translators need to Accept";
		if (doc.status=="Assigned") return "Translator is working";
		if (doc.status=="Refused") return "Translator refused";
		if (doc.status=="Translated") return "Work finished";
		if (doc.status=="Approved") return "Agency need to pay";
		if (doc.status=="Not Accepted") return "Work neither accepted or paid";
		if (doc.status=="Paid") return "Payment completed";
		if (doc.status=="Completed") return "Work closed definetely";
		return "";
	}

	ctrl.createTable=function(){
		var html="";	
		html+='<table id="data_table" class="table table-responsive">';
		html+='<thead class="thead-default">';
		html+='<tr class="row">';
		html+='<th class="col-md-3" style="text-align:center;">Job</th>';
		html+='<th class="col-md-2" style="text-align:center;">Price</th>';
		html+='<th class="col-md-2" style="text-align:center;"># characters</th>';
		html+='<th class="col-md-2" style="text-align:center;">Deadline</th>';
		html+='<th class="col-md-2" style="text-align:center;">Status</th>';
		html+='<th class="col-md-2" style="text-align:center;"></th>';
		html+='</tr>';
		html+='</thead>';
		html+='<tbody>';
		for (var i = 0; i < ctrl.documents.length; i++) {
			var doc=ctrl.documents[i];
			html+='<tr class="row '+ctrl.getClass(doc)+'">';
			html+='<td class="col-md-3">'+doc.job+'</td>';
			html+='<td class="col-md-2">'+doc.price+" "+doc.currency+'</td>';
			html+='<td class="col-md-2">'+doc.ncharacters+'</td>';
			html+='<td class="col-md-2">'+doc.deadline+'</td>';
			if(doc.choice==1) {choiceStr="as first";}
			else if(doc.choice==2) {choiceStr="as second";}
			if(doc.status=="To Be Accepted"){
				html+='<td class="col-md-2" data-toggle="tooltip" data-placement="top" title="'+ctrl.getToolTip(doc)+'">'+"To be accepted "+choiceStr+'</td>';
			}else{
				html+='<td class="col-md-2" data-toggle="tooltip" data-placement="top" title="'+ctrl.getToolTip(doc)+'">'+doc.status+'</td>';
			}
			html+='<td class="col-md-2">';
			html+='<div id="'+doc.id+'">';
			if(doc.status=="Closed"){
				html+='<button type="button" class="btn btn-success" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-status="'+doc.status+'"';
				html+=' data-choice="'+doc.choice+'"';
				html+=' data-description="'+doc.description+'"';
				html+=' data-document="'+doc.document+'"';
				html+='>Show job and download draft invoice</button>';
			}if(doc.status=="Paid"){
			}else if(doc.status=="Assigned"){
				html+='<button type="button" class="btn btn-info" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-status="'+doc.status+'"';
				html+=' data-choice="'+doc.choice+'"';
				html+=' data-description="'+doc.description+'"';
				html+=' data-document="'+doc.document+'"';
				html+='>Show job</button>';
			}else if(doc.status=="Translated"){
				html+='';
			}else if(doc.status=="Accepted"){
				html+='';
			}else if(doc.status=="To Be Assigned"){
				html+='<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-ncharacters="'+doc.ncharacters+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-status="'+doc.status+'"';
				html+=' data-description="'+doc.description+'"';
				html+=' data-choice="'+doc.choice+'"';
				html+=' data-document="'+doc.document+'"';
				html+='>Show job</button>';
			}
			html+='</div>';
			html+='</td>';
			html+='</tr>';
		}
		html+='</tbody>';
		html+='</table>';
		$("#table").html(html);
		$("#data_table").DataTable({
			paging: false,
			searching: false
		});
	}

	ctrl.refresh=function(){
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

	ctrl.$onInit=function(){		
		ctrl.refresh();
		ctrl.timer = setInterval(ctrl.refresh, 5*60*1000);
	}

});




angular.element(document).ready(function() {
	console.log("registro pendingJobs");
	angular.bootstrap(document.getElementById('pendingJobs'), ['pendingJobs']);
});
