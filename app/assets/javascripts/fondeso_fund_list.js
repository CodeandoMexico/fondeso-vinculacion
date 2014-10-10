//= require jquery
//= require jquery_ujs

// Angular app dependencies
//= require bower_components/angular/angular.js

'use strict';

angular.module('fundList', [])
  .controller('FundCtrl', ['$scope', '$window', function ($scope, $window) {
    $scope.funds = [];
    $scope.fundSelected = [];
    $scope.menuIsOpen = false;
    console.log('initialized fund list');

    var div = angular.element('.fund-data');
    angular.forEach( div, function(fund){
      $scope.funds.push( angular.element( fund ).data().fund );
      $scope.fundSelected.push( true );
    });
    console.log( $scope.funds );

    // helpers
    $scope.clickOnFund = function (index) {
      $scope.fundSelected[index] = !$scope.fundSelected[index];
    };

    $scope.printFunds = function() {
      console.log( 'print');
      $window.print();
    }
  }]);
