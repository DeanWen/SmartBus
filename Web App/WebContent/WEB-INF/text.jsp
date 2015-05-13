<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="databean.Routes" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css">
<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script
src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js">
</script>
</head>
<body>

	<div data-role="page" id="triplist">
		<div data-role="header">
			<h1>Smart Bus</h1>
		</div>
		<div data-role="content">
			<h3>Text guides for  ${origin} to ${ destination }</h3>

			<ul data-role="listview" data-inset="true">
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
					<li><a href="#"> <c:forEach var="busline"
								items="${route.getRoutes()}">
								<h2>${busline.getBusline()}(${busline.getDuration()}) :
									${busline.getDepartTime()}- ${busline.getArrTime()}</h2>
								<p>
									Departure: <b>${busline.getOriStop()}</b>
								</p>
								<p>
									Arrival: <b>${busline.getOriStop()}</b>
								</p>

							</c:forEach>
							<p>Overall Time: ${route.getDuration()}</p>
					</a></li>
				</c:forEach>
			</ul>
		</div>

		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="" data-icon="search">Search</a></li>
					<li><a href="BusTransit.do" data-icon="home">Home</a></li>
					<li><a href="" data-icon="info">Account</a></li>
				</ul>
			</div>
		</div>
	</div>

</body>
</html>