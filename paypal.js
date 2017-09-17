paypal.Button.render({

	env: 'sandbox', // Or 'production'

	client: {
		sandbox:    'AZDxjDScFpQtjWTOUtWKbyN_bDt4OgqaF4eYXlewfBP4-8aqX3PiV8e1GWU6liB2CUXlkA59kJXE7M6R',
		production: '<????>'
	},

	commit: true, // Show a 'Pay Now' button

	payment: function(data, actions) {
		return actions.payment.create({
			payment: {
				transactions: [
					{
						amount: { total: '1.00', currency: 'USD' }
					}
					]
			}
		});
	},

	onAuthorize: function(data, actions) {
		return actions.payment.execute().then(function(payment) {
			alert("good payament");
			// The payment is complete!
			// You can now show a confirmation message to the customer
		});
	}

}, '#paypal-button');
