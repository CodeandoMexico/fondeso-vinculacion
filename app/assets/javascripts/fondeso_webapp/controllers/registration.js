'use strict';

/**
 * @ngdoc function
 * @name questionaryApp.controller:RegistrationCtrl
 * @description
 * # RegistrationCtrl
 * Controller of the questionaryApp
 */
angular.module('questionaryApp')
  .controller('RegistrationCtrl', ['$scope', '$location', 'FondesoUser', function ($scope, $location, FondesoUser) {
    var self = this;
    // there is already a logged in user
    if( angular.isObject(FondesoUser.current) ) $location.url('/intro');

    self.newUser = {
      name: null,
      email: null,
      password: null,
      passwordConfirmation: null
    };

    $scope.errors = {
      submitted: false,
      message: null,
      show: function() {
        this.submitted = true;
      },
      hide: function() {
        this.submitted = false;
      }
    };

    $scope.$watch('errors.message', function(newValue, oldValue){
      if ( newValue === oldValue ) return ;
      if ( newValue !== null ) {
        $scope.errors.show();
      } else {
        $scope.errors.hide();
      }
    });

    self.createAccount = function( resource, valid ){
      if ( valid ) return createUser( resource );
      $scope.errors.show();
    };

    // private methods
    var createUser = function( resource ){
      FondesoUser.create( resource ).
      success(function(data, status, headers, config){
        $scope.errors.message = null;
        $location.url('/intro/')
      }).
      error(function(data, status, headers, config){
        switch (status) {
        case 422:
          $scope.errors.message = 'Este correo ya ha sido tomado';
          break;
        default:
          $scope.errors.message = 'Hubo un error al procesar al usuario';
        }
      });
    };
  }]);
