<!DOCTYPE html> 
<html>
    <head>
        <title>jQuery Mobile Examples</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        	
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
		<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
	
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
		
		<style>
		    .fit-content, .bottom-footer {
			    position : absolute;
			}
		
		    .fit-content {
			    top : 44px;
			    bottom : 44px;
				left : 0;
				right : 0;
			}

			.fit-content > div {
				height : 100%;
			}
			
			.bottom-footer {
			    bottom : 0;
				width : 100%;
			}
			
			.yellow-bg {
			    background-color: yellow;
			}
		</style>
		
		<script type="text/javascript">
		    $(function(){
				$("#google-maps-example").one('pageshow',function(){
					var map = new google.maps.Map($("#map-container").get(0), {
						zoom: 15,
						center: new google.maps.LatLng(40.4433, -79.9436),
						mapTypeId: google.maps.MapTypeId.ROADMAP
					});

					$(this).on('pageshow',function(){
						google.maps.event.trigger(map, 'resize');
					});
				});
			});
		</script>
        
    </head>
    <body>
        <div data-role="page" id="google-maps-example">
            <div data-role="header">
                <h1>SmartBus</h1>
            </div>

            <div data-role="content" class="fit-content">	
				<div id="map-container">  </div>
            </div>

			<div data-role="footer" data-position="fixed">
				<div data-role="navbar">
					<ul>
						<li><a href="fromHere.do" data-icon="arrow-r">From Here</a></li>
						<li><a href="BusTransit.do" data-icon="navigation">Navigation</a></li>
						<li><a href="nearme.do" data-icon="location">Near Me</a></li>
					</ul>
				</div>
			</div>
        </div> 
    </body>
</html>