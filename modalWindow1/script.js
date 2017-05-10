$(function(){

  $('#background').hide();
  $('#click').click(function(){
    $('#background').fadeIn(300);
  });

  $("#back").click(function(){
    $('#background').fadeOut(200);
  });
});
