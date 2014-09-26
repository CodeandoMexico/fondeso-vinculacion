'use strict';

/**
 * @ngdoc service
 * @name questionaryApp.fondesoDelegation
 * @description
 * # fondesoDelegation
 * Service in the questionaryApp.
 */
angular.module('questionaryApp')
  .service('FondesoDelegation', ['Questionary', function fondesoDelegation(Questionary) {
    // -- Low level functions --
    var extractAnswerForDelegationIn = function(delegationQuestion) {
      console.log('delegation answer');
      console.log(delegationQuestion.body.selected_value.question.body.selected_value.label);
      return delegationQuestion.body.selected_value.question.body.selected_value.label;
    };

    var ubicatedInDF = function(delegationQuestion){
      // console.log("delegation");
      // console.log(delegationQuestion.body.selected_value.value);
      if( angular.equals( delegationQuestion.body.selected_value.value, 'b' ) ){
        return true;
      }
      return false;
    };

    // -- Mid level functions --
    var doesThePersonLiveInDF = function(homeDelegationQuestion){
      return ubicatedInDF(homeDelegationQuestion);
    };

    var doesTheBusinessIsEstablishedInDF = function(businessDelegationQuestion){
      return ubicatedInDF(businessDelegationQuestion);
    };

    // -- Main helper functions --
    var getHomeDelegation = function(section){
      var homeDelegationQuestion = section.questions[3];

      if ( doesThePersonLiveInDF( homeDelegationQuestion ) ){
        return extractAnswerForDelegationIn( homeDelegationQuestion );
      }
      return '';
    };

    var getBusinessDelegation = function(section){
      var businessDelegationQuestion = section.questions[4];

      if ( doesTheBusinessIsEstablishedInDF( businessDelegationQuestion ) ){
        return extractAnswerForDelegationIn( businessDelegationQuestion );
      }
      return '';
    };

    return {
      delegations: {
        home: '',
        business: ''
      },
      getDelegations: function(sections, walkedPath){
        this.delegations.home = getHomeDelegation(sections['1.B']);
        this.delegations.business = getBusinessDelegation(sections['1.B']);

        console.log(this.delegations);
      }
    };
  }]);
