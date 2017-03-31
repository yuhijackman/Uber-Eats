// $(function() {

//   $('#restaurants__search').on('keyup', function() {
//     $('.list').remove();
//     var preWord;
//     var input = $('#restaurants__search').val();
//     searchRestaurant(input)
//     // if ( input != preWord ) {
//     //   if(input.length !== 0) {
//     //     searchRestaurant(input);
//     //   }
//     // }
//   });

//   function searchRestaurant(input) {
//     $.ajax({
//       type: 'GET',
//       url: '/restaurants/search',
//       data: {
//         restaurant_name: input
//       },
//       dataType: 'json'
//     })

//     .done(function(data) {
//       $.each(data, function(name) {
//         var restaurant_info = name
//         var html = appendList(restaurants_info)
//         $('.users').append(html);
//       });

//     })
//     .fail(function() {
//       alert('error');
//     });
//   };
// });
