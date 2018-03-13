package com.copasso.blog.service.impl;

import com.copasso.blog.dao.UserVoMapper;
import com.copasso.blog.exception.TipException;
import com.copasso.blog.model.Vo.UserVo;
import com.copasso.blog.service.IUserService;
import com.copasso.blog.utils.BlogUtils;
import com.copasso.blog.model.Vo.UserVoExample;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 用户Service
 */
@Service
public class UserServiceImpl implements IUserService {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);

    @Resource
    private UserVoMapper userMapper;
    
    @Override
    public Integer insertUser(UserVo userVo) {
        if (StringUtils.isNotBlank(userVo.getUsername()) && StringUtils.isNotBlank(userVo.getEmail())) {
            //用户密码加密
            String encodePwd = BlogUtils.MD5encode(userVo.getUsername() + userVo.getPassword());
            userVo.setPassword(encodePwd);
            userMapper.insertSelective(userVo);
        }
        return userVo.getUid();
    }

    @Override
    public UserVo queryUserById(Integer uid) {
        if (uid == null)
            return null;
        return userMapper.selectByPrimaryKey(uid);
    }

    @Override
    public UserVo login(String username, String password) {
        if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
            throw new TipException("用户名和密码不能为空");
        }
        UserVoExample example = new UserVoExample();
        UserVoExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        long count = userMapper.countByExample(example);
        if (count < 1) {
            throw new TipException("不存在该用户");
        }
        String pwd = BlogUtils.MD5encode(username+password);
        criteria.andPasswordEqualTo(pwd);
        List<UserVo> userVos = userMapper.selectByExample(example);
        if (userVos.size()!=1) {
            throw new TipException("用户名或密码错误");
        }
        return userVos.get(0);
    }

    @Override
    public void updateByUid(UserVo userVo) {
        if (null == userVo || null == userVo.getUid()) {
            throw new TipException("请正确输入用户");
        }
        int i = userMapper.updateByPrimaryKeySelective(userVo);
        if(i!=1){
            throw new TipException("用户不唯一");
        }
    }
}
