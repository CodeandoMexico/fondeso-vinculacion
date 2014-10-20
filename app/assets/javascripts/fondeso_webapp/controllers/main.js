'use strict';

angular.module('questionaryApp')
  .controller('MainCtrl', [
    '$scope',
    '$location',
    'Questionary',
    'FondesoSpecialCase',
    'FondesoFilter',
    'FondesoProfile',
    'FondesoPriority',
    'FondesoDelegation',
    'FondesoTie',
    function ($scope, $location, Questionary, FondesoSpecialCase, FondesoFilter, FondesoProfile, FondesoPriority, FondesoDelegation, FondesoTie) {
      $scope.sections = Questionary.sections;
      $scope.walkedPath = Questionary.walkedPath;
      $scope.currentSection = null;
      $scope.startQuestionary = false;
      $scope.progressBar = 1;

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
        if($scope.currentSection !== null && $scope.currentSection.identifier.indexOf('.B') === -1){
          console.log($scope.currentSection.identifier);
          var totalNumberOfSections = $scope.currentSection.identifier.indexOf('.C') !== -1 ? 9 : 18;
        }
        else {
          var totalNumberOfSections = 1;
        }

        $scope.progressBar = new Array(totalNumberOfSections);
        $scope.classOptions = {
          'progress-1': $scope.walkedPath.length == 0,
          'progress-2': $scope.walkedPath.length == 1,
          'progress-3': $scope.walkedPath.length == 2,
          'progress-4': $scope.walkedPath.length == 3,
          'progress-5': $scope.walkedPath.length == 4,
          'progress-6': $scope.walkedPath.length == 5,
          'progress-7': $scope.walkedPath.length == 6,
          'progress-8': $scope.walkedPath.length == 7,
          'progress-9': $scope.walkedPath.length == 8,
          'progress-10': $scope.walkedPath.length == 9,
          'progress-11': $scope.walkedPath.length == 10,
          'progress-12': $scope.walkedPath.length == 11,
          'progress-13': $scope.walkedPath.length == 12,
          'progress-14': $scope.walkedPath.length == 13,
          'progress-15': $scope.walkedPath.length == 14,
          'progress-16': $scope.walkedPath.length == 15,
          'progress-17': $scope.walkedPath.length == 16,
          'progress-18': $scope.walkedPath.length == 17,
        };
      }
    }
  ]);
