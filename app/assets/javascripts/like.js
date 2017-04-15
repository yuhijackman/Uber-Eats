$(function() {

  $('#like-button').on("click", function(){
    like_function(gon.value, $(this), gon.like)
  });

  function like_function(id, button, like_id) {
    if (button.hasClass('like-img-red')){
        $.ajax({
          url: "/likes/" + like_id ,
          type: "delete",
          data: {
            restaurant_id: id
            },
          dataType: "json"
        })

        .done(function(data){
          $('#like-button').remove();
          var item = $('<div id= like-button>' + '<i class="fa fa-heart gray">' + '</i>' + " " + data.length + '</div>');
          $('.like_heart').append(item)
        })

      }else{
        $.ajax({
          url: "/likes",
          type: "post",
          data: {
            restaurant_id: id
            },
          dataType: "json"
        })

        .done(function(data){
          $('#like-button').remove();
          var item = $('<div id= like-button>' + '<i class="fa fa-heart red">' + '</i>' + " " + data.length + '</div>');
          $('.like_heart').append(item)
        })
      }
    }
  });
