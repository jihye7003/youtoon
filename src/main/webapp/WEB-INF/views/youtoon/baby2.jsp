<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<title>${id}님주문하시려면 매장을 선택하세요</title>
<style>
#map {
   height: 300px;
   width: 100%;
}
</style>
<script>
   //컴마씨우기
   function comma(str) {
       str = String(str);
       return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
   }
   //콤마풀기
   function uncomma(str) {
       str = String(str);
       return str.replace(/[^\d]+/g, '');
   }
</script>
<script type="text/javascript">
var lat;
var lon;

   if ("geolocation" in navigator) {
      console.log(" 지오로케이션 사용 가능 */");
      navigator.geolocation.getCurrentPosition(function(position) {
         console.log("("+position.coords.latitude+", "+ position.coords.longitude+")");
          lat=eval(position.coords.latitude);
          lon=eval(position.coords.longitude);
         });
   } else {
     /* 지오로케이션 사용 불가능 */
     console.log(" 지오로케이션 사용 불가능 *");
   }
</script>

<script type="text/javascript">
   function gmap_getdistance(lat1, lon1, lat2, lon2){
      // from http://www.movable-type.co.uk/scripts/latlong.html
      var radfactorval = 0.017453293;
      /* var lat1 = document.getElementById("latval").value;
      var lat2 = document.getElementById("latval2").value;
      var lon1 = document.getElementById("longval").value;
      var lon2 = document.getElementById("longval2").value; */
      var R = 6371; // km
      var dLat = (lat2-lat1) * radfactorval;
      var dLon = (lon2-lon1) * radfactorval;
      var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(lat1*radfactorval) * Math.cos(lat2*radfactorval) * Math.sin(dLon/2) * Math.sin(dLon/2); 
      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
      var d = R * c * 1000;//m 니까 1000
      return parseInt(d);
      //document.getElementById("distresult").innerHTML = formatnumber(d,2);
   }
</script>

<script>

var latarr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_latitude eq null? 0 : item.s_latitude }' <c:if test="${!i.last}">, </c:if></c:forEach> );
var lonarr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_longitude eq null? 0 : item.s_longitude }' <c:if test="${!i.last}">, </c:if></c:forEach> );
var addrarr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_address eq null? 0 : item.s_address }' <c:if test="${!i.last}">, </c:if></c:forEach> );
var s_codearr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_code eq null? 0 : item.s_code }' <c:if test="${!i.last}">, </c:if></c:forEach> );
var s_namearr = new Array(<c:forEach items="${storelist}" var="item" varStatus="i"> '${item.s_name eq null? 0 : item.s_name}' <c:if test="${!i.last}">, </c:if></c:forEach> );

var distancearr = new Array();   
var stores = new Array();
</script>

</head>
<body>
   <jsp:include page="header.jsp" />
   <br>
   <br>
   <br>
   <br>

   <div style="margin-top: 10%;">

      <div class="container">
         <ul id="myTab" class="nav nav-tabs" role="tablist">
            <!-- <li role="presentation" class="">
               <a data-target="#freq" role="tab" id="freq-tab" data-toggle="tab" aria-controls="freq" aria-expanded="false" >자주가는 매장</a>
            </li> -->
            <li role="presentation" class="active">
               <a data-target="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">지도에서 찾기</a>
            </li>
            <!-- <li role="presentation" class="">
               <a data-target="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false" >가까운매장</a>
            </li> -->
         </ul>
         
         <div id="myTabContent" class="tab-content">
            
            <div role="tabpane2" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
               <div id="map" style="width: 70%; height: 60%; margin: 10px;"></div>
               
               <ul id="distresult" style="display: none;">
               </ul>
               
               <script   src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAx-OV3qCLjcCKIFWMgSRHOa2uPRR7RRB4&libraries=places&callback=initMap"   async defer></script>
               
                <!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVtMhIFUiHQM5qnLz_hb1PImhAsbPWP0w&libraries=places&callback=initMap"   async defer></script>
 -->
               <!-- 
                  매장리스트 출력  , 자주가는 매장?, 가까운 매장 현재위치에서 2km이내 매장에만 주문을 전송할수 있어요 
               -->
               <br>
               <c:forEach var="list" items="${storelist}" varStatus="i">
                  <form action="store_selec.do" method="post" style="display: ${id eq null ? 'none' : 'inline'};">
                     <label id="name${i.index}" style="width:20%;">${list.s_name}</label>
                     <label id="adrs${i.index}" style="width:45%; ">${list.s_address}</label>
                     <input type="hidden" name="s_code" id="s_code${i.index}" value="${list.s_code}">
                     <label id="dist${i.index}" style="width:8%;">0</label>   
                     <input type="submit" value="선택">
                  </form><br><br>
               </c:forEach>
            </div>

            <!-- 가까운 매장 탭  -->
            <!-- <div role="tabpane3" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
               가까운 매장 탭    
            </div> -->
         </div><!-- /myTabContent  -->
      </div>
</body>
</html>