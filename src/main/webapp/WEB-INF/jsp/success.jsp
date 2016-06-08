<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success Page</title>
</head>
<body>

	<form id="logout-form">
								
								<button type="submit" id="bth-search"
									class="btn btn-primary btn-lg">
									<b>Logout</b>
								</button>
							</form>

<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
		integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
		crossorigin="anonymous"></script>
	<script type="text/javascript" src="resources/js/login.js"></script>
	<script type="text/javascript">

	jQuery(document).ready(function($) {
		$("#logout-form").submit(function(event) {
				
			
				$.ajax({
					type : "POST",
					contentType : "application/json;charset=UTF-8",
					url : "logout/",
					dataType: 'json',
					success:function(response) { 
					var url = "<%=request.getContextPath()%>/" ;
					window.location.replace(url); },
					error: function(response) {
					var url = "<%=request.getContextPath()%>/error";
						window.location.replace(url);
					}
				});
				return false;
			});
		});
	</script>
	
	</body>
</html>
