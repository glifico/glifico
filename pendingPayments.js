$(document).ready(function () {

});

newPayment=function(id){
	location.href='payDocument.html'+'?token='+id;
}

approveJob=function(id){
	var url = "setPaymentApproved.php?user="+getUsername()+"&token="+getToken()+"&id=" + id;

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			if(data['statuscode']==200){
				$("#alertOK").html("Job approved!");
				$("#alertOK").fadeIn().delay(2000).fadeOut();
				location.href=location.href;
			}
		}else{
			mostraDialogTimed('errorPanel');
		}
	}
	req.open("GET",url,true);
	req.send();
}
	
angular.module("pendingPayments",[]).controller("pendingPayments",function(){
	var ctrl=this;

	ctrl.getClass=function(doc){
		if (doc.status=="To Be Assigned") return "bg-info";
		if (doc.status=="Assigned") return "bg-warning";
		if (doc.status=="Refused") return "bg-danger";
		if (doc.status=="Translated") return "bg-warning";
		if (doc.status=="Accepted") return "bg-info";
		if (doc.status=="Not Accepted") return "bg-info";
		if (doc.status=="Paid") return "bg-success";
		if (doc.status=="Completed") return "bg-success";
		return "";
	}

	ctrl.getToolTip=function(doc){
		if (doc.status=="To Be Assigned") return "Translators need to Accept";
		if (doc.status=="Assigned") return "Translator is working";
		if (doc.status=="Refused") return "Translator refused";
		if (doc.status=="Translated") return "Work finished";
		if (doc.status=="Accepted") return "Work to be paid";
		if (doc.status=="Not Accepted") return "work neither accepted or paid";
		if (doc.status=="Paid") return "ok";
		if (doc.status=="Completed") return "Work closed definetely";
		return "";
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
			html+='<td class="col-md-3">'+doc.job+'</td>';
			html+='<td class="col-md-3">'+doc.price+" "+doc.currency+'</td>';
			html+='<td class="col-md-3" data-toggle="tooltip" data-placement="top" title="'+ctrl.getToolTip(doc)+'">'+doc.status;
			if(doc.status=="Paid"){
				html+=' <i class="fa fa-check" aria-hidden="true"></i>';
			}
			html+='</td>';
			html+='<td class="col-md-3">';
			html+='<div id="'+doc.id+'">';
			if(doc.status=="Closed"){
				
			}else if(doc.status=="Paid"){
				html+='<button type="button" class="btn btn-info" onclick="generate_cutomPDF()">Download recipe</button>';
			}else if (doc.status=="Accepted"){
				html+='<button onClick="newPayment('+doc.id+')"  class="btn btn-primary">Pay now!</button>';				
			}else if(doc.status=="Assigned"){
				html+='<button type="button" class="btn btn-info" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-description="'+doc.description+'"';
				html+='>Show job</button>';
			}else if(doc.status=="Translated"){
				html+='<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#jobModal"';
				html+='data-status="'+doc.status+'"';
				html+='data-job="'+doc.job+'"';
				html+='data-id="'+doc.id+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-description="'+doc.description+'"';
				html+=' data-translated="'+doc.preview+'"';
				html+='>Approve Job</button>';
			}else if(doc.status=="To Be Assigned"){
				html+="Waiting for translator acceptance..";
			}
			html+='</div>';
			html+='</td>';
			html+='<tr>';
		}
		html+='</table>';
		$("#table").html(html);
	}

	ctrl.$onInit=function(){
		var url = "getPendingPayments.php?user=" + getUsername()+"&token="+getToken();

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
	console.log("registro pendingPayment");
	angular.bootstrap(document.getElementById('pendingPayments'), ['pendingPayments']);
});
