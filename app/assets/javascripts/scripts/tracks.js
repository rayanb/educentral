var Tracks = angular.module('tracksApp', ['ui.router'])

Tracks.config(function($httpProvider, $stateProvider, $urlRouterProvider) {
  token = $("meta[name=\"csrf-token\"]").attr("content");
  $httpProvider.defaults.headers.common['X-CSRF-TOKEN'] = token;

  $urlRouterProvider.otherwise('/home');

  $stateProvider
  .state('home'. {
    url: '/home'
  })
});

