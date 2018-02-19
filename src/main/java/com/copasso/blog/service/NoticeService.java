package com.copasso.blog.service;

import com.copasso.blog.model.bo.Notice;
import com.copasso.blog.model.vo.NoticeCustom;

import java.util.List;

public interface NoticeService {


    //获得公告列表
    public List<NoticeCustom> listNotice(Integer status) throws Exception;

    //添加公告
    public void insertNotice(Notice notice) throws Exception;

    //删除公告
    public void deleteNotice(Integer id) throws Exception;

    //更新公告
    public void updateNotice(Notice notice) throws Exception;

    //根据id查询公告
    public NoticeCustom getNoticeById(Integer id) throws Exception;
    
}