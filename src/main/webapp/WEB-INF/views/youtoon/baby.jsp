<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>육아<title>
<script>
      // 2. This code loads the IFrame Player API code asynchronously.
      var tag = document.createElement('script');

      tag.src = "https://www.youtube.com/iframe_api";
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      // 3. This function creates an <iframe> (and YouTube player)
      //    after the API code downloads.
      var player;
      function onYouTubeIframeAPIReady() {
        player = new YT.Player('#player', {
          height: '360',
          width: '640',
          videoId: 'M7lc1UVf-VE',
          playerVars:{
        	  autoplay:0,
        	  controls:0
          }
        });
      }
    </script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

	<!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id="player"></div>

    
</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>