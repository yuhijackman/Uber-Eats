$(function() {
  var path_name = location.pathname;
  $.ajax({
      type: 'GET',
      url: path_name,
      dataType: 'json'
    })

    .done(function(data) {
      var address = data.address;
      new google.maps.Geocoder().geocode({'address': address}, initMap);
        // Geocoder.geocode 関数に住所とコールバック関数を渡す
    })

    .fail(function() {
      // alert('error');
    })


  var map;
  var marker;
  markerData = [];
  function initMap(results, status) {
  var infoWindow;
      if(status == google.maps.GeocoderStatus.OK) {
          var options = {
              zoom: 18,
              center: results[0].geometry.location, // 指定の住所から計算した緯度経度を指定する
              mapTypeId: google.maps.MapTypeId.ROADMAP // 「地図」で GoogleMap を出力する
          };
          var restaurant = results[0].geometry.location;
          markerData.unshift(restaurant);
          var icon = new google.maps.MarkerImage('https://s3-ap-northeast-1.amazonaws.com/jawsome/uploads/restaurant/image/pin2.png',
            new google.maps.Size(50,60),
            new google.maps.Point(0,0),
            new google.maps.Point(19,51)
          );
          gmap = new google.maps.Map(document.getElementById('map-canvas'), options);
          restaurantMarker = new google.maps.Marker({
              position: restaurant,
              map: gmap,
              icon: icon
          });
      }
      infoWindow = new google.maps.InfoWindow({
         content: '<div class="restaurant-pin">Your fav restaurant is HERE!</div>'
      });
      restaurantMarker.addListener('click', function() {
        infoWindow.open(gmap, restaurantMarker);
      });
    currentLocation();
  }

  function currentLocation() {
      if (!navigator.geolocation) {
          alert('Geolocation APIに対応していません');
          return false;
      }
      navigator.geolocation.getCurrentPosition(function(position) {
          // 緯度経度の取得
          latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
          markerData.unshift(latLng);
          // マーカーの追加
          currentMarker = new google.maps.Marker({
              position: latLng,
              map: gmap
          });
      infoWindow = new google.maps.InfoWindow({
        content: '<div class="current-pin">You are HERE!</div>'
      });
      currentMarker.addListener('click', function() {
        infoWindow.open(gmap, currentMarker);
      });
      }, function() {
          alert('位置情報取得に失敗しました');
      });
    // placeMarker();
  }

  // function placeMarker() {
  //   debugger
  //   marker = []
  //   for (var i = 0; i < markerData.length; i++) {
  //       markerLatLng = new google.maps.LatLng({lat: markerData[i]['lat'], lng: markerData[i]['lng']});
  //       marker[i] = new google.maps.Marker({ // マーカーの追加
  //           position: markerLatLng, // マーカーを立てる位置を指定
  //           map: gmap // マーカーを立てる地図を指定
  //       });
  //   }
  // }

});


