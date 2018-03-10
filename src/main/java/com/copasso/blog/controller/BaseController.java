package com.copasso.blog.controller;

import com.copasso.blog.model.Vo.UserVo;
import com.copasso.blog.utils.BlogUtils;
import com.copasso.blog.utils.MapCache;

import javax.servlet.http.HttpServletRequest;

/**
 * BaseController
 */
public abstract class BaseController {

    public static String THEME = "themes/default";

    protected MapCache cache = MapCache.single();

    /**
     * 主页的页面主题
     * @param viewName
     * @return
     */
    public String render(String viewName) {
        return THEME + "/" + viewName;
    }

    /**
     * 页面的title
     * @param request
     * @param title
     * @return
     */
    public BaseController title(HttpServletRequest request, String title) {
        request.setAttribute("title", title);
        return this;
    }

    /**
     * 页面的keywords
     * @param request
     * @param keywords
     * @return
     */
    public BaseController keywords(HttpServletRequest request, String keywords) {
        request.setAttribute("keywords", keywords);
        return this;
    }

    /**
     * 获取请求绑定的登录对象
     * @param request
     * @return
     */
    public UserVo user(HttpServletRequest request) {
        return BlogUtils.getLoginUser(request);
    }

    /**
     * 获取请求绑定的登录对象的Id
     * @param request
     * @return
     */
    public Integer getUid(HttpServletRequest request){
        return this.user(request).getUid();
    }

    /**
     * 返回404页面
     * @return
     */
    public String render_404() {
        return "comm/error_404";
    }

}
