$(function() {

  $('.cart__details').on('click',function() {
    $.ajax({
      type: 'GET',
      url: '/orders/cartList',
      dataType: 'json'
    })

    .done(function(data) {
      $.each(data, function(i, menu_info) {
        var name = menu_info.name
        var price = menu_info.price
        $('.modal-body').append(name);
        $('.modal-body').append(price);
      });
    })

    .fail(function() {
      alert('error');
    })

  });
});


