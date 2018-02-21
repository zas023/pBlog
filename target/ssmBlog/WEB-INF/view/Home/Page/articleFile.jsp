<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--
    文章归档
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
    <meta name="description" content="文章归档"/>
    <meta name="keywords" content="文章,归档"/>
    <title>文章归档--${options.optionSiteTitle}</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/plugin/font-awesome/css/font-awesome.min.css">

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
        文章归档
        <i class="fa fa-angle-right"></i>
        正文
    </nav>
    <%--面包屑导航 end--%>

    <div id="content" class="site-content" style="transform: none;">
        <%--博客主体-左侧正文 start--%>
        <section id="primary" class="content-area">
            <main id="main" class="site-main" role="main">
                <ul class="search-page">
                    <c:forEach items="${articleList}" var="a">
                        <li class="search-inf">
                            <fmt:formatDate value="${a.articleCustom.articlePostTime}" pattern="yyyy年MM月dd日"/>
                        </li>
                        <li class="entry-title">
                            <a href="/article/${a.articleCustom.articleId}">${a.articleCustom.articleTitle}</a>
                        </li>
                    </c:forEach>
                </ul>
            </main>
        </section>
        <%@ include file="../Public/sidebar-1.jsp" %>
    </div>
    <div class="clear"></div>

    <%@ include file="../Public/footer.jsp" %>

</div>

<script src="/js/jquery.min.js"></script>
<script src="/js/superfish.js"></script>
<script src="/js/script.js"></script>
<script src="/plugin/layui/layui.all.js"></script>

</body>
</html>