'use strict';

angular.module('questionaryApp')
  .controller('MainCtrl', [
    '$rootScope',
    '$scope',
    '$location',
    'Questionary',
    'ProgressBar',
    'FondesoSpecialCase',
    'FondesoFilter',
    'FondesoProfile',
    'FondesoPriority',
    'FondesoDelegation',
    'FondesoTie',
    function ($rootScope, $scope, $location, Questionary, ProgressBar, FondesoSpecialCase, FondesoFilter, FondesoProfile, FondesoPriority, FondesoDelegation, FondesoTie) {

      $scope.showResults = function(){
        // check delegations, priorities and filters
        FondesoDelegation.getDelegations($scope.sections, $scope.walkedPath);
        FondesoPriority.getPriorities($scope.sections, $scope.walkedPath);
        FondesoFilter.checkAllFilters($scope.sections, $scope.walkedPath);


        // submit the data to the service and see if it was successful
        Questionary.submit($scope.walkedPath, FondesoFilter.filters, FondesoPriority.priorities, FondesoDelegation.delegations).then(function(res){
          console.log(res);
          var profile = res.data.profile;

          // update all inputs variables
          document.getElementById("answers").value            = angular.toJson( $scope.walkedPath );
          document.getElementById("filters").value            = angular.toJson( FondesoFilter.filters );
          document.getElementById("priorities").value         = angular.toJson( FondesoPriority.priorities );
          document.getElementById("delegations").value        = angular.toJson( FondesoDelegation.delegations );
          document.getElementById("category_name").value      = angular.toJson( profile );
          document.getElementById("authenticity_token").value = angular.element("meta[name='csrf-token']").attr("content");

          // var redirectToProfile = '/profile' + profile.uri;
          // redirect to the results when they come, it should return the category name
          console.log('profile: ');
          console.log(profile);
          if ( angular.isArray(profile) ){
            // console.log('believes it is a tie');
            FondesoTie.setProfiles( profile );
            $location.url( resolveTie(profile) );
          }
          else {
            // console.log( redirectToProfile(profile.uri) );
            document.getElementById("answerForm").submit();
            // $location.url( redirectToProfile(profile.uri) );
            // $location.url( profile.uri );
          }
        }, function (err) {
          // there was an error so let's do something about it
          console.log('There was an error' + err);
        });
      };

      // watcher for special cases
      $scope.$watch('walkedPath', function(newValue, oldValue){
        if (newValue === oldValue) { return ; }

        // check all filters
        FondesoFilter.checkAllFilters($scope.sections, newValue);

        // is it a necessity profile and is on the correct section?
        if( FondesoSpecialCase.checkForNecessityProfile($scope.sections, newValue) ){
          // we've got to redirect this to the necessity funds
          // $location.url( redirectToProfile('necesidad-startup') );
          document.getElementById("special_case").value = angular.toJson( { uri: 'necesidad-aunnoexiste'} );
          return $scope.showResults();
        }

        // is it a professional profile and is on the correct section?
        if( FondesoSpecialCase.checkForProfessionalProfile($scope.sections, newValue) ){
          // alert('Se detectó un perfil de profesionista');
          document.getElementById("special_case").value = angular.toJson( { uri: 'profesionista-aunnoexiste'} );
          return $scope.showResults();
        }

      }, true);

      $scope.$watch('currentSection', function() {
        updateProgressBar();
      }, true);

      // private

      function redirectToProfile(uri) {
        return '/profile/' + uri;
      }

      function resolveTie(profiles) {
        FondesoTie.setProfiles(profiles);
        return '/tie/';
      }

      function updateProgressBar() {
        var totalNumberOfSections = undefined;
        if ($scope.currentSection !== null && $scope.currentSection.identifier.indexOf('.B') === -1){
          totalNumberOfSections = $scope.currentSection.identifier.indexOf('.C') !== -1 ? 8 : 17;
        }
        else {
          totalNumberOfSections = 1;
        }

        var numberOfWalkedSections = $scope.walkedPath.length;
        ProgressBar.setProgress( numberOfWalkedSections, totalNumberOfSections );
      }

      function initializeQuestionary() {
        var previousQuestionary = angular.element( angular.element('#questionary-data') ).data().answers;
        // console.log('previous');
        // console.log( angular.fromJson(previousQuestionary) );
        // console.log(previousQuestionary);

        $scope.sections = Questionary.sections;
        $scope.walkedPath = Questionary.walkedPath;
        $scope.currentSection = null;
        $rootScope.progressBar = ProgressBar;
        $scope.saveProgress = Questionary.saveProgress;


        if ( angular.isObject(previousQuestionary) ) {
          $scope.walkedPath = previousQuestionary;
          $scope.currentSection = $scope.walkedPath.pop();
        }

        // console.log($scope.walkedPath);
        // console.log($scope.currentSection);


        // $scope.startQuestionary = false;
        // $scope.progressBar = 1;
      }

      initializeQuestionary();

    }
  ]);
