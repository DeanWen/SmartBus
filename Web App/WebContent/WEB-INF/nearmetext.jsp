<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="databean.Routes" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>
	<div data-role = "page">
		<div data-role="header">
			<h1>Smart Bus</h1>
			<div class="ui-btn-right">
			<select name="flip-1" id="flip-1" data-role="slider" >
				<option value="Text">Text</option>
				<option value="Map">Map</option>
			</select> 
			</div>
		</div>
		
		<div data-role="content">			
			<ul data-role="listview" data-inset="true">
				<c:forEach var="bus" items="${BusStops}">
					<li ><a href= "predication.do?stopid=${bus.stopId}">${bus.getStopName()}</a></li>
				</c:forEach>
			</ul>
			
	        <div class="ui-block-a" align="center">
	           <a href="http://pittsburgh.pirates.mlb.com/">
	               <img style="width:100%;height:auto;" src="https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQhFIEPEOG-3As_yj8HjRGPNqbJo9NUldfp7bJsB9sTHe3Scx3w" />
	           </a>
	        </div>
		</div>
		

			<div data-role="footer" data-position="fixed">
				<div data-role="navbar">
					<ul>
						<li><a href="fromHere.do" data-icon="arrow-r" >From Here</a></li>
						<li><a href="BusTransit.do" data-icon="navigation" >Navigation</a></li>
						<li><a href="nearme.do" data-icon="location" class="ui-btn-active ui-state-persist">Near Me</a></li>
					</ul>
				</div>
			</div>
        </div> 
    </body>
</html>