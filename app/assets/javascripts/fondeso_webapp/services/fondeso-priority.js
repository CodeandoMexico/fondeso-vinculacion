'use strict';

/**
 * @ngdoc service
 * @name questionaryApp.fondesoPriority
 * @description
 * # fondesoPriority
 * Service in the questionaryApp.
 */
angular.module('questionaryApp')
  .service('FondesoPriority', ['Questionary', function fondesoPriority(Questionary) {

    var fetchPriorities = function (section) {
      var priorities = [];
      angular.forEach(section.questions[0].body.options, function (opt) {
        if ( opt.priority === 1 || opt.priority === 2 || opt.priority === 3 ) {
          this.push(opt);
        }
      }, priorities);

      return priorities;
    }

    return {
      priorities: [],
      getPriorities: function (sections, walkedPath) {
        var section = null;
        this.priorities = [];

        if ( Questionary.walkedPathHasSection('4.A', walkedPath) ) {
          section = sections['4.A'];
          this.priorities = fetchPriorities(section);
        }
        else if ( Questionary.walkedPathHasSection('4.C', walkedPath) ){
          section = sections['4.C'];
          this.priorities = fetchPriorities(section);
        }

        console.log(this.priorities);
      }
    };
  }]);
