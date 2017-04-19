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
              zoom: 16,
              center: results[0].geometry.location, // 指定の住所から計算した緯度経度を指定する
              mapTypeId: google.maps.MapTypeId.ROADMAP // 「地図」で GoogleMap を出力する
          };
          restaurant = results[0].geometry.location;
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
      getTime();
      ShowRoute();
      }, function() {
          alert('位置情報取得に失敗しました');
      });


  }

  function getTime() {
    google.maps.geometry.spherical.computeDistanceBetween (latLng, restaurant);
     navigator.geolocation.getCurrentPosition(function(position) {
       var currentLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
     });
    var distanceMatrixService = new google.maps.DistanceMatrixService();

    // 出発点
    var origns = [ restaurant ];
    // 到着点
    var destinations = [ latLng ];

    // DistanceMatrix の実行
    distanceMatrixService.getDistanceMatrix({
      origins: origns, // 出発地点
      destinations: destinations, // 到着地点
      travelMode: google.maps.TravelMode.DRIVING, // 車モード or 徒歩モード
      drivingOptions: { // 車モードの時のみ有効
        departureTime: new Date('2017/5/5 10:00:00'), // 2017年5月5日
        trafficModel: google.maps.TrafficModel.BEST_GUESS // 最適な検索
      }
    }, function(response, status) {
      if (status == google.maps.DistanceMatrixStatus.OK) {

        // 出発地点と到着地点の住所（配列）を取得
        var origins = response.originAddresses;
        var destinations = response.destinationAddresses;

        // 出発地点でループ
        for (var i=0; i<origins.length; i++) {
          // 出発地点から到着地点への計算結果を取得
          var results = response.rows[i].elements;

          // 到着地点でループ
          for (var j = 0; j<results.length; j++) {
            var from = origins[i]; // 出発地点の住所
            var to = destinations[j]; // 到着地点の住所
            var duration = results[j].duration_in_traffic.text; // 時間
            var timer = parseInt(duration);
            countdown(timer);
          }
        }
      }
    });
  }

  function ShowRoute() {
    var directionsDisplay = new google.maps.DirectionsRenderer({
        map: gmap, // 対象のGoogleMapsを指定
        suppressMarkers: true
    });
    var directionsService = new google.maps.DirectionsService();
    var request = {
        origin: restaurant, // スタート地点：富士山
        destination: latLng, // ゴール地点：東京
        travelMode: google.maps.TravelMode.DRIVING // 移動手段：徒歩
    };
    directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
    });
  }

  function countdown(minutes) {
      var seconds = 60;
      var mins = minutes
      function tick() {
          var counter = document.getElementById("timer");
          var current_minutes = mins-1
          seconds--;
          counter.innerHTML =
          current_minutes.toString() + ":" + (seconds < 10 ? "0" : "") + String(seconds);
          if( seconds > 0 ) {
              timeoutHandle=setTimeout(tick, 1000);
          } else {

              if(mins > 1){

                 // countdown(mins-1);   never reach “00″ issue solved:Contributed by Victor Streithorst
                 setTimeout(function () { countdown(mins - 1); }, 1000);

              }
          }
      }
      tick();
  }
});
