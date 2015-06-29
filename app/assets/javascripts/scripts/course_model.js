var Course = function(params, checked){
  this.id          = params.id;
  this.url         = params.url;
  this.photo_url   = params.photo_url;
  this.name        = params.name;
  this.users       = params.users;
  this.category_id = params.category_id;
  this.reviews     = params.reviews;
  this.platform    = params.platform;
  this.checked     = checked;
  this.dragged     = false;
}


Course.prototype.difficulty = function(){
  if(this.reviews.length > 0){
    var rev = this.reviews.map(function(r){return r.difficulty})
    var total =  _.reduce(rev, function(sum, el) {return sum + el}, 0)
    var averageDiff = (total/rev.length);
    return Array(Math.ceil(averageDiff)+1).join("<i class='fa fa-star star'></i>")
  }
  else{
    return "<i class='fa fa-star-half-o'></i> <span>(None)</span>"
  }
}

Course.prototype.rating = function(){
  if(this.reviews.length > 0){
    var rev = this.reviews.map(function(r){return r.rating})
    var total =  _.reduce(rev, function(sum, el) {return sum + el}, 0)
    var averageDiff = (total/rev.length);
    return Array(Math.ceil(averageDiff)+1).join("<i class='fa fa-rocket rocket'></i>  ")
  }
  else{
    return "<i class='fa fa-rocket'></i> <span>(None)</span>"
  }
}


