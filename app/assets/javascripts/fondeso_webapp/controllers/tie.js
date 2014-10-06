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
    function (FondesoTie, Questionary, FondesoDelegation, FondesoPriority, FondesoFilter, $location, $route) {
      if(FondesoTie.numberOfTiedProfiles() <= 1) return $location.url( '/404' );

      this.sections = FondesoTie.tieSections;
      this.walkedPath = FondesoTie.walkedPath;

      this.section = FondesoTie.getTieActiveSection();
      this.sectionTitle = this.section.identifier;
      this.question = this.section.questions[0];

      this.showResults = function(){
        // check home and business delegations
        FondesoDelegation.getDelegations(Questionary.sections, Questionary.walkedPath);

        // check the priorities
        FondesoPriority.getPriorities(Questionary.sections, Questionary.walkedPath);

        // check all filters
        FondesoFilter.checkAllFilters(Questionary.sections, Questionary.walkedPath);

        // submit the data to the service and see if it was successful
        Questionary.submit(this.walkedPath, FondesoFilter.filters, FondesoPriority.priorities, FondesoDelegation.delegations, FondesoTie.profiles, FondesoTie.walkedPath).then(function(res){
          console.log(res);
          var profile = res.data.profile;

          // redirect to the results when they come, it should return the category name
          if ( angular.isArray(profile) ){
            FondesoTie.setProfiles( profile );
            $route.reload( resolveTie(profile) );
          }
          else {
            $location.url( redirectToProfile(profile.uri) );
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
        return '/tie/';
      }
  }]);
