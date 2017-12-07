angular.module('admin', [])
.controller('AdminCtrl', function AdminCtrl() {

});



angular.module('admin').component('gaussianComponent', {
  template: '<span>Name: {{$ctrl.hero.name}}</span>',
  bindings: {
    hero: '='
  }
});



/**
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
];

ctrl.$onInit=function(){
ctrl.data=classes;
ctrl.sizeOk=true;
ctrl.checkStyle="";
}

ctrl.formChange=function(){
console.log("form changed");
var sum=0;
for (var i=0; i<ctrl.data.length; i++) {
sum+=parseInt(ctrl.data[i]['size']);
}
ctrl.sizeOk = (sum==100);
if(sum!=100){
ctrl.checkStyle="background:red";
}else{
ctrl.checkStyle="";
}
}

},
**/
