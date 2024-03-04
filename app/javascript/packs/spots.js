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
    let map;
    let marker; // マーカーをグローバルスコープで定義

    function initMap() {
    // 初期位置を設定
    const initialPosition = { lat: 35.681, lng: 139.767 }; // 例としての初期位置

    // マップを表示
    map = new google.maps.Map(document.getElementById('map'), {
        center: initialPosition,
        zoom: 15
    });

    // 「現在地へ移動」ボタンをマップ上に追加
    const locationButton = document.createElement("button");
    locationButton.textContent = "現在地へ移動";
    locationButton.classList.add("bg-purple-500", "text-white", "hover:bg-purple-700", "font-bold", "py-2", "px-4", "rounded", "focus:outline-none", "focus:ring-2", "focus:ring-purple-600", "focus:ring-opacity-50", "transition", "duration-150", "ease-in-out","ml-3");
    map.controls[google.maps.ControlPosition.LEFT_TOP].push(locationButton);

    locationButton.addEventListener("click", () => {
        // ユーザーの現在地を取得
        if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
            const userLocation = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };

            // マップの中心を現在地に更新
            map.setCenter(userLocation);

            // マーカーがすでにある場合は位置を更新、なければ新しく作成
            if (marker) {
                marker.setPosition(userLocation);
            } else {
                marker = new google.maps.Marker({
                map: map,
                position: userLocation
                });
            }
            },
            () => {
            // エラーハンドリング
            handleLocationError(true, map.getCenter());
            }
        );
        } else {
        // ブラウザがGeolocationをサポートしていない場合
        handleLocationError(false, map.getCenter());
        }
    });
    }

    function handleLocationError(browserHasGeolocation, pos) {
    // エラー処理
    console.error(browserHasGeolocation ?
        "Error: Geolocation service failed." :
        "Error: Your browser doesn't support geolocation.");
    }

    window.initMap = initMap;
