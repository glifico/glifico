$(document).ready(function () {
	$('#payCompleted').hide();

	if(!isAgency()){
		$("#payDocumentBody").hide();

		alert("Please login as agency");
	}

});

function getPaymentId(){
	var start=location.href.indexOf("token=",0)+6;
	var end=location.href.length;
	return location.href.substring(start,end);
}

function paymentCompleted(){
	$('#payCompleted').show();
	$('#payment').hide();
	var url = "setPaymentPaid.php?user="+getUsername()+"&token="+getToken()+"&id=" + getPaymentId();

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			if(data['statuscode']==200){
				notify("Payment completed");
				alert("Payment completed $$");
				location.href="pendingPayments.html";
			}
		}else{
			mostraDialogTimed('errorPanel');
		}
	}
	req.open("GET",url,true);
	req.send();
}

angular.module("payment",[])
.controller("paymentController",function($scope){
	var ctrl=this;

	ctrl.createPage=function(){
		var html="";
		html+="You have to pay for <b>"+ctrl.job+"</b><br>";
		html+='<table class="table">';
		html+='<tbody>';
		html+='<tr><td>Taxable:</td><td>'+ctrl.taxable+'</td></tr>';
		html+='<tr><td>Tax Rate:</td><td>22%</td></tr>';
		html+='<tr><td>VAT:</td><td>'+ctrl.tax+'</td></tr>';
		html+='<tr><td>To Be Paid:</td><td>'+ctrl.amount+'</td></tr>';
		html+='</tbody>';
		html+='</table>'

		$("#message").html(html);
	}

	ctrl.createPaypal=function(){
		paypal.Button.render({

			env: 'production', // Or 'sandbox'

			client: {
				sandbox:    'AYB0shOY_nnLb7wt0_5T6kN0x3lZkAzOdLyCFcaBLrJuuVHv0E8IK1APo6c3rzaX1oBLCep3LLoa13zT',
				production: 'AaOBmMuxg4dlVhxWPc2iWzwm4EbeiIt4G2V35LxyuDJ4UdJ8-YhseQw9zg4tPIkuvmY6eXa2wDKRHJH6'
			},

			locale: 'en_US',

			commit: true, // Show a 'Pay Now' button

			style: {
				size:'medium',
				color: 'silver',
				label: 'pay',
			},



			payment: function(data, actions) {
				return actions.payment.create({
					payment: {
						transactions: [
							{
								amount: { total: ctrl.amount, currency: 'EUR' }
							}
							]
					},
					experience: {
						input_fields: {
							no_shipping: 1
						}
					},
				});
			},



			onAuthorize: function(data, actions) {
				return actions.payment.execute().then(function(payment) {
					// The payment is complete!
					// You can now show a confirmation message to the customer

					notify("Payment accepted by Paypal!");

					paymentCompleted();

				});
			},

			onCancel: function(data, actions) {
				alert("Payment doesn't end well...");
				location.href=location.href;
			}


		}, '#paypal-button');
	}

	ctrl.$onInit=function(){
		var url = "getPayment.php?user="+getUsername()+"&token="+getToken()+"&id=" + getPaymentId();

		var req = createXHTMLHttpRequest() ;
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				$scope.$apply(function (){
					var data=JSON.parse(req.responseText);
					ctrl.taxable=Number(data.price).toFixed(2);
					ctrl.tax=Number(ctrl.taxable*0.22).toFixed(2);
					ctrl.amount=Number(1.22*ctrl.taxable).toFixed(2);
					ctrl.job=data.job;
					ctrl.createPage();
					ctrl.createPaypal();
				});
			}else{
				mostraDialogTimed('errorPanel');
			}
		}
		req.open("GET",url,true);
		req.send();

	}

});



angular.element(document).ready(function() {
	console.log("registro payment");
	angular.bootstrap(document.getElementById('payment'), ['payment']);
});
