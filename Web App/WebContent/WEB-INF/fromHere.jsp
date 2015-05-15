<!DOCTYPE html> 
<html>
<head>
    <style type="text/css">
        #map_canvas {
            height: 256px;
            width: 384px;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
</head>

    <script type="text/javascript">      
    function initialize() {
    	var myLatlng = new google.maps.LatLng(40.4433, -79.9436);
        var myOptions = {
            center: new google.maps.LatLng(40.4433, -79.9436),           
            zoom: 15,          
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };         
        var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: 'Hello World!'
        });
    }
 	</script>
 
<body onload="initialize()"> 

    <div data-role="page">
        <div data-role="header">
			<h1>Smart Bus</h1>
		</div>
        <div data-role="content">
            <div id="map_canvas" style = "width:100%"></div>
            <ul data-role="listview" data-inset="true">
				<li>Favorite <a href="BusTransit.do?fav=waterfront">Waterfront</a></li>
			</ul>
        </div>

<jsp:include page="bottom.jsp" />