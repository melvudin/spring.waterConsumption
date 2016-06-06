package com.wsm.controllers;

import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.wsm.model.User;
import com.wsm.service.LoginService;

@Controller
public class LoginController {
	/*
	 * public void LoginServiceConstructor() { }
	 */
	@Autowired 
	LoginService loginService;

	@RequestMapping(value = "/")
	public ModelAndView login() {
		ModelAndView view = new ModelAndView();
		view.setViewName("login");
		return view;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@Produces({ MediaType.APPLICATION_JSON })
	public ResponseEntity<Object> getUser(@RequestBody User user) {

		System.out.println("Fetching User with id " + user.getUsername());
		String result=loginService.getLoginId(user);
		if (result.equals("success")){
			return new ResponseEntity<>(result, HttpStatus.OK);
		}else{
			return new ResponseEntity<>(result, HttpStatus.FORBIDDEN);
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
}
}

/*
 * protected void doGet(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException { processRequest(request,
 * response); }
 * 
 * protected void doPost(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException { processRequest(request,
 * response); }
 */
