'use strict';

/**
 * @ngdoc service
 * @name questionaryApp.fondesoFilter
 * @description
 * # fondesoFilter
 * Service in the questionaryApp.
 */
angular.module('questionaryApp')
  .service('FondesoFilter', ['Questionary', function fondesoFilter(Questionary) {
    var forFilterAnswerShouldBe =  function (filter, givenAnswer){
      /**
        For the given answers this methods checks if a filter should be
        activated(true) or not(false).
       */
       if ( angular.isUndefined(givenAnswer) ) {
         filter = 'answer_is_undefined';
       }

      switch (filter) {
        // list of filters
        case 'sex_is_women':
          return angular.equals(givenAnswer, 'b');
        case 'business_is_rural_sector':
          return angular.equals(givenAnswer, 'g');
        case 'younger_than_30':
          return givenAnswer < 30;
        case 'older_or_equal_to_60':
          return givenAnswer >= 60;
        case 'artisans':
          return (
                    angular.equals(givenAnswer[0], 'a') ||
                    angular.equals(givenAnswer[0], 'b') ||
                    angular.equals(givenAnswer[0], 'c') ||
                    angular.equals(givenAnswer[0], 'd')
                 ) && (
                    angular.equals(givenAnswer[1], 'a') ||
                    angular.equals(givenAnswer[1], 'b') ||
                    angular.equals(givenAnswer[1], 'e') ||
                    angular.equals(givenAnswer[1], 'i') ||
                    angular.equals(givenAnswer[1], 'j')
                 );
        case 'convenience_store':
          return angular.equals(givenAnswer, 'b');
        case 'college':
          return givenAnswer[0] < 25 &&
                 (
                   angular.equals(givenAnswer[1], 'c') ||
                   angular.equals(givenAnswer[1], 'd')
                 );
        case 'export_entrepeneur':
          return angular.isNumber(givenAnswer);
        case 'export_business':
          return (
                   arrayContains(givenAnswer[0], 'b') ||
                   arrayContains(givenAnswer[0], 'c') ||
                   arrayContains(givenAnswer[0], 'd') ||
                   arrayContains(givenAnswer[0], 'e')
                 ) && angular.isNumber(givenAnswer[1]);
         case 'manufacture':
           return angular.equals(givenAnswer, 'a');
         case 'intellectual_property':
           return angular.equals(givenAnswer, 'a');
         case 'construction':
           return angular.equals(givenAnswer, 'd');
         case 'tourism':
           return angular.equals(givenAnswer, 'c') ||
                  angular.equals(givenAnswer, 'i');
         case 'access_to_it':
           return angular.isNumber(givenAnswer) ||
                  angular.equals(givenAnswer, 'h');
         case 'technology_business':
           return angular.equals(givenAnswer, 'h');
         case 'native':
           return angular.equals(givenAnswer, 'b');

        default:
          return false;
      }
    };

    var extractAnswerFromQuestion = function (question, optionValue){
      /**
        There are various type of questions: ordinal, select, radio, checkbox, numeric, etc.
        Each of this questions has a different way to access the answers so..

        This method depending on the question type will return the given answer.
       */
      switch (question.type) {
        case 'select':
          if ( angular.isUndefined(question.body.selected_value) ) return undefined;
          return question.body.selected_value.value;
        case 'radio':
          return question.body.selected_value;
        case 'checkbox':
          var answers = [];
          angular.forEach(question.body.options, function(opt){
            if( opt.checked === true ){
              this.push(opt.value);
            }
          }, answers);
          return answers;
        case 'prioritize':
          var priority = null;
          angular.forEach(question.body.options, function(opt){
            if( opt.value === optionValue ){
              priority = opt.priority;
            }
          });
          return priority;
        case 'number':
          return question.body.value;

        default:
          return undefined;
      }
    };

    var hasWalkedPath = function(pathId, walkedPath) {
      return Questionary.walkedPathHasSection(pathId, walkedPath);
    }

    var arrayContains = function(arr, value) {
      return arr.indexOf(value) !== -1;
    }

    /**
      -- Fetch Methods --

      This methods wraps the answers corresponding to a filter for later
      check it's values in an array.
     */

    var fetchSexAnswer = function(sections) {
      return sections['1.B'].questions[1].body.selected_value;
    };

    var fetchBusinessSectorAnswers = function(sector) {
      return extractAnswerFromQuestion(sector.questions[0]);
    };

    var fetchAgeAnswer = function(sections) {
      return extractAnswerFromQuestion(sections['1.B'].questions[0]);
    };

    var fetchEducationAnswer = function(sections) {
      return extractAnswerFromQuestion(sections['1.B'].questions[2]);
    };

    var fetchExportAnswer = function(sections) {
      return extractAnswerFromQuestion(sections['3.A.2'].questions[0]);
    };

    var fetchPriorityAnswers = function(sector, optionValue) {
      return extractAnswerFromQuestion(sector.questions[0], optionValue);
    };

    var fetchInnovationAnswers = function(sector) {
      return extractAnswerFromQuestion(sector.questions[0]);
    };

    var fetchNativeAnswer = function(sections) {
      return extractAnswerFromQuestion(sections['1.B'].questions[5]);
    };

    return {
      filters: {
        MUJ: false,
        RUR: false,
        JOV: false,
        TER: false,
        ART: false,
        TAB: false,
        BAC: false,
        EXP: false,
        MAN: false,
        PIN: false,
        CON: false,
        TUR: false,
        ATI: false,
        IND: false,
        TIC: false
      },

      // helpers
      checkForWomenFilter: function (sections, walkedPath) {
        var givenAnswer = fetchSexAnswer(sections);
        return forFilterAnswerShouldBe('sex_is_women', givenAnswer) &&
               hasWalkedPath('1.B', walkedPath);
      },

      checkForRuralFilter: function (sections, walkedPath) {
        var firstPathAnswers = fetchBusinessSectorAnswers(sections['2.A.3']);
        var secondPathAnswers = fetchBusinessSectorAnswers(sections['2.C.5']);
        return (
                 hasWalkedPath('2.A.3', walkedPath) &&
                 forFilterAnswerShouldBe('business_is_rural_sector', firstPathAnswers)
               ) || (
                 hasWalkedPath('2.C.5', walkedPath) &&
                 forFilterAnswerShouldBe('business_is_rural_sector', secondPathAnswers)
               );
      },

      checkForYoungFilter: function (sections, walkedPath) {
        var givenAnswer = fetchAgeAnswer(sections);
        return forFilterAnswerShouldBe('younger_than_30', givenAnswer) &&
               hasWalkedPath('1.B', walkedPath);
      },

      checkForElderlyFilter: function (sections, walkedPath) {
        var givenAnswer = fetchAgeAnswer(sections);
        return forFilterAnswerShouldBe('older_or_equal_to_60', givenAnswer) &&
               hasWalkedPath('1.B', walkedPath);
      },

      checkForArtisanFilter: function (sections, walkedPath) {
        var education = fetchEducationAnswer(sections);
        var firstPathAnswers = fetchBusinessSectorAnswers(sections['2.A.3']);
        var secondPathAnswers = fetchBusinessSectorAnswers(sections['2.C.5']);
        return (
                 hasWalkedPath('2.A.3', walkedPath) &&
                 forFilterAnswerShouldBe('artisans', [education, firstPathAnswers])
               ) || (
                 hasWalkedPath('2.C.5', walkedPath) &&
                 forFilterAnswerShouldBe('artisans', [education, secondPathAnswers])
               );
      },

      checkForConvenienceStoreFilter: function (sections, walkedPath) {
        var firstPathAnswers = fetchBusinessSectorAnswers(sections['2.A.3']);
        var secondPathAnswers = fetchBusinessSectorAnswers(sections['2.C.5']);
        return (
                 hasWalkedPath('2.A.3', walkedPath) &&
                 forFilterAnswerShouldBe('convenience_store', firstPathAnswers)
               ) || (
                 hasWalkedPath('2.C.5', walkedPath) &&
                 forFilterAnswerShouldBe('convenience_store', secondPathAnswers)
               );
      },

      checkForCollegeFilter: function (sections, walkedPath) {
        var age = fetchAgeAnswer(sections);
        var education = fetchEducationAnswer(sections);
        return forFilterAnswerShouldBe('college', [age, education]) &&
               hasWalkedPath('1.B', walkedPath);
      },

      checkForExportFilter: function (sections, walkedPath) {
        var exportAnswer = fetchExportAnswer(sections);
        var firstPathPriorities = fetchPriorityAnswers(sections['4.A'], 'g');
        var secondPathPriorities = fetchPriorityAnswers(sections['4.C'], 'f');
        return (
                 forFilterAnswerShouldBe('export_business', [exportAnswer, firstPathPriorities]) &&
                 hasWalkedPath('4.A', walkedPath)
               ) || (
                 forFilterAnswerShouldBe('export_entrepeneur', secondPathPriorities) &&
                 hasWalkedPath('4.C', walkedPath)
               );
      },

      checkForManufactureFilter: function (sections, walkedPath) {
        var firstPathAnswers = fetchBusinessSectorAnswers(sections['2.A.3']);
        var secondPathAnswers = fetchBusinessSectorAnswers(sections['2.C.5']);
        return (
                 hasWalkedPath('2.A.3', walkedPath) &&
                 forFilterAnswerShouldBe('manufacture', firstPathAnswers)
               ) || (
                 hasWalkedPath('2.C.5', walkedPath) &&
                 forFilterAnswerShouldBe('manufacture', secondPathAnswers)
               );
      },

      checkForIntellectualPropertyFilter: function (sections, walkedPath) {
        var firstPathAnswers = fetchInnovationAnswers(sections['2.A.6']);
        var secondPathAnswers = fetchInnovationAnswers(sections['2.C.6']);
        return (
                 hasWalkedPath('2.A.6', walkedPath) &&
                 forFilterAnswerShouldBe('intellectual_property', firstPathAnswers)
               ) || (
                 hasWalkedPath('2.C.6', walkedPath) &&
                 forFilterAnswerShouldBe('intellectual_property', secondPathAnswers)
               );
      },

      checkForConstructionFilter: function (sections, walkedPath) {
        var firstPathAnswers = fetchBusinessSectorAnswers(sections['2.A.3']);
        var secondPathAnswers = fetchBusinessSectorAnswers(sections['2.C.5']);
        return (
                 hasWalkedPath('2.A.3', walkedPath) &&
                 forFilterAnswerShouldBe('construction', firstPathAnswers)
               ) || (
                 hasWalkedPath('2.C.5', walkedPath) &&
                 forFilterAnswerShouldBe('construction', secondPathAnswers)
               );
      },

      checkForTourismFilter: function (sections, walkedPath) {
        var firstPathAnswers = fetchBusinessSectorAnswers(sections['2.A.3']);
        var secondPathAnswers = fetchBusinessSectorAnswers(sections['2.C.5']);
        return (
                 hasWalkedPath('2.A.3', walkedPath) &&
                 forFilterAnswerShouldBe('tourism', firstPathAnswers)
               ) || (
                 hasWalkedPath('2.C.5', walkedPath) &&
                 forFilterAnswerShouldBe('tourism', secondPathAnswers)
               );
      },

      checkForAccessToITFilter: function (sections, walkedPath) {
        var firstPathPriorities = fetchPriorityAnswers(sections['4.A'], 'h');
        var access_to_it = fetchBusinessSectorAnswers(sections['2.C.5']);
        return (
                 forFilterAnswerShouldBe('access_to_it', firstPathPriorities) &&
                 hasWalkedPath('4.A', walkedPath)
               ) || (
                 forFilterAnswerShouldBe('access_to_it', access_to_it) &&
                 hasWalkedPath('2.C.5', walkedPath)
               );
      },

      checkForNativeFilter: function (sections, walkedPath) {
        return hasWalkedPath('1.B', walkedPath) &&
               forFilterAnswerShouldBe('native', fetchNativeAnswer(sections));
      },

      checkForITFilter: function (sections, walkedPath) {
        var firstPathAnswers = fetchBusinessSectorAnswers(sections['2.A.3']);
        var secondPathAnswers = fetchBusinessSectorAnswers(sections['2.C.5']);
        return (
                 hasWalkedPath('2.A.3', walkedPath) &&
                 forFilterAnswerShouldBe('technology_business', firstPathAnswers)
               ) || (
                 hasWalkedPath('2.C.5', walkedPath) &&
                 forFilterAnswerShouldBe('technology_business', secondPathAnswers)
               );
      },

      checkAllFilters: function(sections, walkedPath) {
        this.filters.MUJ = this.checkForWomenFilter(sections, walkedPath);
        this.filters.RUR = this.checkForRuralFilter(sections, walkedPath);
        this.filters.JOV = this.checkForYoungFilter(sections, walkedPath);
        this.filters.TER = this.checkForElderlyFilter(sections, walkedPath);
        this.filters.ART = this.checkForArtisanFilter(sections, walkedPath);
        this.filters.TAB = this.checkForConvenienceStoreFilter(sections, walkedPath);
        this.filters.BAC = this.checkForCollegeFilter(sections, walkedPath);
        this.filters.EXP = this.checkForExportFilter(sections, walkedPath);
        this.filters.MAN = this.checkForManufactureFilter(sections, walkedPath);
        this.filters.PIN = this.checkForIntellectualPropertyFilter(sections, walkedPath);
        this.filters.CON = this.checkForConstructionFilter(sections, walkedPath);
        this.filters.TUR = this.checkForTourismFilter(sections, walkedPath);
        this.filters.ATI = this.checkForAccessToITFilter(sections, walkedPath);
        this.filters.IND = this.checkForNativeFilter(sections, walkedPath);
        this.filters.TIC = this.checkForITFilter(sections, walkedPath);

        console.log(this.filters);
      }
    };
  }]);
