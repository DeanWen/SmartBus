<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Show Routes On Google Map</title>
    <style>
      #map-canvas {
        margin: 0px;
        padding: 0px
      }
      #panel {
        margin-left: -180px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
      }
    </style>
    
    <style>
      #control {
        background: #fff;
        padding: 5px;
        font-size: 14px;
        font-family: Arial;
        border: 1px solid #ccc;
        box-shadow: 0 2px 2px rgba(33, 33, 33, 0.4);
        display: none;
      }

      @media print {
        #map-canvas {
          height: 500px;
          margin: 0;
        }

        #directions-panel {
          float: none;
          width: auto;
        }
      }
    </style>
    
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
    <script>
		var directionsDisplay;
		var directionsService = new google.maps.DirectionsService();
		var map;
	
		<%
			String curLat = (String)request.getAttribute("curLat");
			String curLng = (String)request.getAttribute("curLng");
			String destLat = (String)request.getAttribute("destLat");
			String destLng = (String)request.getAttribute("destLng");
		%>
		var curPosition = new google.maps.LatLng(<%=curLat %>,<%=curLng %>);
		var toPosition = new google.maps.LatLng(<%=destLat %>,<%=destLng %>);
		
		function initialize() {
  			directionsDisplay = new google.maps.DirectionsRenderer();
  			var mapOptions = {
    			zoom: 14,
    			center: curPosition
  			}
  			map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  			directionsDisplay.setMap(map);
  			directionsDisplay.setPanel(document.getElementById('directions-panel'));
  			calcRoute();
		}

		function calcRoute() {
  			//var selectedMode = document.getElementById('mode').value;
  			var request = {
      			origin: curPosition,
      			destination: toPosition,
      			// Note that Javascript allows us to access the constant
      			// using square brackets and a string value as its "property."
      			//travelMode: google.maps.TravelMode[selectedMode]
      			travelMode: google.maps.TravelMode["TRANSIT"]
  			};
  			directionsService.route(request, function(response, status) {
    			if (status == google.maps.DirectionsStatus.OK) {
      				directionsDisplay.setDirections(response);
    			}
  			});
		}

		google.maps.event.addDomListener(window, 'load', initialize);
    </script>
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
  </head>
  <body>
  	
    <div data-role="header">
    	<a href="BusTransit.do" data-rel="back" data-icon="back">Back</a>
		<h1>Smart Bus</h1>
	</div>
    <div id="map-canvas" style="position: absolute; width:100%; height:100%;"></div>

			<div data-role="footer" data-position="fixed">
				<div data-role="navbar">
					<ul>
						<li><a href="fromHere.do" data-icon="arrow-r" >From Here</a></li>
						<li><a href="BusTransit.do" data-icon="navigation" class="ui-btn-active ui-state-persist">Navigation</a></li>
						<li><a href="nearme.do" data-icon="location">Near Me</a></li>
					</ul>
				</div>
			</div>
        </div> 
    </body>
</html>