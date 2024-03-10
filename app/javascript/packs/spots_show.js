function initMap() {
    // map要素とスポットの情報を取得
    const mapElement = document.getElementById('map');
    const latitude = parseFloat(mapElement.dataset.latitude);
    const longitude = parseFloat(mapElement.dataset.longitude);
  
    // スポットの位置情報を作成
    const spotLocation = { lat: latitude, lng: longitude };
  
    // Google Mapを初期化
    const map = new google.maps.Map(mapElement, {
      center: spotLocation,
      zoom: 15,
    });
  
    // 共通の色を変数に代入
    const markerColor = '#800080';

    // スポットの位置にカスタムピンを立てる
    const userMarker = new google.maps.Marker({
      position: spotLocation,
      map: map,
      icon: {
        path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
        fillColor: markerColor, // 変数で色を指定
        fillOpacity: 0.8,
        scale: 8,
        strokeColor: markerColor, // 変数で色を指定
        strokeWeight: 1.0,
      },
      animation: google.maps.Animation.BOUNCE // アニメーションをBOUNCEに設定
    });
  
    // 「現在地」と表示する吹き出しを追加
    const infowindow = new google.maps.InfoWindow({
      content: "<div style='color: #000;'>現在地</div>"
    });
  
    // マーカーをクリックした時に吹き出しを表示
    userMarker.addListener('click', function() {
      infowindow.open(map, userMarker);
    });
  
    // マップのロード時に自動で吹き出しを表示
    infowindow.open(map, userMarker);

    // Places APIを使用してテイクアウト可能な店を検索
    const service = new google.maps.places.PlacesService(map);
    const request = {
      location: spotLocation,
      radius: '1000', // 1km以内
      type: ['restaurant'], // レストランを検索
      keyword: 'テイクアウト', // テイクアウト可能な店をキーワードで検索
    };

    service.nearbySearch(request, (results, status) => {
      if (status === google.maps.places.PlacesServiceStatus.OK && results) {
        results.forEach((place) => {
          service.getDetails({placeId: place.place_id}, (placeDetail, statusDetail) => {
            if (statusDetail === google.maps.places.PlacesServiceStatus.OK) {
              const marker = new google.maps.Marker({
                position: placeDetail.geometry.location,
                map: map,
                title: placeDetail.name,
              });
    
              // ユーザーレビューがある場合、最初のレビューを表示
              const addressWithoutCountry = placeDetail.formatted_address.replace(/日本、/, '');
              const firstReview = placeDetail.reviews ? placeDetail.reviews[0].text : "レビューなし";
              const contentString = `
                <div>
                  <strong>${placeDetail.name}</strong><br>
                  <strong>${addressWithoutCountry}</strong><br>
                  <i>"${firstReview}"</i><br>
                  <a href="https://www.google.com/maps/place/?q=place_id:${placeDetail.place_id}" target="_blank" style="color: blue; text-decoration: none;" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">さらに詳細情報</a>
                </div>`;
    
              const infowindow = new google.maps.InfoWindow({
                content: contentString,
              });
    
              marker.addListener('click', () => {
                infowindow.open(map, marker);
              });
            }
          });
        });
      }
    });
}
  
  // Google Maps APIのコールバックとしてinitMapを指定
  window.initMap = initMap;