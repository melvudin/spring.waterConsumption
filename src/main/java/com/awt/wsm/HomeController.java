package com.awt.wsm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	@RequestMapping("/")
	public ModelAndView helloWorld() {
		String message = "<br><div style='text-align:center;'>" + " Hello World</h3></div><br><br>";
		return new ModelAndView("home", "message", message);
	}

//	@RequestMapping
//	public ModelAndView handle(HttpServletRequest request) {
//		return null;
//	}
//
//	@RequestMapping
//	public ModelAndView handle(HttpServletResponse request) {
//		return null;
//	}

}