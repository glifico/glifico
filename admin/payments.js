angular.module("Payments",[]).controller("Payments",function(){
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
		html+='<table id="d_table" class="table table-responsive">';
		html+='<thead class="thead-default">';
		html+='<tr class="row">';
		html+='<th class="col-md-2" style="text-align:center;">Job</th>';
		html+='<th class="col-md-2" style="text-align:center;">Price</th>';
		html+='<th class="col-md-2" style="text-align:center;"># characters</th>';
		html+='<th class="col-md-2" style="text-align:center;">Creation date</th>';
		html+='<th class="col-md-2" style="text-align:center;">Deadline</th>';
		html+='<th class="col-md-2" style="text-align:center;">Status</th>';
		html+='<th class="col-md-2" style="text-align:center;"></th>';
		html+='</tr>';
		html+='</thead>';
		html+='<tbody>';
		for (var i = 0; i < ctrl.documents.length; i++) {
			var doc=ctrl.documents[i];
			html+='<tr class="row '+ctrl.getClass(doc)+'">';
			html+='<td class="col-md-2">'+doc.job+'</td>';
			if(doc.choice==0){
				html+='<td class="col-md-2">';
				html+=doc.price[0]+" "+doc.currency[0]+"<br>";
				html+=doc.price[1]+" "+doc.currency[1];
				html+='</td>';
			}else{
				html+='<td class="col-md-2">'+doc.price+" "+doc.currency+'</td>';
			}
			html+='<td class="col-md-2">'+doc.ncharacters+'</td>';
			html+='<td class="col-md-2">'+doc.createdline+'</td>';
			html+='<td class="col-md-2">'+doc.deadline+'</td>';
			html+='<td class="col-md-2" data-toggle="tooltip" data-placement="top" title="'+ctrl.getToolTip(doc)+'">'+doc.status;
			if(doc.status=="Paid"){
				html+=' <i class="fas fa-check" aria-hidden="true"></i>';
			}
			html+='</td>';
			html+='<td class="col-md-2">';
			html+='<div id="'+doc.id+'">';
			if(doc.status=="Closed"){

			}else if(doc.status=="Paid"){
				html+='<button type="button" class="btn btn-success" data-toggle="modal" data-target="#jobModal"';
				html+='data-status="'+doc.status+'"';
				html+='data-job="'+doc.job+'"';
				html+='data-id="'+doc.id+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-createdline="'+doc.createdline+'"';
				html+=' data-deadline="'+doc.deadline+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-description="'+doc.description+'"';
				html+=' data-document="'+doc.document+'"';
				html+='>Download recipe</button>';
			}else if (doc.status=="Approved"){
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
				html+=' data-document="'+doc.document+'"';
				html+='>Show Job</button>';
			}else if(doc.status=="To Be Assigned"){
			}
			html+='</div>';
			html+='</td>';
			html+='</tr>';
		}
		html+="</tbody>";
		html+='</table>';
		console.debug("table");
		$("#paymentstable").html(html);
		$("#d_table").DataTable({
			paging: false,
			searching: false
		});
	}

	ctrl.$onInit=function(){
		console.debug("init");
		var url = "getPendingPayments.php?user=admin&token=glifico";

		var req = createXHTMLHttpRequest() ;
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var data=JSON.parse(req.responseText);
				ctrl.documents=data;
				ctrl.createTable();
				console.debug(data);
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
	angular.bootstrap(document.getElementById('payments'), ['Payments']);
});
