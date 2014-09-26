'use strict';

angular
  .module('questionaryApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    // 'ngGrid',
    'questionModule'
  ])
  .run(['$rootScope', '$http', '$cookies', '$location', 'FondesoUser',  function($rootScope, $http, $cookies, $location, FondesoUser){
    console.log($location.url());
  }])
  .config(['$routeProvider', '$httpProvider', '$locationProvider', function ($routeProvider, $httpProvider, $locationProvider) {
    // $routeProvider
    //   // .when('/usuario/login/', {
    //   .when('/', {
    //     // templateUrl: '..assets/fondesowebapp-templates/login.html',
    //     controller: 'SessionCtrl',
    //     controllerAs: 'session'
    //   })
    //   .when('/intro/', {
    //     templateUrl: '..assets/fondesowebapp-templates/intro.html',
    //   })
    //   .when('/usuario/crear/', {
    //     templateUrl: '..assets/fondesowebapp-templates/signup.html',
    //     controller: 'RegistrationCtrl',
    //     controllerAs: 'registration'
    //   })
    //   .when('/questionary/', {
    //     templateUrl: '..assets/fondesowebapp-templates/main.html',
    //     controller: 'MainCtrl'
    //   })
    //   .when('/profile/', {
    //     templateUrl: '..assets/fondesowebapp-templates/fund.html',
    //     controller: 'FundCtrl'
    //   })
    //   .when('/profile/:category/', {
    //     templateUrl: '..assets/fondesowebapp-templates/fund.html',
    //     controller: 'FundCtrl'
    //   })
    //   .when('/tie/', {
    //     templateUrl: '..assets/fondesowebapp-templates/ties.html',
    //     controller: 'TieCtrl',
    //     controllerAs: 'tie'
    //   })
    //   .when('/404/', {
    //     templateUrl: '404.html'
    //   })
    //   .otherwise({
    //     redirectTo: '/404'
    //   });

     $locationProvider.html5Mode(true);
  }]);
