// index tracks page
Tracks.controller('tracksCtrl', ['$scope', '$http','$sce',function($scope, $http, $sce){
  $scope.tracks = [];
  $http.get('/tracks.json').then(function(response){
    response.data.map(function(track){
     var user = track.owner;
     var category = track.category;
     if(user){
      user = new User(user)
    }
    if(track.name){
     $scope.tracks.push(new Track(track, user, category))
   }
 })
  })

  $scope.sort='-popularity';

  $scope.updateSort = function(by){
    $scope.sort=by;
  }
}])
