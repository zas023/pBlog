package com.copasso.blog.controller;

import com.copasso.blog.model.BMessage;
import com.copasso.blog.model.bo.User;
import com.copasso.blog.model.vo.UserCustom;
import com.copasso.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;


import com.copasso.blog.util.FunctionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

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

	@RequestMapping("/user/list")
	@ResponseBody
	public BMessage userList() throws Exception {
		List<UserCustom> list=userService.listUser();
		return new BMessage(list).success();
	}


}
