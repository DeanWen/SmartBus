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
			<a href="nearme.do" data-rel="back" data-icon="back">Back</a>
			<h1>Smart Bus</h1>
		</div>
		<div data-role="content">
 				<c:forEach var="e" items="${esti}">
 				<ul data-role="listview" data-inset="true">
					<li>Route:	${e.getRoute()}</li>
					<li>Arrival:	${e.getRealTime()} </li>
					<li>Left:	${e.getLeft()} mins</li>
				</ul>
				</c:forEach>
			
		</div>
		

<jsp:include page="bottom.jsp" />