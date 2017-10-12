$(document).ready(function () {

});

	
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
			html+='<td class="col-md-4">'+doc.status+'</td>';
			html+='<td class="col-md-4">';
			html+='<div id="'+doc.id+'">';
			if(doc.status=="Completed"){
				html+='<i class="fa fa-check" aria-hidden="true"></i></div>';
			}else if (doc.status=="Pending"){
				html+='<input class="btn btn-primary" type="button" value="Upload" ng-click="ctrl.showPicker()" ng-show="!ctrl.uploaded"/>';				
			}else if(doc.status=="Ongoing"){
				html+='<button type="button" class="btn btn-info" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-description="'+doc.description+'"';
				html+='>Show job</button>';
			}else if(doc.status=="Finished"){
				html+='Waiting payment';
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
