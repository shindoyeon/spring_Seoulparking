<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Kakao 지도 시작하기</title>
</head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<body>
	<h2>MAP</h2>
	<p>
		<em>지도를 클릭해주세요!</em>
	</p>
	<p id="result"></p>
	<p id="click"></p>
	<div id="map" style="width: 500px; height: 400px;"></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=561a845178111e911d22f0a791f9d99a"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.5662952, 126.97794509999994), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(37.5662952, 126.97794509999994); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		

		// 마우스 드래그로 지도 이동이 완료되었을 때 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'dragend', function() {        
		    
		    // 지도 중심좌표를 얻어옵니다 
		    var latlng = {
				    _x: map.getCenter().getLat(),
				    _y: map.getCenter().getLng()
				};
			
		    var message = '변경된 지도 중심좌표는 ' + latlng._x + ' 이고, ';
		    message += '경도는 ' + latlng._y + ' 입니다';
		    
		    var resultDiv = document.getElementById('result');  
		    resultDiv.innerHTML = message;
		    
		    $.ajax({
		        url : "center",
		        type : "GET",
		        dataType: "json",
		        data: latlng,
		        success : function(data){
		        	 console.log(latlng._x, latlng._y);
			        	}
		        });
		    
		});
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		 var markers=[];
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			removeMarker();
			// 클릭한 위도, 경도 정보를 가져옵니다 
			var latlng = {
				    x: mouseEvent.latLng.getLat(),
				    y: mouseEvent.latLng.getLng()
				};
			
			var message = '클릭한 위치의 위도는 ' + latlng.x + ' 이고, ';
			message += '경도는 ' + latlng.y + ' 입니다';

			var resultDiv = document.getElementById('click');
			resultDiv.innerHTML = message;
			
			   $.ajax({
			        url : "radius",
			        type : "GET",
			        //dataType: "json",
			        data: latlng,
			        success : function(data){
			        	
				        	// 마커 이미지의 이미지 주소입니다
				        	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
				        	for (var i = 0; i < data.length; i++) {
				        		  var coords =new kakao.maps.LatLng(data[i].location[1],data[i].location[0]);
				        		 
				        		  console.log(data[i].location[1],data[i].location[0])
				        		  // 마커 이미지의 이미지 크기 입니다
				        		    var imageSize = new kakao.maps.Size(24, 35); 
				        		    
				        		    // 마커 이미지를 생성합니다    
				        		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
				        		   
				        		    // 마커를 생성합니다
				        		    var marker = new kakao.maps.Marker({
				        		        map: map, // 마커를 표시할 지도
				        		        position: coords, // 마커를 표시할 위치
				        		        image : markerImage // 마커 이미지 
				        		    });
				        		    markers.push(marker);
				
					        	}
				        	}
			        });
		});
		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		for (var i = 0; i < markers.length; i++)
				markers[i].setMap(null);
		markers = [];
		}
		/*
		  $(document).ready(function() {
			   $.ajax({
			        url : "all",
			        type : "POST",
			        dataType: "json",
			        success : function(data){
			        	// 마커 이미지의 이미지 주소입니다
			        	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			        	for (var i = 0; i < data.length; i++) {
			        		  var coords =new kakao.maps.LatLng(data[i].location[1],data[i].location[0]);
			        		 
			        		  console.log(data[i].location[1],data[i].location[0])
			        		  // 마커 이미지의 이미지 크기 입니다
			        		    var imageSize = new kakao.maps.Size(24, 35); 
			        		    
			        		    // 마커 이미지를 생성합니다    
			        		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			        		    
			        		    // 마커를 생성합니다
			        		    var marker = new kakao.maps.Marker({
			        		        map: map, // 마커를 표시할 지도
			        		        position: coords, // 마커를 표시할 위치
			        		        image : markerImage // 마커 이미지 
			        		    });
				        	}
			        	}
			        });
		  });  
		 */
	</script>
</body>
</html>