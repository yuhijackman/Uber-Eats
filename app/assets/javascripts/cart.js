$(function() {
  function buildHTML(cart_detail) {
    var name = cart_detail.name;
    var price = cart_detail.price;
    var menu_id = cart_detail.id;
    var item = $( '<div class= "cart__list__content__left__col col-md-2">'
               + '</div>'
               + '<div class= "cart__list__content__center__col col-md-7">'
               + '<class = "modal-body">'
               + name
               + '</div>'
               + '</div>'
               + '<div class= "cart__list__content__right__col col-md-3">'
               + '<div class= "modal-price">'
               + "¥" + price
               + '</div>'
               + '</div>');
    $('.cart__list__content').append(item);
  }

  function showAlert() {
    var notification = $( '<div class= "empty__notice col-md-12">'
                       + "カートが空です。"
                       + '</div>');
    $('.cart__list__content').append(notification);
  }

  $('.cart__details').on('click',function() {
    $.ajax({
      type: 'GET',
      url: '/orders/cartList',
      dataType: 'json'
    })

    .done(function(data) {
      if(data == null){
        $('.cart__list__footer').remove();
        showAlert();
      }
      $.each(data, function(i, menu_info) {
        var cart_detail = menu_info
        buildHTML(cart_detail)
      });
    })

    .fail(function() {
      alert('error');
    })

  });
});
