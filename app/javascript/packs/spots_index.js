// タグ検索イベント 

  document.addEventListener("DOMContentLoaded", function() {
    const toggleButton = document.getElementById('toggleSearchFormButton');
    const searchForm = document.getElementById('searchForm');
    
    toggleButton.addEventListener('click', function() {
      searchForm.classList.toggle('hidden');
    });
  });


//スポット一覧表示変更イベント 

    document.addEventListener('DOMContentLoaded', () => {
    const searchMapButton = document.querySelector('#searchMapButton');
    const listDisplayButton = document.querySelector('#listDisplayButton');
    const boardList = document.querySelector('#boardList');
    const googleMap = document.querySelector('#googleMap');

    // マップ検索ボタンクリックイベント
    searchMapButton.addEventListener('click', () => {
        listDisplayButton.classList.remove('hidden'); // リスト表示ボタンを表示
        searchMapButton.classList.add('hidden'); // マップ検索ボタンを非表示にする
        boardList.classList.add('hidden'); // 掲示板一覧を非表示にする
        googleMap.classList.remove('hidden'); // Google Mapを表示する
    });

    // リスト表示ボタンクリックイベント
    listDisplayButton.addEventListener('click', () => {
        searchMapButton.classList.remove('hidden'); // マップ検索ボタンを表示する
        listDisplayButton.classList.add('hidden'); // リスト表示ボタンを非表示にする
        boardList.classList.remove('hidden'); // 掲示板一覧を表示する
        googleMap.classList.add('hidden'); // Google Mapを非表示にする
    });
    });


// Google Map表示イベント
document.addEventListener('DOMContentLoaded', () => {
    let map;
    let userMarker; // ユーザーの現在地に立てるマーカー

    function initMap() {
        const mapElement = document.getElementById('map');
        const spots = JSON.parse(mapElement.dataset.spots);
        const initialPosition = { lat: 35.681, lng: 139.767 };

        map = new google.maps.Map(mapElement, {
            center: initialPosition,
            zoom: 15,
        });

        // 「現在地へ移動」ボタンをマップ上に追加
        const locationButton = document.createElement("button");
        locationButton.textContent = "現在地へ移動";
        locationButton.classList.add("bg-purple-500", "text-white", "hover:bg-purple-700", "font-bold", "py-2", "px-4", "rounded", "focus:outline-none", "focus:ring-2", "focus:ring-purple-600", "focus:ring-opacity-50", "transition", "duration-150", "ease-in-out","ml-3");
        map.controls[google.maps.ControlPosition.LEFT_TOP].push(locationButton);

        locationButton.addEventListener("click", () => {
            // ユーザーの現在地を取得
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition((position) => {
                    const userLocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };

                    // マップの中心を現在地に更新
                    map.setCenter(userLocation);

                    // 共通の色を変数に代入
                    const markerColor = '#800080';

                    // ユーザーの現在地にマーカーを立てる
                    if (userMarker) {
                        userMarker.setPosition(userLocation);
                    } else {
                        userMarker = new google.maps.Marker({
                            map: map,
                            position: userLocation,
                            icon: {
                                path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
                                fillColor: markerColor,
                                fillOpacity: 0.8,
                                scale: 8,
                                strokeColor: markerColor,
                                strokeWeight: 1.0
                            },
                            animation: google.maps.Animation.BOUNCE // ピンの上下アニメーションを追加
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
                    }

                    // 投稿された住所にマーカーを立てる
                    spots.forEach((spot) => {
                        const marker = new google.maps.Marker({
                            position: { lat: spot.latitude, lng: spot.longitude },
                            map: map,
                            animation: google.maps.Animation.DROP,
                        });
                    
                        // 吹き出しに表示する内容を設定
                        const contentString = `<div class="p-2">
                                                    <div class="font-bold text-lg">${spot.spot_name}</div>
                                                    <p class="text-sm">${spot.address}</p>
                                                    <a href="/spots/${spot.id}" target="_blank" style="color: blue; text-decoration: none;" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">詳細を見る</a>
                                               </div>`;
                    
                        // 吹き出しのインスタンスを作成
                        const infowindow = new google.maps.InfoWindow({
                            content: contentString
                        });
                    
                        // 地図上にマーカーを配置した際にデフォルトで吹き出しを表示
                        infowindow.open(map, marker);
                    });
                    
                }, () => {
                    handleLocationError(true, map.getCenter());
                });
            } else {
                handleLocationError(false, map.getCenter());
            }
        });
    }

    function handleLocationError(browserHasGeolocation, pos) {
        console.error(browserHasGeolocation ?
            "Error: Geolocation service failed." :
            "Error: Your browser doesn't support geolocation.");
    }

    window.initMap = initMap;
});

