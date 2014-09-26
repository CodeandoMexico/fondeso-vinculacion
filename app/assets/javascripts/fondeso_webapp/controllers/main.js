'use strict';

angular.module('questionaryApp')
  .controller('MainCtrl', [
    '$scope',
    '$location',
    '$anchorScroll',
    'Questionary',
    'FondesoSpecialCase',
    'FondesoFilter',
    'FondesoProfile',
    'FondesoPriority',
    'FondesoDelegation',
    'FondesoTie',
    function ($scope, $location, $anchorScroll, Questionary, FondesoSpecialCase, FondesoFilter, FondesoProfile, FondesoPriority, FondesoDelegation, FondesoTie) {
      // types of questions are: text, number, radio, checkbox
      $scope.sections = Questionary.sections;
      $scope.walkedPath = Questionary.walkedPath;
      $scope.currentSection = null;

      $scope.showResults = function(){
        // check home and business delegations
        FondesoDelegation.getDelegations($scope.sections, $scope.walkedPath);

        // check the priorities
        FondesoPriority.getPriorities($scope.sections, $scope.walkedPath);

        // check all filters
        FondesoFilter.checkAllFilters($scope.sections, $scope.walkedPath);

        // submit the data to the service and see if it was successful
        Questionary.submit($scope.walkedPath, FondesoFilter.filters, FondesoPriority.priorities, FondesoDelegation.delegations).then(function(res){
          console.log(res);
          var profile = res.data.profile;
          // var filters = res.data.filters;
          // var priorities = res.data.priorities;
          // var delegations = res.data.delegations;

          // var redirectToProfile = '/profile' + profile.uri;
          // redirect to the results when they come, it should return the category name
          if ( angular.isArray(profile) ){
            FondesoTie.setProfiles( profile );
            $location.url( resolveTie(profile) );
          }
          else {
            $location.url( redirectToProfile(profile.uri) );
          }
        }, function (err) {
          // there was an error so let's do something about it
          console.log('There was an error' + err);
        });
      };

      $scope.onSectionChange = function(){
        $location.hash('top');
        $anchorScroll();
      };

      // watcher for special cases
      $scope.$watch('walkedPath', function(newValue, oldValue){
        if (newValue === oldValue) { return ; }

        // check all filters
        FondesoFilter.checkAllFilters($scope.sections, newValue);

        // is it a necessity profile and is on the correct section?
        if( FondesoSpecialCase.checkForNecessityProfile($scope.sections, newValue) ){
          // we've got to redirect this to the necessity funds
          $location.url( redirectToProfile('necesidad-startup') );
        }

        // is it a professional profile and is on the correct section?
        if( FondesoSpecialCase.checkForProfessionalProfile($scope.sections, newValue) ){
          alert('Se detectó un perfil de profesionista');
        }
      }, true);

      // private

      function redirectToProfile(uri) {
        return '/profile/' + uri;
      }

      function resolveTie(profiles) {
        FondesoTie.setProfiles(profiles);
        return '/tie/';
      }
    }
  ]);
