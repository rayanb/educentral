var User = function(params){
  this.username= params.name;
  this.id = params.id;
}

var Track = function(params, user, category){
  this.name = params.name;
  this.id = params.id;
  this.user = user;
  this.category = category;
  this.resume = params.description;
  this.popularity = params.popularity;
}
