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

	<div data-role="page" id="triplist">
		<div data-role="header">
			<h1>Smart Bus</h1>
		</div>
		<div data-role="content">
			<h3>Text guides for  ${origin} to ${ destination }</h3>

			<ul data-role="listview">
			<%ArrayList<Routes> res=(ArrayList<Routes>)request.getAttribute("result"); 
			if(res.size()==0)
			{
			%>
                    <li>
                       <h1>No available buses right now</h1>
                    </li>
				
			<%}; %>
				<c:forEach var="route" items="${result}">
					<li >${route.getRouteName()}</li>
					<li><a href="showMap.do" data-ajax="false">
					<c:forEach var="oneBus" items="${route.getRoutes()}">
						<h2>${oneBus.getBusline()} : ${oneBus.getDepartTime()}- ${oneBus.getArrTime()}</h2>
							<p>Departure: <b>${oneBus.getOriStop()}</b></p>
							<p>Arrival: <b>${oneBus.getDestStop()}</b></p>
					</c:forEach>
							<p class="ui-li-aside">See the map</p>
							<p>Overall Time: ${route.getDuration()}</p>
					</a>
					</li>
				</c:forEach>
			</ul>
		</div>

			<div data-role="footer" data-position="fixed">
				<div data-role="navbar">
					<ul>
						<li><a href="fromHere.do" data-icon="arrow-r" >From Here</a></li>
						<li><a href="BusTransit.do" data-icon="navigation" class="ui-btn-active ui-state-persist" >Navigation</a></li>
						<li><a href="nearme.do" data-icon="location" >Near Me</a></li>
					</ul>
				</div>
			</div>
        </div> 
    </body>
</html>