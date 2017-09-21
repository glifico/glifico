$(document).ready(function () {
	$('#payCompleted').hide();
	
	if(!getLogged()){
		$("#styledbody").hide();
		
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
		sandbox:    'AZDxjDScFpQtjWTOUtWKbyN_bDt4OgqaF4eYXlewfBP4-8aqX3PiV8e1GWU6liB2CUXlkA59kJXE7M6R',
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




