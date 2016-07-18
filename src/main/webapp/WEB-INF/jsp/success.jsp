<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success Page</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">
</head>
<body>
	<%@ page session="true"%>
	
	
	<div class="well">
	<button type="button" class="btn btn-info">House Id  <span class="badge" id="houseid"></span></button>
	<button type="button" class="btn btn-info">SmartMeter Id  <span class="badge" id="smartid"></span></button>
	<button type="button" class="btn btn-info">Consumption  <span class="badge" id="consumption"></span></button>
	
	<button type="button" class="btn btn-info">Building Id  <span class="badge" id="buildingid"></span></button>
	
	<button type="button" class="btn btn-info">Zip Code  <span class="badge" id="zip"></span></button>
	
	<button type="button" class="btn btn-info">Country  <span class="badge" id="country"></span></button>
	
	
	
</div>
	<form id="map-form">
	<button type="submit" id="bth-search" type="button" class="btn btn-info  btn-lg">Map</button>
	</form>
	<form id="logout-form">

		<button type="submit" id="bth-search" class="btn btn-info btn-lg">
			<b>Logout</b>
		</button>
	</form>
	Daily Average<input type="checkbox" name="checkme" value="check_uncheckme" id="checkme"/>
	<div align="right">
	<select id="selectBox">
   <option value="1">Days</option>
   <option value="2">Weeks</option>
   <option value="3">Months</option>
  </select>
  </div>
	<div id="container" style="height: 400px; background-color: #ffffff"></div>

	<div id="p" style="background-color: #ffffff"></div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
		integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
		crossorigin="anonymous"></script>
	<script type="text/javascript" src="resources/js/login.js"></script>
	<script src="https://code.highcharts.com/stock/highstock.js"></script>
	<script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script type="text/javascript">

	jQuery(document).ready(function($) {
		
		
		
		$("#map-form").submit(function(event) {
			
			var url = "<%=request.getContextPath()%>/map" ;
			window.location.replace(url);
			
			return false;
		});
			
		var dailyavg;
		var useroid=${sessionScope.oid};
		var jsonuser= {oid:useroid};
		$.ajax({
			type : "POST",
			contentType : "application/json;charset=UTF-8",
			url : "getuserdata/",
			data: JSON.stringify(jsonuser),
			dataType: 'json',
			success:function(response) {
				document.getElementById("houseid").innerHTML =response.houseid;
				document.getElementById("smartid").innerHTML =response.smartid;
				document.getElementById("buildingid").innerHTML =response.buildingid;
				document.getElementById("consumption").innerHTML =response.consumption;
				document.getElementById("zip").innerHTML =response.zipcode;
				document.getElementById("country").innerHTML =response.country;
				
			},
			error: function(response) {
			<%-- var url = "<%=request.getContextPath()%>/error";
				window.location.replace(url); --%>
			}
		});
		
		
		$("#selectBox").on('change',  function() {
			
			var chart = $('#container').highcharts();
			
		    var selectBox = document.getElementById("selectBox");
		    var selectedValue = selectBox.options[selectBox.selectedIndex].value;
		
		   
		    if(selectedValue==="1"){
		    	chart.series[0].update({ dataGrouping: {
		    		forced: true,
	                units: [ ['day', [1] ] ]
	            } });
		    	
			}
			
			if(selectedValue==="2"){
				chart.series[0].update({ dataGrouping: {
					forced: true,
	                units: [ ['week', [1] ] ]
	            } });
				
			}
			
			if(selectedValue==="3"){
				chart.series[0].update({ dataGrouping: {
					forced: true,
	                units: [ ['month', [1] ] ]
	            } });
				
			}
		    
		});

		
		var showAlert = function(date,timestamp, value) {
			
				
			var readingDate=new Date(date);
			var popuphtml = 'Day Usage <br>';
			var readingDateString=readingDate.toDateString();
			popuphtml=popuphtml.concat('<ul>');
			for (var i in chartData) {
				var datesfromreading=new Date(chartData[i][0]);
				var checkdate=datesfromreading.toDateString();
				
				if(readingDateString===checkdate){
					
					var hours = datesfromreading.getHours();
					var minutes = "0" + datesfromreading.getMinutes();
					var seconds = "0" + datesfromreading.getSeconds();
					popuphtml=popuphtml.concat('<li>'+hours + ':' + minutes.substr(-2) + ':' + seconds.substr(-2)+' - '+chartData[i][1]+'</li>');
				}
			}
			popuphtml=popuphtml.concat('</ul>');
			
			$("#p").dialog({
				  height: 400
			}); 
	        $("#p").html(popuphtml);
	        
		};
		
		var chartData=[];
		var readingData=[];
		
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
				
				var sum = 0;
				var i;
				var total;
				for(  i = 0; i < readingData.length; i++ ){

					sum += readingData[i][1]; 
					total=readingData[i][1];
				}

				dailyavg = sum/readingData.length;
				console.log(dailyavg);
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
			                },
			                point: {
			                    events: {
			                        click: function () {
			                        	
			                        	showAlert(this.x,this.series.processedXData,this.series.processedYData);
			                        }
			                    }
			                }
			            }]
			        });			
			},
			error: function(response) {
			<%-- var url = "<%=request.getContextPath()%>/error";
				window.location.replace(url); --%>
			}
		});
		
		$("#checkme").change(function checkAvg() {
			var chkBox = document.getElementById('checkme');
			var chart = $('#container').highcharts();
			if (chkBox.checked)
		    {
				var plotLines = [{
					"id":"plotline-1",
				    "value": dailyavg,
				        "width": 2,
				        "color": "#666",
				        "zIndex": 10,
				        "dashStyle": "Dash",
				        "label": {
				        "text": "Daily Average: "+dailyavg,
				            "rotation": 0,
				            "align": "center",
				            "x": 0,
				            "y": -5,
				            "style": {
				            "fontSize": "14px"
				        }
				    }
				}];
				console.log(chart);
				chart.yAxis[0].update({
		            plotLines: plotLines
		            
		        });
				/* chart.yAxis[1].addPlotLine({ 
	                width: 2,
	                value: 5.5,
	                id: 'plotline-1'
	            }); */
				
		    }else{
		    	chart.yAxis[0].removePlotLine('plotline-1');
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
