<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
		integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
		crossorigin="anonymous"></script>
	<script type="text/javascript" src="resources/js/login.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDgo23rEqu2P2noWjwuUlnvIvkpX-kfG-M"></script>
	<script type="text/javascript">
	jQuery(document).ready(function($) {
$("#map-form").submit(function(event) {
			
			var url = "<%=request.getContextPath()%>/success" ;
			window.location.replace(url);
			
			return false;
		});
		
		
		var zip,country;
		var chartData=[];
		var readingData=[];
		var consumption;
		var readingData=[];
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
				zip=response.zipcode;
				country=response.country;
				consumption=response.consumption;
				var map;
				var latitude;
				var longitude;
				var location;
				var geocoder= new google.maps.Geocoder();
				var address = zip+","+country;
				console.log(address)
				geocoder.geocode({ 'address': address }, function (results, status) {
		            if (status == google.maps.GeocoderStatus.OK) {
		            	var myOptions = {
		                        zoom: 12,
		                        center: results[0].geometry.location,
		                        mapTypeId: google.maps.MapTypeId.ROADMAP
		                    }
		            	map = new google.maps.Map(document.getElementById("map"), myOptions);
				

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
									
								}

								var dailyavg = sum/readingData.length;
								var weeklyavg=dailyavg*7;
								var monthlyavg=dailyavg*30;
								
							
				            	
				                var marker = new google.maps.Marker({
				                    map: map,
				                    position: results[0].geometry.location
				                });
				            	
				                var infowindow = new google.maps.InfoWindow({
				                    content: '<p><b>Location: </b> '+zip + ","+country+'<br>'
				                    +'<p><b>Total Consumption: </b> ' +sum +'<br>'
				                    +'<p><b> Consumption: </b> ' +consumption + " <br> <b>Daily Average :</b> "+dailyavg+' <br>'
				                    +'<b>Weekly Average: </b> ' +weeklyavg + " <br><b> Monthly Average:</b> "+monthlyavg+'<br></p>'
				                    
				                  });

				                  google.maps.event.addListener(marker, 'click', function() {
				                    infowindow.open(map, marker);
				                  });

								
							},
							error: function(response) {
							<%-- var url = "<%=request.getContextPath()%>/error";
								window.location.replace(url); --%>
							}
						});
		            	
		            	
		            	
		            	
		            } else {
		                alert("Request failed.")
		            }
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
</head>
<body>
	<%@ page session="true"%>
	<div id="page-content-wrapper" >
		<div class="well">
	<button type="button" class="btn btn-info">House Id  <span class="badge" id="houseid"></span></button>
	<button type="button" class="btn btn-info">SmartMeter Id  <span class="badge" id="smartid"></span></button>
	<button type="button" class="btn btn-info">Consumption  <span class="badge" id="consumption"></span></button>
	
	<button type="button" class="btn btn-info">Building Id  <span class="badge" id="buildingid"></span></button>
	
	<button type="button" class="btn btn-info">Zip Code  <span class="badge" id="zip"></span></button>
	
	<button type="button" class="btn btn-info">Country  <span class="badge" id="country"></span></button>
	
	
	
</div>
	<form id="map-form">
	<button type="submit" id="bth-search" type="button" class="btn btn-info  btn-lg">Home</button>
	</form>
	<form id="logout-form">

		<button type="submit" id="bth-search" class="btn btn-info btn-lg">
			<b>Logout</b>
		</button>
	</form>
		
		
		
		</div>
	<div id="map" style="width: 1360px; height: 450px;"></div> 
	
</body>
</html>