$(function() {

  $('.delete_mark').on("click", function(){
    var restaurant_id = this.id
    var target = '#delete_mark-' + restaurant_id;
    $(target).remove();

    $.ajax({
      type: 'POST',
      url: '/dislikes',
      data: {
        restaurant_id: restaurant_id
      },
      dataType: 'json'
    })
  });

  function setModal() {
    $('.modal-menu__list__col').remove();
    var modal = $( '<div class= "modal-menu__list__col col-md-4">'
              + '<div class= "modal-menu__list__title">'
              + '</div>'
              + '<div class= "modal-menu__list__detail">'
              + '</div>'
              + '<div class="modal-footer">'
              + '</div>'
              + '<div class= "modal-sender">'
              + '<input type="submit" name="commit" value="カートに追加" class="btn btn-success btn-lg btn-block" data-disable-with="カートに追加">'
              + '</div>'
              + '</div>');
    $('.modal-menu__list__row').prepend(modal);
  }

  function CateringModal() {
    $('.modal-menu__list__col').remove();
    var modal = $( '<div class= "modal-menu__list__col col-md-4">'
              + '<div class= "modal-menu__list__title">'
              + '</div>'
              + '<div class= "modal-menu__list__detail">'
              + '</div>'
              + '<div class="modal-footer">'
              + '</div>'
              + '<div class="field">'
              + '<label for="address">'
              + "配達先住所を指定"
              + '</label>'
              + '<br>'
              + '<input autofocus="autofocus" type="text" name= "address" id="address">'
              + '</div>'
              + '<label for="arrived_at">'
              + "配達希望日時を指定してください"
              + '</label>'
              + '<input type="datetime-local" name="arrived_at" value="2017-01-01T00:00" class="catering__time">'
              + '</input>'
              + '<div class= "modal-sender">'
              + '<input type="submit" name="commit" value="ケータリングを注文する" class="btn btn-success btn-lg btn-block" data-disable-with="ケータリングを注文する">'
              + '</div>'
              + '</div>');
    $('.modal-menu__list__cataring__row').prepend(modal);
  }


  function completeOrder(menu) {
    var name = menu.name;
    var detail = menu.detail;
    var menu_id = menu.id;
    var input = ('<input type = "hidden" name = menu_id value= ' + menu_id +'>');
    $('.modal-menu__list__title').append(name);
    $('.modal-menu__list__detail').append(detail);
    $('.modal-footer').append(input);
  }

  $('.menu__content').on('click',function(e) {
    e.preventDefault();
    var menu_info = $(this).data('menu_id');
    $('#menuModal').modal();
    $.ajax({
      type: 'GET',
      url: '/menus/search',
      data: {
        menu_id: menu_info
      },
      dataType: 'json'
    })

    .done(function(data) {
      var status =data.status
      if(status == 1){
        CateringModal();
      }else{
      setModal();
      }
      completeOrder(data);
    })

    .fail(function() {
      // alert('error');
    })

  });
});


