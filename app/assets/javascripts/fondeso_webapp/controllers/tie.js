'use strict';

/**
 * @ngdoc function
 * @name questionaryApp.controller:TieCtrl
 * @description
 * # TieCtrl
 * Controller of the questionaryApp
 */
angular.module('questionaryApp')
  .controller('TieCtrl', [
    'FondesoTie',
    'Questionary',
    'FondesoDelegation',
    'FondesoPriority',
    'FondesoFilter',
    '$location',
    '$route',
    '$scope',
    function (FondesoTie, Questionary, FondesoDelegation, FondesoPriority, FondesoFilter, $location, $route, $scope) {
      if(FondesoTie.numberOfTiedProfiles() <= 1) return $location.url( '/404' );

      this.sections = FondesoTie.tieSections;
      this.walkedPath = FondesoTie.walkedPath;
      $scope.walkedPath = FondesoTie.walkedPath;

      this.section = FondesoTie.getTieActiveSection();
      this.sectionTitle = this.section.identifier;
      this.question = this.section.questions[0];

      this.showResults = function(){
        // check delegations, priorities and filters
        FondesoDelegation.getDelegations(Questionary.sections, Questionary.walkedPath);
        FondesoPriority.getPriorities(Questionary.sections, Questionary.walkedPath);
        FondesoFilter.checkAllFilters(Questionary.sections, Questionary.walkedPath);

        // submit the data to the service and see if it was successful
        Questionary.submit(this.walkedPath, FondesoFilter.filters, FondesoPriority.priorities, FondesoDelegation.delegations, FondesoTie.profiles, FondesoTie.walkedPath).then(function(res){
          console.log(res);
          var profile = res.data.profile;

          // update all inputs variables
          document.getElementById("answers").value            = angular.toJson( $scope.walkedPath );
          document.getElementById("filters").value            = angular.toJson( FondesoFilter.filters );
          document.getElementById("priorities").value         = angular.toJson( FondesoPriority.priorities );
          document.getElementById("delegations").value        = angular.toJson( FondesoDelegation.delegations );
          document.getElementById("category_name").value      = angular.toJson( profile );
          document.getElementById("authenticity_token").value = angular.element("meta[name='csrf-token']").attr("content");


          // redirect to the results when they come, it should return the category name
          if ( angular.isArray(profile) ){
            FondesoTie.setProfiles( profile );
            $route.reload( resolveTie(profile) );
          }
          else {
            // $location.url( redirectToProfile(profile.uri) );
            document.getElementById("answerForm").submit();
          }
        }, function (err) {
          // there was an error so let's do something about it
          console.log('There was an error' + err);
        });
      };

      // private

      function redirectToProfile(uri) {
        return '/profile/' + uri;
      }

      function resolveTie(profiles) {
        FondesoTie.setProfiles(profiles);
        return '/empate/';
      }
  }]);
