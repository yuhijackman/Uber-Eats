$(function() {
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
      completeOrder(data);

    })

    .fail(function() {
      // alert('error');
    })

  });
});


