'use strict';

angular
  .module('questionaryApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'questionModule',
    'templates'
  ])
  .config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/questionary/', {
        templateUrl: 'main.html',
        controller: 'MainCtrl'
      })
      .when('/tie/', {
        templateUrl: 'ties.html',
        controller: 'TieCtrl',
        controllerAs: 'tie'
      })
      .otherwise({
        redirectTo: '/questionary/'
      });

     $locationProvider.html5Mode(true);
  }]);
