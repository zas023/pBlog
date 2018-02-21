<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>
<%--
    站点地图
--%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="applicable-device" content="pc,mobile">
    <meta name="MobileOptimized" content="width"/>
    <meta name="HandheldFriendly" content="true"/>
    <link rel="stylesheet" href="/plugin/layui/css/layui.css">
    <link rel="shortcut icon" href="/img/logo.png">
        <meta name="description" content="站点地图" />
        <meta name="keywords" content="站点地图" />
        <title>
            站点地图
        </title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/plugin/font-awesome/css/font-awesome.min.css">

    <link rel="stylesheet" href="/plugin/layui/css/layui.css">
</head>
<body>
<div id="page" class="site" style="transform: none;">

    <%@ include file="../Public/header.jsp" %>
    <%--面包屑导航 start--%>
    <nav class="breadcrumb">
        <a class="crumbs" href="/">
            <i class="fa fa-home"></i>首页
        </a>
        <i class="fa fa-angle-right"></i>
        站点地图
        <i class="fa fa-angle-right"></i>
        正文
    </nav>
    <%--面包屑导航 end--%>

    <div id="content" class="site-content" style="transform: none;">
        <%--博客主体-左侧正文 start--%>
        <section id="primary" class="content-area">
            <main id="main" class="site-main" role="main">
                <div class="layui-collapse">
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">文章列表</h2>
                        <div class="layui-colla-content layui-show">
                            <ul>
                                <c:forEach items="${articleList}" var="a">
                                    <li style="padding: 5px">
                                        <a href="/article/${a.articleCustom.articleId}" title="ajax实现form表单提交" target="_blank">${a.articleCustom.articleTitle}</a>
                                    </li>
                                </c:forEach>

                            </ul>
                        </div>
                    </div>
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">分类目录</h2>
                        <div class="layui-colla-content layui-show">
                            <ul>
                                <c:forEach items="${categoryList}" var="c">
                                    <c:if test="${c.categoryPid==0}">
                                        <li class="cat-item" style="padding: 5px">
                                            <a href="/category/${c.categoryId}">丨- ${c.categoryName}</a>
                                        </li>
                                        <ul class="children">
                                            <c:forEach items="${categoryList}" var="c2">
                                                <c:if test="${c2.categoryPid==c.categoryId}">
                                                    <li class="cat-item" style="padding: 5px 30px;">
                                                        <a href="/category/${c2.categoryId}" target="_blank">${c2.categoryName}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">标签库</h2>
                        <div class="layui-colla-content layui-show">
                            <c:forEach items="${tagCustomList}" var="t">
                                <a href="/tag/${t.tagId}" style="font-size: ${t.articleCount/4+14}px" title="${t.articleCount}个话题" target="_blank">${t.tagName}</a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </main>
        </section>
        <%--右边--%>
        <%@ include file="../Public/sidebar-1.jsp" %>
    </div>

    <div class="clear"></div>

    <%@ include file="../Public/footer.jsp"%>

</div>

<script src="/js/jquery.min.js"></script>
<script src="/js/superfish.js"></script>
<script src="/js/script.js"></script>
<script src="/plugin/layui/layui.all.js"></script>
<script>
    //注意：折叠面板 依赖 element 模块，否则无法进行功能性操作
    layui.use('element', function(){
        var element = layui.element;

        //…
    });
</script>

</body>
</html>



