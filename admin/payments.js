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


	ctrl.createTable=function(){
		var html="";
		html+='<table id="d_table" class="table table-responsive">';
		html+='<thead class="thead-default">';
		html+='<tr class="row">';
		html+='<th class="col-md-1" style="text-align:center;">Id</th>';
		html+='<th class="col-md-1" style="text-align:center;">Job</th>';
		html+='<th class="col-md-2" style="text-align:center;">Price paid by agency</th>';
		html+='<th class="col-md-1" style="text-align:center;"># characters</th>';
		html+='<th class="col-md-1" style="text-align:center;">Creation date</th>';
		html+='<th class="col-md-1" style="text-align:center;">Deadline</th>';
		html+='<th class="col-md-2" style="text-align:center;">Price to be paied to translator</th>';
		html+='<th class="col-md-2" style="text-align:center;">Status</th>';
		html+='<th class="col-md-2" style="text-align:center;"></th>';
		html+='</tr>';
		html+='</thead>';
		html+='<tbody>';
		for (var i = 0; i < ctrl.documents.length; i++) {
			var doc=ctrl.documents[i];
			html+='<tr class="row '+ctrl.getClass(doc)+'">';
			html+='<td class="col-md-1">'+doc.id+'</td>';
			html+='<td class="col-md-1">'+doc.job+'</td>';
			html+='<td class="col-md-2">'+doc.price+" "+doc.currency+'</td>';
			html+='<td class="col-md-1">'+doc.ncharacters+'</td>';
			html+='<td class="col-md-1">'+doc.createdline+'</td>';
			html+='<td class="col-md-1">'+doc.deadline+'</td>';
			html+='<td class="col-md-2">'+doc.price_to_translator+'</td>';
			html+='<td class="col-md-2">'+doc.status;
			if(doc.status=="Closed"){
				html+=' <i class="fas fa-check" aria-hidden="true"></i>';
			}
			html+='</td>';
			html+='<td class="col-md-2">';
			html+='<div id="'+doc.id+'">';
			html+='<button type="button" class="btn btn-info" data-toggle="modal" data-target="#jobModal"';
			html+='data-status="'+doc.status+'"';
			html+=' data-job="'+doc.job+'"';
			html+=' data-id="'+doc.id+'"';
			html+=' data-price="'+doc.price+'"';
			html+=' data-price_to_translator="'+doc.price_to_translator+'"';
			html+=' data-ncharacters="'+doc.ncharacters+'"';
			html+=' data-status="'+doc.status+'"';
			html+=' data-field="'+doc.field+'"';
			html+=' data-createdline="'+doc.createdline+'"';
			html+=' data-deadline="'+doc.deadline+'"';
			html+=' data-currency="'+doc.currency+'"';
			html+=' data-description="'+doc.description+'"';
			html+=' data-document="'+doc.document+'"';
			html+=' data-preview="'+doc.preview+'"';
			html+=' data-translated="'+doc.translated+'"';
			html+=' data-urgency="'+doc.urgency+'"';
			html+=' data-translator_email="'+doc.translator_data.emailbilling+' '+doc.translator_data.email+'"';
			html+=' data-translator_iban="'+doc.translator_data.iban+'"';
			html+=' data-translator_info="'+doc.translator_data.infobilling+'"';
			html+='>Show more</button>';
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
				return(true);
			}else{
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
