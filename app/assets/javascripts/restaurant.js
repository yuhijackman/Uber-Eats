$(function() {
  function buildHTML(menu) {
    var name = menu.name;
    var detail = menu.detail;
    $('.modal-menu__list__title').append(name);
    $('.modal-menu__list__detail').append(detail);
  }

  $('.menu__content').on('click',function(e) {
    e.preventDefault();
    menu_info = $(this).data('menu_id');
    $('#menuModal').modal();
    console.log(menu_info)
    $.ajax({
      type: 'GET',
      url: '/menus/search',
      data: {
        menu_id: menu_info
      },
      dataType: 'json'
    })

    .done(function(data) {
      buildHTML(data);
    })

    .fail(function() {
      alert('error');
    })

  });
});


