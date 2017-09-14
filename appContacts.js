// app.js

(function() {

    'use strict';

    var app = angular.module('contactsApp', ['formly', 'ngMessages', 'formlyMaterial','ui.select','ngSanitize','ngAria','ngAnimate','ngMaterial','textAngular']);
    app.run(function(formlyConfig) {
        // NOTE: This next line is highly recommended. Otherwise Chrome's autocomplete will appear over your options!
        formlyConfig.extras.removeChromeAutoComplete = true;
        
        // Configure custom types
        formlyConfig.setType({
          name: 'ui-select-single',
          'extends': 'select',
          templateUrl: 'ui-select-single.html'
        });
        formlyConfig.setType({
            name: 'ui-select-multiple',
            'extends': 'select',
            templateUrl: 'ui-select-multiple.html'
        });
        formlyConfig.setType({
            name: 'ui-tagging',
            'extends': 'select',
            templateUrl: 'ui-tagging.html'
          });
        formlyConfig.setType({
            name: 'ui-tagging-single',
            'extends': 'select',
            templateUrl: 'ui-tagging-single.html'
          });
//        formlyConfig.setType({
//            name: 'input',
//            overwriteOk: true,
//            template: '<input ng-model="model[options.key]">'
//          });
//          
//          formlyConfig.setType({
//            name: 'checkbox',
//            overwriteOk: true,
//            template: '<md-checkbox ng-model="model[options.key]">{{to.label}}</md-checkbox>'
//          });
//          
//          formlyConfig.setWrapper({
//            name: 'mdLabel',
//            types: ['input'],
//            template: '<label>{{to.label}}</label><formly-transclude></formly-transclude>'
//          });
//          
//          formlyConfig.setWrapper({
//            name: 'mdInputContainer',
//            types: ['input'],
//            template: '<md-input-container><formly-transclude></formly-transclude></md-input-container>'
//          });
          
          formlyConfig.setType({
        	  name: 'richEditor',
        	  template: '<text-angular ng-model="model[options.key]" ta-disabled="{{to.disabled}}"></text-angular>'
          });
      });
    
    
    
})();