package com.copasso.blog.service.impl;

import com.copasso.blog.model.bo.Link;
import com.copasso.blog.dao.LinkMapper;
import com.copasso.blog.dao.custom.LinkMapperCustom;
import com.copasso.blog.model.vo.LinkCustom;
import com.copasso.blog.service.LinkService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by 言曌 on 2017/9/4.
 */
public class LinkServiceImpl implements LinkService {
	
	@Autowired
	private LinkMapperCustom linkMapperCustom;
	
	@Autowired
	private LinkMapper linkMapper;
	@Override
	public Integer countLink(Integer status) throws Exception {
		Integer linkCount = linkMapperCustom.countLink(status);
		return linkCount;
	}
	
	@Override
	public List<LinkCustom> listLink(Integer status) throws Exception {
		List<LinkCustom> linkList = linkMapperCustom.listLink(status);
		return linkList;
	}

	@Override
	public void insertLink(Link link) throws Exception {
		linkMapper.insertSelective(link);
	}

	@Override
	public void deleteLink(Integer id) throws Exception {
		linkMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void updateLink(Link link) throws Exception {
		linkMapper.updateByPrimaryKeySelective(link);
	}

	@Override
	public LinkCustom getLinkById(Integer id) throws Exception {
		Link link = linkMapper.selectByPrimaryKey(id);
		LinkCustom linkCustom = new LinkCustom();
		BeanUtils.copyProperties(link,linkCustom);
		return linkCustom;
	}

}
