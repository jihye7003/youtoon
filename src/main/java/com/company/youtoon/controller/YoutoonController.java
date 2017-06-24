package com.company.youtoon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class YoutoonController {

	@RequestMapping("/main.do") //// 수정된 메인 매핑 6/11 Pm 7:33 ///////////
	public String main() {
		return "youtoon/main";
	}

}
