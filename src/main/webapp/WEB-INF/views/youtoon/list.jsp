<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.google.gdata.client.youtube.YouTubeService" %>
<%@ page import="com.google.gdata.data.youtube.VideoFeed" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.google.gdata.data.media.mediarss.MediaThumbnail" %>
<%@ page import="com.google.gdata.data.youtube.VideoEntry" %>
<%
String youtubePage = request.getParameter("youtubePage");

int pageNum = Integer.parseInt(youtubePage);
int startNum = (pageNum-1)*6;
int endNum = pageNum*6;

String youtubeUrl = "";
String username = "tjdrlans119";
String password = "qowxz119!!";
String developerKey = "AIzaSyCUA0Ia_Tr9nmipy-Ze-PL4koHBPvUsIGw";

YouTubeService service = new YouTubeService("tjdrlans119@gmail.com", developerKey);
VideoFeed videoFeed = null;
try{
	service.setUserCredentials(username, password);
	videoFeed = service.getFeed(new URL("http://gdata.youtube.com/feeds/api/users/default/uploads?max-results=30"), VideoFeed.class);
}catch(Exception e){
	e.printStackTrace();
}
%>
<div class="videoList" id="video_list">
	<ul class="videos">
	<%
	if(videoFeed!=null){
		List<VideoEntry> videoList = videoFeed.getEntries();
		if(videoList!=null&&videoList.size()>0){
			int iLoop = videoList.size();
			String youtubeTitle = "";
			String youtubeDate = "";
			for(int i=startNum; i<endNum; i++){
				VideoEntry videoEntry = videoList.get(i);
				youtubeTitle = videoEntry.getTitle().getPlainText();
				//youtubeTitle = K2UtilBean.getByteCut(youtubeTitle, 30);
				youtubeDate = videoEntry.getUpdated().toString();
				youtubeDate = youtubeDate.substring(0,10);
				youtubeDate = youtubeDate.replaceAll("-","/");
				MediaThumbnail mediaThumbnail = videoEntry.getMediaGroup().getThumbnails().get(0);
	%>
		<li>
			<div class="visaul">
				<a href="<%=videoEntry.getHtmlLink().getHref() %>" target="_blank">
					<img src="<%=mediaThumbnail.getUrl() %>" width="212" height="135">
				</a>
			</div>
			<p class="text"><%=youtubeTitle %></p>
			<p class="date"><%=youtubeDate %></p>
		</li>
	<%	
			}
		}
	}
	%>
	</ul>
</div>
