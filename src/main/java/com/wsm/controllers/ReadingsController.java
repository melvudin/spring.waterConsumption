package com.wsm.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wsm.model.User;
import com.wsm.newpojo.Readings;
import com.wsm.service.ChartService;

@Controller
public class ReadingsController {

	@Autowired
	ChartService chartservice;

	@RequestMapping(value = "/getdata", method = RequestMethod.POST)
	@Produces({ MediaType.APPLICATION_JSON })
	public ResponseEntity<Object> getUser(
			@RequestBody User user)/* session from login */ {

		/*
						 * put oid from first in login session and set in user
						 * object as oid because it accepts only User object
						 */ 
		System.out.println(user.getOid());
		List<Readings> result = chartservice.getReadingData(user);

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result", result);

		return new ResponseEntity<>(resultMap, HttpStatus.OK);

	}

}
