package com.copasso.blog.service.impl;

import com.copasso.blog.model.bo.Notice;
import com.copasso.blog.model.vo.NoticeCustom;
import com.copasso.blog.dao.NoticeMapper;
import com.copasso.blog.dao.custom.NoticeMapperCustom;
import com.copasso.blog.service.NoticeService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapperCustom noticeMapperCustom;

    @Autowired
    private NoticeMapper noticeMapper;


    @Override
    public List<NoticeCustom> listNotice(Integer status) throws Exception {
        List<NoticeCustom> noticeList = noticeMapperCustom.listNotice(status);
        return noticeList;
    }

    @Override
    public void insertNotice(Notice notice) throws Exception {
        noticeMapper.insertSelective(notice);
    }

    @Override
    public void deleteNotice(Integer id) throws Exception {
        noticeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void updateNotice(Notice notice) throws Exception {
        noticeMapper.updateByPrimaryKeySelective(notice);
    }

    @Override
    public NoticeCustom getNoticeById(Integer id) throws Exception {
        Notice notice = noticeMapper.selectByPrimaryKey(id);
        NoticeCustom noticeCustom = new NoticeCustom();
        BeanUtils.copyProperties(notice,noticeCustom);
        return noticeCustom;
    }

}
