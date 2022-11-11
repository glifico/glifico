$(document).ready(function(){
		$.cookieBar({
		fixed: true,
		message:'We use cookies to track usage and preferences and to improve our website',
		effect: 'slide',
		policyButton: true,
		policyText: 'Click to see our full privacy policy',
		policyURL: 'privacy.html',
		acceptButton:
		true,
		acceptText: 'I Understand',
		zindex:9999,
		bottom: true
		});
})