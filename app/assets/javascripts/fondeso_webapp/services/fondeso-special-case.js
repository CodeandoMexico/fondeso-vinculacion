'use strict';

/**
 * @ngdoc service
 * @name questionaryApp.fondesoSpecialCase
 * @description
 * # fondesoSpecialCase
 * Service in the questionaryApp.
 */
angular.module('questionaryApp')
  .service('FondesoSpecialCase', ['Questionary', function fondesoSpecialCase(Questionary) {
    var forQuestionAnswerShouldBe =  function (question, givenAnswer){
      // let's see if the question is equal to this.
      switch (question) {

      // necessity profile questions
      case 'necessity_education':
        return angular.equals(givenAnswer, 'a') ||
               angular.equals(givenAnswer, 'b') ||
               angular.equals(givenAnswer, 'c') ||
               angular.equals(givenAnswer, 'd');
      case 'necessity_reason_to_build_this_project_and_principal_business_objective':
        return angular.equals(givenAnswer, [1,2]) || angular.equals(givenAnswer, [2,1]) || angular.equals(givenAnswer, [1,1]);
      case 'necessity_current_laboral_situation':
        return angular.equals(givenAnswer, 'a');
      case 'necessity_if_someone_offered_me_a_job':
        return angular.equals(givenAnswer, 'a');

      // professional profile questions
      case 'professional_education':
        return angular.equals(givenAnswer, 'e') ||
               angular.equals(givenAnswer, 'f');
      case 'professional_reason_to_build_this_project_and_principal_business_objective':
        return ( angular.equals(givenAnswer[0], 1) || angular.equals(givenAnswer[1], 1) ) && ( angular.equals(givenAnswer[2], 1) || angular.equals(givenAnswer[3], 1) );
      case 'professional_current_laboral_situation':
        return angular.equals(givenAnswer, 'a') || angular.equals(givenAnswer, 'b');
      case 'professional_if_someone_offered_me_a_job':
        return angular.equals(givenAnswer, 'a');

      default:
        return false;
      }
    };

    var fetchNecessityAnswers = function(sections) {
      var necessityAnswerContainer =  [
        sections['2.C.1'].questions[0].body.options[0].priority,
        sections['2.C.2'].questions[0].body.options[0].priority
      ];

      return [
        sections['1.B'].questions[2].body.selected_value.value,
        necessityAnswerContainer,
        sections['2.C.3'].questions[0].body.selected_value,
        sections['2.C.4'].questions[0].body.selected_value
      ];
    };

    var fetchProfessionalAnswers = function(sections) {
      var professionalAnswerContainer =  [
        sections['2.C.1'].questions[0].body.options[0].priority,
        sections['2.C.1'].questions[0].body.options[1].priority,
        sections['2.C.2'].questions[0].body.options[0].priority,
        sections['2.C.2'].questions[0].body.options[1].priority
      ];

      return [
        sections['1.B'].questions[2].body.selected_value.value,
        professionalAnswerContainer,
        sections['2.C.3'].questions[0].body.selected_value,
        sections['2.C.4'].questions[0].body.selected_value
      ];
    };


    return {
      // helpers
      checkForNecessityProfile: function (sections, walkedPath){
        var givenAnswers = fetchNecessityAnswers(sections);
        return forQuestionAnswerShouldBe('necessity_education', givenAnswers[0]) &&
               forQuestionAnswerShouldBe('necessity_reason_to_build_this_project_and_principal_business_objective', givenAnswers[1]) &&
               forQuestionAnswerShouldBe('necessity_current_laboral_situation', givenAnswers[2]) &&
               forQuestionAnswerShouldBe('necessity_if_someone_offered_me_a_job', givenAnswers[3]) &&
               Questionary.walkedPathHasSection('2.C.4', walkedPath);
      },

      checkForProfessionalProfile: function (sections, walkedPath){
        var givenAnswers = fetchProfessionalAnswers(sections);
        return forQuestionAnswerShouldBe('professional_education', givenAnswers[0]) &&
               forQuestionAnswerShouldBe('professional_reason_to_build_this_project_and_principal_business_objective', givenAnswers[1]) &&
               forQuestionAnswerShouldBe('professional_current_laboral_situation', givenAnswers[2]) &&
               forQuestionAnswerShouldBe('professional_if_someone_offered_me_a_job', givenAnswers[3]) &&
               Questionary.walkedPathHasSection('2.C.4', walkedPath);
      }
    };
  }]);
