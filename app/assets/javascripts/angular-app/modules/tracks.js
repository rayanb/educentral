var Tracks = angular.module('tracksApp', [])

Tracks.config(function($httpProvider) {
  token = $("meta[name=\"csrf-token\"]").attr("content");
  $httpProvider.defaults.headers.common['X-CSRF-TOKEN'] = token;
});

