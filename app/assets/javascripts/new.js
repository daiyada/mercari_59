$(document).on("turbolinks:load", function(){
  $("#iz_mouseover").on("mouseover",function(){
      $("#iz_mouseover").css({
          backgroundColor: "#ff5d57"
      });
      $(this).css("cursor","pointer");
  });

  $("#iz_mouseover").on("mouseout",function(){
      $("#iz_mouseover").css({
          backgroundColor: "#ea352d"
      });
  });

  $("#submit-card-info").on("mouseover",function(){
      $(this).css("cursor","pointer");
  });

});