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
        
        
        var input = /** @type {HTMLInputElement} */ (
        	    document.getElementById('pac-input'));
        	  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
        	  
        	  var searchBox = new google.maps.places.SearchBox(
        			    /** @type {HTMLInputElement} */
        			    (input));
        	  
        	  google.maps.event.addListener(searchBox, 'places_changed', function() {
        		    var places = searchBox.getPlaces();

        		    for (var i = 0, marker; marker = markers[i]; i++) {
        		      marker.setMap(null);
        		    }

        		    // For each place, get the icon, place name, and location.
        		    markers = [];
        		    var bounds = new google.maps.LatLngBounds();
        		    var place = null;
        		    var viewport = null;
        		    for (var i = 0; place = places[i]; i++) {
        		      var image = {
        		        url: place.icon,
        		        size: new google.maps.Size(71, 71),
        		        origin: new google.maps.Point(0, 0),
        		        anchor: new google.maps.Point(17, 34),
        		        scaledSize: new google.maps.Size(25, 25)
        		      };

        		      // Create a marker for each place.
        		      var marker = new google.maps.Marker({
        		        map: map,
        		        icon: image,
        		        title: place.name,
        		        position: place.geometry.location
        		      });
        		      viewport = place.geometry.viewport;
        		      markers.push(marker);

        		      bounds.extend(place.geometry.location);
        		    }
        		    map.setCenter(bounds.getCenter());
        		  });
        	  
        	  google.maps.event.addListener(map, 'bounds_changed', function() {
        		    var bounds = map.getBounds();
        		    searchBox.setBounds(bounds);
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
            <input id="pac-input"></input>
            <ul data-role="listview" data-inset="true">
				<li><h3 align="center">Favorite</h3> <a href="BusTransit.do?fav=waterfront">Waterfront</a></li>
				<li><h3 align="center">History</h3> <a href="BusTransit.do?fav=Ross Park Mall">Ross Park Mall</a></li>
				<li> <a href="BusTransit.do?fav=Mt Washington">Mt Washington</a></li>
			</ul>
        </div>

			<div data-role="footer" data-position="fixed">
				<div data-role="navbar">
					<ul>
						<li><a href="fromHere.do" data-icon="arrow-r" class="ui-btn-active ui-state-persist">From Here</a></li>
						<li><a href="BusTransit.do" data-icon="navigation" >Navigation</a></li>
						<li><a href="nearme.do" data-icon="location">Near Me</a></li>
					</ul>
				</div>
			</div>
        </div> 
    </body>
</html>