var Tracks = angular.module('tracksApp', [])


// Headers for rails
Tracks.run(['$http', function($http) {
  $http.defaults.headers.common['Accept'] = 'application/json';
  $http.defaults.headers.common['Content-Type'] = 'application/json';
}]);
