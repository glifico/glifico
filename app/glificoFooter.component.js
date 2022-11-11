angular.module("glificoFooter",[])
.component("glificofooter",{
	controller: function(){
		var ctrl=this;
		ctrl.address="10100 Torino (TO)"
		ctrl.piva="03692530045";
	},
	templateUrl: "app/glificoFooter.template.html"
})
