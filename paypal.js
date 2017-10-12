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
	var url = "setPaymentPaied.php?user="+getUsername()+"&token="+getToken()+"&id=" + getPaymentId();

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			if(data['statuscode']==200){
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
.controller("paymentController",function(){
	var ctrl=this;

	ctrl.createPage=function(){
		var html="";
		html+="You have to pay "+ctrl.amount+" EUR for <b>"+ctrl.job+"</b>";

		$("#message").html(html);
	}

	ctrl.createPaypal=function(){
		paypal.Button.render({

			env: 'sandbox', // Or 'production'

			locale: 'en_US',

			client: {
				sandbox:    'AZRBS2QBR8wGqZxOApvDTn-Mte7wfv7iXGLxa-tN1UlmvFflKoyulHT_eunIcuwdW7667-jSgOOgCU5V',
				production: '<????>'
			},

			commit: true, // Show a 'Pay Now' button

			style: {
				size:'medium',
				color: 'silver',
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
					}
				});
			},



			onAuthorize: function(data, actions) {
				return actions.payment.execute().then(function(payment) {
					// The payment is complete!
					// You can now show a confirmation message to the customer

					alert("Payment completed!");

					paymentCompleted();

				});
			},

			onCancel: function(data, actions) {
				alert("Payment doesn't end well :-(");
			}


		}, '#paypal-button');
	}

	ctrl.$onInit=function(){
		var url = "getPayment.php?user="+getUsername()+"&token="+getToken()+"&id=" + getPaymentId();

		var req = createXHTMLHttpRequest() ;
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var data=JSON.parse(req.responseText);
				ctrl.amount=data.price;
				ctrl.job=data.job;
				ctrl.createPage();
				ctrl.createPaypal();
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
