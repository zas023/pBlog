package com.copasso.blog.controller.main;

import com.copasso.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;


import com.copasso.blog.util.FunctionUtils;
/**
 * 用户的controller
 */
@Controller
public class UserController {

	@Autowired
	private  HttpServletRequest request;

	@Autowired
	private UserService userService;

	@Autowired
	private FunctionUtils functionUtils;


}
