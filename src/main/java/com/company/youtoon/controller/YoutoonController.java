package com.company.youtoon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.company.youtoon.service.ChannelBulletin;
import com.google.api.client.json.Json;

@Controller
public class YoutoonController {

	@RequestMapping("/main.do") //// 수정된 메인 매핑 6/11 Pm 7:33 ///////////
	public String main() {
		
		Json js = new Json();
		ChannelBulletin cb = new ChannelBulletin();
		//ChannelBulletin
		return "youtoon/main";
	}
	
	@RequestMapping("/beauty.do") //// 수정된 메인 매핑 6/11 Pm 7:33 ///////////
	public String beauty() {
//		return "youtoon/beauty";
		return "youtoon/list";
	}
	
	@RequestMapping("/baby.do") //// 수정된 메인 매핑 6/11 Pm 7:33 ///////////
	public String baby() {
		return "youtoon/baby";
	}

	
	@RequestMapping("/diet.do") //// 수정된 메인 매핑 6/11 Pm 7:33 ///////////
	public String diet() {
		return "youtoon/diet";
	}

	
	@RequestMapping("/sport.do") //// 수정된 메인 매핑 6/11 Pm 7:33 ///////////
	public String sport() {
		return "youtoon/sport";
	}

	
	@RequestMapping("/game.do") //// 수정된 메인 매핑 6/11 Pm 7:33 ///////////
	public String game() {
		return "youtoon/game";
	}
	
	@RequestMapping("/fashion.do") //// 수정된 메인 매핑 6/11 Pm 7:33 ///////////
	public String fashion() {
		return "youtoon/fashion";
	}



}
