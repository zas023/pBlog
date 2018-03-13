package com.copasso.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.copasso.blog.dao.AttachVoMapper;
import com.copasso.blog.utils.DateUtils;
import com.copasso.blog.model.Vo.AttachVo;
import com.copasso.blog.model.Vo.AttachVoExample;
import com.copasso.blog.service.IAttachService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 附件、文件Service
 */
@Service
public class AttachServiceImpl implements IAttachService {
    private static final Logger LOGGER = LoggerFactory.getLogger(AttachServiceImpl.class);

    @Resource
    private AttachVoMapper attachMapper;

    @Override
    public PageInfo<AttachVo> getAttachs(Integer page, Integer limit) {
        PageHelper.startPage(page, limit);
        AttachVoExample attachVoExample = new AttachVoExample();
        attachVoExample.setOrderByClause("id desc");
        List<AttachVo> attachVos = attachMapper.selectByExample(attachVoExample);
        return new PageInfo<>(attachVos);
    }

    @Override
    public AttachVo selectById(Integer id) {
        if(null != id){
            return attachMapper.selectByPrimaryKey(id);
        }
        return null;
    }

    @Override
    public void save(String fname, String fkey, String ftype, Integer author) {
        AttachVo attach = new AttachVo();
        attach.setFname(fname);
        attach.setAuthorId(author);
        attach.setFkey(fkey);
        attach.setFtype(ftype);
        attach.setCreated(DateUtils.getCurrentUnixTime());
        attachMapper.insertSelective(attach);
    }

    @Override
    public void deleteById(Integer id) {
        if (null != id) {
            attachMapper.deleteByPrimaryKey( id);
        }
    }
}
