'use strict';

/**
 * @ngdoc function
 * @name questionaryApp.controller:SessionCtrl
 * @description
 * # SessionCtrl
 * Controller of the questionaryApp
 */
angular.module('questionaryApp')
  .controller('SessionCtrl', ['$scope', '$location', 'FondesoUser', function ($scope, $location, FondesoUser) {
    this.user = {
      email: null,
      password: null
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


    this.logIn = function( resource, valid ){
        if ( valid ) return logUserIn( resource, this.error );
        $scope.errors.show();
    };

    // private methods
    var logUserIn = function( resource, err ){
      FondesoUser.userIsLoggedIn().
      success(function(data, status, headers, config){
        FondesoUser.logIn( resource ).
        success(function(data, status, headers, config){
            FondesoUser.current = data;
            if( FondesoUser.validateLogin( data ) ){
              $scope.errors.message = null;
              $location.url('/intro/');
            }
        }).
        error(function(data, status, headers, config){
          switch (status) {
          case 401:
            $scope.errors.message = 'Usuario y/o contraseña incorrecto(s)';
            break;
          default:
            $scope.errors.message = 'Hubo un error al procesar al usuario';
          }
        });
      });
    };
  }]);
