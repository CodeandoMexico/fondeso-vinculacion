'use strict';

angular.module('questionaryApp')
  .controller('FundCtrl', ['$scope', '$routeParams', '$location', 'FondesoProfile', 'FondesoFilter', 'FondesoPriority', 'FondesoDelegation', function ($scope, $routeParams, $location, FondesoProfile, FondesoFilter, FondesoPriority, FondesoDelegation) {
    var category = $routeParams.category; // save value for later
    $scope.funds = null;

    // look if there is a category in the url, if not, return all the funds
    if(angular.isDefined(category)){
      FondesoProfile.category(category, FondesoFilter.filters, FondesoPriority.priorities, FondesoDelegation.delegations).then(function(res){
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
      $scope.fundSelected = $scope.funds[index];
    };

    // private
    var setFunds = function(funds) {
      $scope.funds = funds;
    };
  }]);
