package com.copasso.blog.controller.main;

import com.copasso.blog.model.bo.Link;
import com.copasso.blog.service.LinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import java.util.Date;

/**
 * 友情链接的controller
 */
@Controller
public class LinkController {
	@Autowired
	private LinkService linkService;

	@RequestMapping("/applyLink")
	public ModelAndView applyLinkView() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("Home/Page/applyLink");
		return modelAndView;
	}


	@RequestMapping(value = "/applyLinkSubmit",method = {RequestMethod.POST})
	@ResponseBody
	public void applyLinkSubmit(Link link) throws Exception {
		link.setLinkStatus(0);
		link.setLinkCreateTime(new Date());
		link.setLinkUpdateTime(new Date());
		linkService.insertLink(link);
	}
}
