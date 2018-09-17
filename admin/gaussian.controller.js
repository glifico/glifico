angular.module('admin', [])
.controller('AdminCtrl', function AdminCtrl() {
  var ctrl=this;

  var classes=[
    {
      "size": 10,
      "margin": 50,
      "fix": 0
    },
    {
      "size": 60,
      "margin": 20,
      "fix": 0
    },
    {
      "size": 30,
      "margin": 50,
      "fix": 10
    }
  ]

  ctrl.$onInit=function(){
    ctrl.data=classes;
    ctrl.checkStyle="";
  }
  
});



angular.module('admin').component('gaussiancomponent', {
  templateUrl: 'app/glificoGaussian.template.html',
  bindings: {
    hero: '='
  }
});
