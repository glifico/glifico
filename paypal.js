$(document).ready(function () {
	$('#payCompleted').hide();

	if(!getLogged()){
		$("#payDocumentBody").hide();

		alert("Please login");
	}
});


function getAmount(){
	return '1.50';
}

function paymentCompleted(){
	$('#payCompleted').show();
	$('#payment').hide();
}

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
						amount: { total: getAmount(), currency: 'EUR' }
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

			alert("good payment");

			paymentCompleted();

		});
	},

	onCancel: function(data, actions) {
        alert("Payment doesn't end well :-(");
    }


}, '#paypal-button');



angular.module("payment",[])
.controller("paymentController",function(){
	var ctrl=this;

	ctrl.job="Test translation";
	ctrl.translator="John Appleseed";
	ctrl.amount="10";
});



angular.element(document).ready(function() {
    console.log("registro payment");
    angular.bootstrap(document.getElementById('payment'), ['payment']);
});
