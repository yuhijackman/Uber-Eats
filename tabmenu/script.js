$(function() {
  var $tabMenu = $('.tab-menu').children();
  var $tabContent = $('.tab-content').children();

  var activeClass = 'active'

  $tabMenu.first().addClass(activeClass);
  $tabContent.not(':first').hide();

  $tabMenu.on('click', function () {
    var index = $(this).index();
    console.log(index);
    $tabMenu.removeClass(activeClass);
    $(this).addClass(activeClass);
    $tabContent.hide().eq(index).fadeIn();
  });
});

//childrenとは

//eqとは

//indexとは
