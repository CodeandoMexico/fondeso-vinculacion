'use strict';

// angular.module('questionaryApp')
var app = angular.module('questionModule', ['ui.sortable']);
app.run(['$templateCache', function($templateCache){

  // directive's skeleton templates
  $templateCache.put('questionary.html', '<form name="questionaryForm" novalidate><div class="questionary-container"><div ng-transclude></div><div class="button__wrapper"><button class="button--back" ng-disabled="!navigation.hasPrevious" ng-click="moveToPreviousSection()"></button><button ng-disabled="questionaryForm.$invalid" class="button--forward" ng-click="moveToNextSection()">Siguiente</button></div></div></form>');
  $templateCache.put('section.html','<div class="section-container"><h2 ng-if="title">{{title}}</h2><p class="text-muted" ng-if="description">{{description}}</p><div class="questions-container" ng-transclude></div></div>');
  $templateCache.put('question.html', '<ng-form name="questionForm"><div class="question-container"><div class="question-header"><p>{{ title }}</p><p class="p--instructions">{{ description }}</p><div ng-include="\'errors.html\'"></div></div><div class="question-body" ng-include="template[type]"></div><div ng-transclude></div><pre ng-if="debug">{{ codeData | json}}</pre></div></ng-form>');

  // answer templates
  $templateCache.put('text-input.html','<input class="form-control" type="text" ng-model="body.value">');
  $templateCache.put('number-input.html','<div ng-class="{ \'has-error\': questionForm.question.$invalid }"><input name="question" class="question--input" ng-required="true" type="number" min="{{body.minimumValue}}" ng-model="body.value"></div>');
  $templateCache.put('radio-input.html','<div class="question--option" ng-repeat="opt in body.options"><input type="radio" id="radio--opt-{{ idx }}-{{ $index }}" name="radio--opt-{{ idx }}" value="{{opt.value}}" ng-model="body.selected_value"><label for="radio--opt-{{ idx }}-{{ $index }}">{{opt.label}}</label></div>');
  $templateCache.put('checkbox-input.html','<div class="question--checkbox" ng-repeat="opt in body.options"><input type="checkbox" id="checkbox--opt-{{ idx }}-{{ $index }}" name="checkbox--opt-{{ idx }}" ng-model="opt.checked"><label for="checkbox--opt-{{ idx }}-{{ $index }}">{{opt.label}}</label></div>');
  $templateCache.put('select-input.html','<div class="input--select"><select class="form-control select--control" ng-model="body.selected_value" ng-options="option.label for option in body.options"></select></div>');
  $templateCache.put('order-input.html','<ol ui-sortable ng-model="body.options" class="order-question"><li ng-repeat="opt in body.options">{{opt.label}}</li></ol>');
  $templateCache.put('prioritize-input.html','<div class="prioritization-container"><div class="question--priorities" ng-repeat="opt in body.options"><input type="number" min="1" max="3" class="form-control input-sm prioritize-number" ng-model="opt.priority" unique-priority="body.options"><label>{{opt.label}}</label></div></div>');

  // errors template
  $templateCache.put('errors.html', '<div class="error-container"><span class="text-error" ng-show="questionForm.$invalid">Por favor revisa tu respuesta.</span></div>');
}]);

app.directive('questionary', function(){
  return {
    templateUrl: 'questionary.html',
    restrict: 'EA',
    transclude: true,
    scope: {
      firstSection: '@',
      lastSection: '@',
      sections: '=',
      currentSection: '=',
      walkedPath: '=',
      onFinish: '&',
      onChange: '&'
    },
    controller: ['$scope', function($scope){
      // initialize variables
      if(angular.isDefined( $scope.firstSection )){
        $scope.currentSection = $scope.sections[$scope.firstSection];
        $scope.nextSection = $scope.sections[$scope.currentSection.next];
      }
      // $scope.walkedPath = [];
      $scope.navigation = {
        hasNext: false,
        hasPrevious: false
      };
      // $scope.previousSection = null;

      // create helpers
      function oneStepForward(){
        $scope.walkedPath.push($scope.currentSection); // let's save where we've been through
        $scope.currentSection = $scope.nextSection; // go to the next section
        $scope.nextSection = $scope.sections[$scope.currentSection.next]; // get the next section
        // $scope.onChange(); // execute custom code after
      }

      function oneStepBackward(){
        $scope.nextSection = $scope.currentSection;
        $scope.currentSection = $scope.walkedPath.pop();
        // $scope.onChange(); // execute custom code after
      }

      // console.log('current section');
      // console.log($scope.sections);
      // console.log($scope.currentSection);
      // console.log($scope.nextSection);
      $scope.moveToNextSection = function(){
        // if there's a next section we should go there
        if(angular.isObject($scope.nextSection)){
          console.log('moving one section ahead');
          // $scope.onChange();
          oneStepForward();
        }
        else{
          console.log('disappear next button');
          $scope.walkedPath.push($scope.currentSection); // let's save where we've been through
          console.log($scope.currentSection);
          $scope.onFinish();
        }
      };
      $scope.moveToPreviousSection = function(){
        // if there's a next section we should go there
        var numberOfWalkedSections = $scope.walkedPath.length;
        if(numberOfWalkedSections - 1 >= 0){
          console.log('moving one section backward');
          // $scope.onChange();
          oneStepBackward();
        }
        else{
          console.log('disappear previous button')
        }
      };
    }],
    link: function(scope){
      // helpers
      function changePath(newPath){
        scope.nextSection = scope.sections[newPath];
      }
      scope.$on('PATH_CHANGE', function(event, args){
        // console.log('PATH_CHANGE DETECTED');
        // we need to change the next section
        // scope.nextSection = scope.sections[args.new_path];
        changePath(args.new_path);
      });
      scope.$on('DEFAULT_PATH', function(event, args){
        // scope.nextSection = scope.sections[scope.currentSection.next];
        changePath(scope.currentSection.next);
      });
      scope.$watch('currentSection', function(newValue, oldValue){
        // console.log(scope.walkedPath.length);
        var numberOfWalkedSections = scope.walkedPath.length + 1;
        // console.log(numberOfWalkedSections);
        // console.log(scope.sections.length);
        // check if has a next and previous section
        // scope.navigation.hasNext = angular.isObject(scope.nextSection);
        scope.navigation.hasPrevious = (numberOfWalkedSections - 1 > 0) ? true : false;
        // console.log(scope.navigation.hasPrevious);
      }, true);
    }
  }
})

