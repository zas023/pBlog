package com.copasso.blog.interceptor;

import com.copasso.blog.model.Vo.UserVo;
import com.copasso.blog.service.IUserService;
import com.copasso.blog.utils.*;
import com.copasso.blog.constant.WebConst;
import com.copasso.blog.dto.Types;
import com.copasso.blog.utils.common.AdminCommons;
import com.copasso.blog.utils.common.Commons;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 自定义拦截器
 */
@Component
public class BaseInterceptor implements HandlerInterceptor {
    private static final Logger LOGGE = LoggerFactory.getLogger(BaseInterceptor.class);
    private static final String USER_AGENT = "user-agent";

    @Resource
    private IUserService userService;

    private CacheMap cache = CacheMap.single();

    @Resource
    private Commons commons;

    @Resource
    private AdminCommons adminCommons;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        String uri = request.getRequestURI();

        LOGGE.info("UserAgent: {}", request.getHeader(USER_AGENT));
        LOGGE.info("用户访问地址: {}, 来路地址: {}", uri, IPUtils.getIpAddrByRequest(request));


        //请求拦截处理(检测登陆用户)
        UserVo user = BlogUtils.getLoginUser(request);
        if (null == user) {
            Integer uid = BlogUtils.getCookieUid(request);
            if (null != uid) {
                //这里还是有安全隐患,cookie是可以伪造的
                user = userService.queryUserById(uid);
                request.getSession().setAttribute(WebConst.LOGIN_SESSION_KEY, user);
            }
        }
        //当请求为/admin时，判断是否有登陆用户，无则跳转登陆界面
        if (uri.startsWith("/admin") && !uri.startsWith("/admin/login") && null == user) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return false;
        }
        //设置get请求的token
        if (request.getMethod().equals("GET")) {
            //生成token
            String csrf_token = UUID.UU64();
            //默认存储30分钟
            cache.hset(Types.CSRF_TOKEN.getType(), csrf_token, uri, 30 * 60);
            request.setAttribute("_csrf_token", csrf_token);
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        //一些工具类和公共方法
        httpServletRequest.setAttribute("commons", commons);
        httpServletRequest.setAttribute("adminCommons", adminCommons);
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
