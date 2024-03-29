<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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


	<div data-role="page" id="home">
		<div data-role="header">
			<h1>Smart Bus</h1>
		</div>


		<div data-role="content">

			<c:forEach var="error" items="${errors}">
				<h3 style="color: red">${error}</h3>
			</c:forEach>

			<form method="post" action="BusTransit.do">
				<div data-role="fieldcontain">
					<label for="origin">Origin</label> <input type="text" name="origin"
						id="ori"> <label for="destination">Destination</label> <input
						type="text" name="destination" id="dst"> 
				</div>
				<input type="submit" data-inline="false" name="action" value="Search">
			</form>
			
			
			
			
		</div>

			<div data-role="footer" data-position="fixed">
				<div data-role="navbar">
					<ul>
						<li><a href="fromHere.do" data-icon="arrow-r" >From Here</a></li>
						<li><a href="BusTransit.do" data-icon="navigation"class="ui-btn-active ui-state-persist" >Navigation</a></li>
						<li><a href="nearme.do" data-icon="location">Near Me</a></li>
					</ul>
				</div>
			</div>
        </div> 
    </body>
</html>