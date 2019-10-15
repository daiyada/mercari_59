$(document).on("turbolinks:load", function(){
  $("#image-list img").hover(function(){
    $("#image-top img").attr("src",$(this).attr("src"));
  });
});