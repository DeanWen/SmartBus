<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="databean.Routes" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
			<ul data-role="listview" data-inset="true">
 				<c:forEach var="e" items="${esti}">
					<li>${e.getRoute()} ${e.getTime()} </li>
				</c:forEach>
			</ul>
		</div>
		

		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="" data-icon="arrow-r">From Here</a></li>
					<li><a href="BusTransit.do" data-icon="navigation">Navigation</a></li>
					<li><a href="" data-icon="location">Near Me</a></li>
					<li><a href="" data-icon="star"> Favorite</a></li>
				</ul>
			</div>
		</div>
	</div>

</body>
</html>