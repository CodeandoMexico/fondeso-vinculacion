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
      .when('/cuestionario/', {
        templateUrl: 'main.html',
        controller: 'MainCtrl'
      })
      .when('/empate/', {
        templateUrl: 'ties.html',
        controller: 'TieCtrl',
        controllerAs: 'tie'
      })
      .otherwise({
        redirectTo: '/cuestionario/'
      });

     $locationProvider.html5Mode(true);
  }]);
