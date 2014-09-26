'use strict';

angular
  .module('questionaryApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    // 'ngGrid',
    'questionModule',
    'templates'
  ])
  .run(['$rootScope', '$http', '$cookies', '$location', 'FondesoUser',  function($rootScope, $http, $cookies, $location, FondesoUser){
    console.log($location.url());
  }])
  .config(['$routeProvider', '$httpProvider', '$locationProvider', function ($routeProvider, $httpProvider, $locationProvider) {
    $routeProvider
      .when('/questionary/', {
        templateUrl: 'intro.html',
      })
      .when('/questionary/test/', {
        templateUrl: 'main.html',
        controller: 'MainCtrl'
      })
      .when('/profile/', {
        templateUrl: 'fund.html',
        controller: 'FundCtrl'
      })
      .when('/profile/:category/', {
        templateUrl: 'fund.html',
        controller: 'FundCtrl'
      })
      .when('/tie/', {
        templateUrl: 'ties.html',
        controller: 'TieCtrl',
        controllerAs: 'tie'
      })
      // .when('/404/', {
      //   templateUrl: '404.html'
      // })
      .otherwise({
        redirectTo: '/404'
      });

     $locationProvider.html5Mode(true);
  }]);
