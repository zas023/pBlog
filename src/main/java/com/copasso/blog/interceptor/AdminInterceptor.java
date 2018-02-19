package com.copasso.blog.interceptor;

import com.copasso.blog.model.bo.User;
import com.copasso.blog.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.context.request.WebRequestInterceptor;
import javax.servlet.http.HttpSession;

public class AdminInterceptor implements WebRequestInterceptor {

    @Autowired
    private HttpSession httpSession;

    @Autowired
    private UserService userService;

    /************************WebRequestInterceptor****************************/

    /**
     * 在请求处理之前执行，该方法主要是用于准备资源数据的，然后可以把它们当做请求属性放到WebRequest中
     */
    @Override
    public void preHandle(WebRequest request) throws Exception {
        User user = (User) httpSession.getAttribute("user");
        User user2 = userService.getUserById(user.getUserId());
        request.setAttribute("loginUser",user2,WebRequest.SCOPE_SESSION);
    }
    /**
     * 该方法将在Controller执行之后，返回视图之前执行，ModelMap表示请求Controller处理之后返回的Model对象，所以可以在
     * 这个方法中修改ModelMap的属性，从而达到改变返回的模型的效果。
     */
    @Override
    public void postHandle(WebRequest request, ModelMap map) throws Exception {
    }

    @Override
    public void afterCompletion(WebRequest webRequest, Exception e) throws Exception {

    }
}

