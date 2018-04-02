<!-- 
/****************************************************************************
CSE532 -- Project 2
File name: ObjectOrientedDBDesign.sql
Author(s): Sravya Beesabathuni (111327265)
Pooja R Dalaya (111323959 )
Brief description: This file contains the view part which displays the query numbers, which when 
pressed will display the corresponding results.
****************************************************************************/
 -->

<!--We pledge our honor that all parts
of this project were done by us alone and without collaboration with
anybody else-->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>WOCO</title>
	<style> 
		body{
			background-color:#E8DAEF;
		}
	</style>
	</head>
	<body>
		<h1> Project 2</h1>
		<p>Click on the following links to display the results for the respective queries:</p>
		<ul>
			<li>
				<a href="${pageContext.request.contextPath}/login?param=1">Query1</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/login?param=2">Query2</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/login?param=3">Query3</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/login?param=4">Query4</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/login?param=5">Query5</a>
			</li>
		</ul>
	</body>
</html>
	