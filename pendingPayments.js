$(document).ready(function () {
	
});

angular.module("pendingPayments",[]).controller("pendingPayments",function(){
	var ctrl=this;

	ctrl.getClass=function(status){
		if (status=="Pending") return "bg-danger";
		if (status=="Completed") return "bg-success";
		return "row";
	}
	
	ctrl.newPayment=function(doc){
		alert("should pay"+doc.id+doc.job);
		window.open('payDocument.html','_newtab');
	}
	
	ctrl.documents=[
		{
			"id":"111",
			"job":"pippo",
			"price":12.3,
			"currency":"€",
			"status":"Pending",
		},
		{
			"id":"112",
			"job":"pluto",
			"price":1.34,
			"currency":"€",
			"status":"Pending",
		},
		{
			"id":"113",
			"job":"pluto",
			"price":1.34,
			"currency":"€",
			"status":"Completed",
		}
	]
	
});



angular.element(document).ready(function() {
    console.log("registro pendingPayment");
    angular.bootstrap(document.getElementById('pendingPayments'), ['pendingPayments']);
});
