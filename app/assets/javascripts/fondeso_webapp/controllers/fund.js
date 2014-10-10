'use strict';

// angular.module('questionaryApp')
angular.module('fundList', [])
  .controller('FundCtrl', ['$scope', '$routeParams', '$location', '$window', 'FondesoProfile', 'FondesoFilter', 'FondesoPriority', 'FondesoDelegation', 'Questionary', function ($scope, $routeParams, $location, $window, FondesoProfile, FondesoFilter, FondesoPriority, FondesoDelegation, Questionary) {
    var category = $routeParams.category; // save value for later
    $scope.funds = null;
    $scope.fundSelected = [];

    // look if there is a category in the url, if not, return all the funds
    if(angular.isDefined(category)){
      FondesoProfile.category(category, Questionary.walkedPath, FondesoFilter.filters, FondesoPriority.priorities, FondesoDelegation.delegations).then(function(res){
        setFunds(res.data);
      }, function(err){
        console.log(err);
        // there was an error we should redirect elsewhere
        $location.url('/404');
      });
    } else {
      FondesoProfile.all().then(function(res){
        setFunds(res.data);
      });
    }

    // helpers
    $scope.selectFund = function (index) {
      // $scope.fundSelected = $scope.funds[index];
      $scope.fundSelected[index] = !$scope.fundSelected[index];
    };

    $scope.printFunds = function(){
      $window.print();
    }

    // private
    var setFunds = function(funds) {
      $scope.funds = funds;
      angular.forEach(funds, function ( value ) {
        $scope.fundSelected.push( true );
      })
    };
  }]);
