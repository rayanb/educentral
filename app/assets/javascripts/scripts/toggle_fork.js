$(document).ready(function(){
  $('.show_fork').on('click', function(event){
    event.preventDefault();
    var $target = $(event.target);
    $target.next().toggle();
  })
})