app.directive('section', function(){
  return {
    templateUrl: 'section.html',
    restrict: 'EA',
    transclude: true,
    scope: {
      title : '@',
      description: '@',
    }
  }
})

app.directive('question', ['$rootScope','$compile', function ($rootScope, $compile) {
  return {
    templateUrl: 'question.html',
    restrict: 'EA',
    controller: ['$scope', function($scope){
        $scope.codeData = {
          title: $scope.title,
          body: $scope.body
        }
        $scope.template = {
          text: 'text-input.html',
          number: 'number-input.html',
          radio: 'radio-input.html',
          checkbox: 'checkbox-input.html',
          select: 'select-input.html',
          order: 'order-input.html',
          prioritize: 'prioritize-input.html'
        }
    }],
    transclude: true,
    scope : {
      title : '=',
      description: '=',
      type      : '=',
      body      : '=',
      debug      : '=',
      idx       : '=',
    },
    link: function(scope, element, attrs){
      var selectWatcher = scope.$watch('type', function(newValue, oldValue){
        // console.log()
        // if(newValue === oldValue) return;
        // change the initial value to the object
        if(newValue == 'select' && (scope.body.selected_value === 'null' || angular.isUndefined(scope.body.selected_value))){
          scope.body.selected_value = scope.body.options[0];
          // console.log(scope.body.selected_value);
        }
      });
      var answerWatcher = scope.$watch('body.selected_value', function(newValue, oldValue){
        if(newValue === oldValue) return;
        var type = scope.type;
        if((type === 'select' || type === 'radio')){
          if(angular.isString(newValue.change_path) && attrs.nested === 'true'){
            console.log('new path' + newValue.change_path);
            $rootScope.$broadcast('PATH_CHANGE', {new_path: newValue.change_path});
          }
          else if(attrs.nested === 'true'){
            console.log('default path');
            $rootScope.$broadcast('DEFAULT_PATH', {});
          }
          return;
        }
      }, true);
    }
  };
}]);

// validation directives
app.directive('uniquePriority', function(){
  return {
    // restrict: 'A',
    require: 'ngModel',
    scope: {
      uniquePriority: '='
    },
    link: function(scope, element, attrs, ctrl){
      function checkForUniquePriorities(priorities){
          var unique = true;
          var present = false;
          var counter = 0;
          var blankCount = 0;
          var numberOfPriorities = priorities.length;
          // console.log(priorities);
          angular.forEach(priorities, function(value){
            if(value.priority != null && ctrl.$viewValue !== ''){
              // check for repeated numbers
              counter += (value.priority == ctrl.$viewValue) ? 1 : 0;
            } else if(value.priority === null){
              // how many blank priorities are there?
              blankCount += 1;
            }
          });
          // console.log('counter: ' + counter);
          // console.log('blanks: ' + blankCount);
          // console.log('#priorities: ' + numberOfPriorities);
          unique = (counter <= 1) ? true : false; //
          present = (blankCount < numberOfPriorities) ? true : false;
          ctrl.$setValidity('uniquePriority', unique);
          ctrl.$setValidity('required', present);
      }

      // console.log(scope.uniquePriority);
      var questionPriorities = scope.uniquePriority;
      // console.log(questionPriorities);
      ctrl.$parsers.unshift(function(value){
        // checkForUniquePriorities(questionPriorities);
        // console.log(valid);
        return ctrl.$viewValue;
      });

      scope.$watch('uniquePriority', function(newValue, oldValue){
        // on initializing we don't want this validation to occur
        // if(angular.equals(newValue, oldValue)) {
        //   ctrl.$setValidity('required', false);
        //   return;
        // };
        // console.log('type: ' + (typeof ctrl.$viewValue))
        // console.log('watch of: '+ ctrl.$viewValue);
        checkForUniquePriorities(newValue);
      }, true);
    }
  };
});
