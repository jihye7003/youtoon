package com.company.youtoon.service;

import com.google.gdata.client.youtube.YouTubeService;
import com.google.gdata.data.media.MediaFileSource;
import com.google.gdata.data.media.mediarss.MediaCategory;
import com.google.gdata.data.media.mediarss.MediaDescription;
import com.google.gdata.data.media.mediarss.MediaKeywords;
import com.google.gdata.data.media.mediarss.MediaTitle;
import com.google.gdata.data.youtube.VideoEntry;
import com.google.gdata.data.youtube.YouTubeMediaGroup;
import com.google.gdata.data.youtube.YouTubeNamespace;

import java.io.File;
import java.net.URL;

public class YoutubeBiz {
	public String youtubeUplad(String filePath, String videoTitle){
		String youtubeUrl = "";
		String username = "tjdrlans119";
		String password = "qowx119";
		String developerKey = "AIzaSyCUA0Ia_Tr9nmipy-Ze-PL4koHBPvUsIGw";
		
		YouTubeService service = new YouTubeService("tjdrlans119@gmail.com", developerKey);
		
		try{
			service.setUserCredentials(username, password);
			
			 File videoFile = new File(filePath);
			 if(videoFile.exists()) {
				 MediaFileSource ms = new MediaFileSource(videoFile, "video/quicktime");
				 
				 VideoEntry newEntry = new VideoEntry();
				 YouTubeMediaGroup mg = newEntry.getOrCreateMediaGroup();
				 mg.addCategory(new MediaCategory(YouTubeNamespace.CATEGORY_SCHEME, "Tech"));
				 mg.setTitle(new MediaTitle());
				 mg.getTitle().setPlainTextContent(videoTitle);
				 mg.setKeywords(new MediaKeywords());
				 mg.getKeywords().addKeyword("Å°¿öµå");
				 mg.setDescription(new MediaDescription());
				 mg.getDescription().setPlainTextContent(videoTitle);
				 
				 newEntry.setMediaSource(ms);
				 VideoEntry createdEntry = service.insert(new URL("http://uploads.gdata.youtube.com/feeds/api/users/default/uploads"), newEntry);
				 String id = createdEntry.getId();
				 
				 if(id!=null&&!"".equals(id)){
					 youtubeUrl = "http://youtu.be/"+id.substring(id.lastIndexOf(":")+1, id.length());
				 }
			 }
		}catch(Exception e){
			e.printStackTrace();
		}
		return youtubeUrl;
	}
}
