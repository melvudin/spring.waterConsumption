package com.wsm.controllers;

import javax.servlet.http.HttpSession;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import java.util.Map;
import java.util.HashMap;
import com.wsm.model.User;
import com.wsm.service.LoginService;

@Controller
public class LoginController {
	/*
	 * public void LoginServiceConstructor() { }
	 */
	@Autowired
	LoginService loginService;

	/*@RequestMapping(value = "/")
	public ModelAndView login() {
		ModelAndView view = new ModelAndView();
		view.setViewName("login");
		return view;
	}*/

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String printWelcome(ModelMap model, HttpSession sessionObj) {
		
		if(sessionObj.getAttribute("oid")!=null){
			return "success";
		}else{
			return "login";
		}
		
		
	}
	
	@RequestMapping(value = "/success", method = RequestMethod.GET)
	public String success(ModelMap model,HttpSession sessionObj) {
		
		if(sessionObj.getAttribute("oid")!=null){
			return "success";
		}else{
			return "login";
		}
		
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public  ResponseEntity<Object> logout(ModelMap model,HttpSession sessionObj) {
		Map<String, Object> oidMap = new HashMap<String, Object>();
		sessionObj.setAttribute("oid",null);
		
		return new ResponseEntity<>(oidMap, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public String error(ModelMap model) {
		return "error";
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@Produces({ MediaType.APPLICATION_JSON })
	public ResponseEntity<Object> getUser(@RequestBody User user,HttpSession sessionObj) {

		System.out.println("Fetching User with id " + user.getUsername());
		int result = loginService.getLoginId(user);
		Map<String, Object> oidMap = new HashMap<String, Object>();
		
		
		
		if (!Integer.toString(result).equals("0")) {
			sessionObj.setAttribute("oid" , Integer.toString(result));
			oidMap.put("result", Integer.toString(result));
			System.out.println(oidMap);
			return new ResponseEntity<>(oidMap, HttpStatus.OK);
		} else{
			oidMap.put("result", "failed");
			System.out.println(oidMap);
		return new ResponseEntity<>(oidMap, HttpStatus.FORBIDDEN);
		}
	}
}
// processRequest(User request)
// throws IOException, ServletException {
// System.out.println(request.getUsername());
//
// Map<String,Object> entities = new HashMap<String,Object>();
//
// /*String name = request.getParameter("txtUserName");
// String password = request.getParameter("txtUserPassword");
// if (name.equalsIgnoreCase("kaka")&& password.equalsIgnoreCase("kaka")) {
// RequestDispatcher rd = request.getRequestDispatcher("success.jsp");
// request.setAttribute("name", name);
// request.setAttribute("password", password);
// rd.forward(request, response);
// } else {
// response.sendRedirect("error.jsp");
// }*/
// return new ResponseEntity<Object>(entities, HttpStatus.OK);
/*
 * protected void doGet(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException { processRequest(request,
 * response); }
 * 
 * protected void doPost(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException { processRequest(request,
 * response); }
 */
