<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success Page</title>
</head>
<body>
	<%@ page session="true"%>
	${sessionScope.oid}
	<form id="logout-form">

		<button type="submit" id="bth-search" class="btn btn-primary btn-lg">
			<b>Logout</b>
		</button>
	</form>
	<div id="container" style="height: 400px"></div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
		integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
		crossorigin="anonymous"></script>
	<script type="text/javascript" src="resources/js/login.js"></script>
	<script src="https://code.highcharts.com/stock/highstock.js"></script>
	<script src="https://code.highcharts.com/stock/modules/exporting.js"></script>

	<script type="text/javascript">

	jQuery(document).ready(function($) {
		//console.log(${sessionScope.oid});
		var useroid=${sessionScope.oid};
		var json= {oid:useroid};
		console.log(json);
		$.ajax({
			type : "POST",
			contentType : "application/json;charset=UTF-8",
			url : "getdata/",
			data: JSON.stringify(json),
			dataType: 'json',
			success:function(response) { 
				var resultData=response.result;
				
				var chartData=[];
				var readingData=[];
				for(i in resultData){
					var dateTime=resultData[i].readingTimeStamp;
					var value=resultData[i].totalConsumption;
					var item=[dateTime,value];
					chartData.push(item);
					
				}
				chartData.sort();
				
				var dailyConsumption=0;
				var j=1;
				var dataSize=chartData.length-1;
				
				for (var i in chartData) {
					
					
					if(j<=dataSize){
						
					var readingTimeStamp = new Date(chartData[i][0]);
					var readingTimeStampString = readingTimeStamp.toDateString();
					
					var nextReadingTimeStamp = new Date(chartData[j][0]);
					var nextReadingTimeStampString = nextReadingTimeStamp.toDateString();
					
					
					
					if(readingTimeStampString===nextReadingTimeStampString){
						
					dailyConsumption=dailyConsumption+(chartData[j][1]-chartData[i][1]);
					
					}
					
					if(readingTimeStampString!==nextReadingTimeStampString){
						
						var dateTime=chartData[i][0];
						var value=dailyConsumption;
						var item=[dateTime,value];
						readingData.push(item);						
						dailyConsumption=0;
						
					}
					
					j++;
					}
				
					
				}
				
				readingData.sort();
				
				
				
				 $('#container').highcharts('StockChart', {
			            chart: {
			                alignTicks: false
			            },

			            rangeSelector: {
			                selected: 1
			            },

			            title: {
			                text: 'Water Smartmeter'
			            },

			            series: [{
			                type: 'column',
			                name: 'Water Smartmeter',
			                data: readingData,
			                turboThreshold: 50000,
			                dataGrouping: {
			                    units: [[
			                        'week', // unit name
			                        [1] // allowed multiples
			                    ], [
			                        'month',
			                        [1, 2, 3, 4, 6]
			                    ]]
			                }
			            }]
			        });			
			},
			error: function(response) {
			<%-- var url = "<%=request.getContextPath()%>/error";
				window.location.replace(url); --%>
			}
		});

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
					<%-- var url = "<%=request.getContextPath()%>/error";
						window.location.replace(url); --%>
					}
				});
				return false;
			});
		});
	</script>

</body>
</html>
