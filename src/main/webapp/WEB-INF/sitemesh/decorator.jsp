
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <link rel="shortcut icon" type="image/x-icon" href="resources/images/fileUpload.PNG" />
<title>File Upload</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0" />

<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css"
	rel="stylesheet">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/font-awesome.min.css">
<script src="resources/js/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
</head>
<style> 
body {
	min-height: 100vh;
	background: linear-gradient(to left, #f2f2f2, #e6ffe6);
}
/* body {
    background: url(resources/images/bgimg.jpg) no-repeat 0 10%;
}  */

</style>
<body class="d-flex flex-column min-vh-100">
	<header>
		<nav class="navbar navbar-expand-lg navbar-light"
			style="background-color: #ccccff">
			<a class="navbar-brand" href="dashboard"><img
				style="margin: -16px; margin-top: -23px;"
				src="resources/images/fileUpload.PNG" height="57px;"
				width="200px;"> </a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav w-100">
					<li class="nav-item"><a class="nav-link text-white"></a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="dashboard"><i class="fas fa-home">&nbsp;Home</i></a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="base64page"><i class="fas fa-image">&nbsp;Base64Image</i></a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="fileuploadpage"><i class="fas fa-upload"></i>&nbsp;FileUpload</i></a></li>
				</ul>
			</div>
		</nav>
	</header> 
	<div class="container">
		<sitemesh:write property="body" />
	</div> 
	<footer class="mt-auto text-center" style="background: #818896;">
		<footer id="sticky-footer" class="py-4 text-white-50"
			style="background: #243e8e">
			<div class="container text-center text-white">
				<strong>© 2021 made with <i class="fa fa-heart"
					style="color: red"></i> by - Anup kumar
				</strong>
			</div>
		</footer>
	</footer>
</body>
</html>