package com.project.okr;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping("/")
	public String main() {
		return "main";
	}

	@RequestMapping("/myokr")
	public String myokr() {
		return "myokr";
	}

	@RequestMapping("/teamokr")
	public String teamokr() {
		return "teamokr";
	}

	@RequestMapping("/companyokr")
	public String companyokr() {
		return "companyokr";
	}

}
