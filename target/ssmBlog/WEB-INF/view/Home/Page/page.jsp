<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

    <meta name="description" content="${options.optionMetaDescrption}"/>
    <meta name="keywords" content="${options.optionMetaKeyword}"/>
    <title>${options.optionSiteTitle}-${options.optionSiteDescrption}</title>

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
        <i class="fa fa-angle-right">
            ${pageCustom.pageTitle}
        </i>

        <i class="fa fa-angle-right"></i>
        正文
    </nav>
    <%--面包屑导航 end--%>

    <div id="content" class="site-content" style="transform: none;">
        <%--博客主体-左侧文章正文 start--%>
        <div id="primary" class="content-area">
            <main id="main" class="site-main" role="main">
                <article class="post">
                    <header class="entry-header">
                        <h1 class="entry-title">
                            ${pageCustom.pageTitle}
                        </h1>
                    </header><!-- .entry-header -->
                    <div class="entry-content" style="min-height:400px;">
                        <div class="single-content">
                            ${pageCustom.pageContent}
                        </div>

                        <br><br>

                        <footer class="single-footer">
                            <ul class="single-meta">
                                <li class="r-hide">
                                    <a href="javascript:pr()" title="侧边栏">
                                        <i class="fa fa-caret-left"></i>
                                        <i class="fa fa-caret-right"></i>
                                    </a>
                                </li>
                            </ul>
                            <ul id="fontsize">
                                <li>A+</li>
                            </ul>
                            <div class="single-cat-tag">
                                <div class="single-cat">日期：<fmt:formatDate value="${pageCustom.pageCreateTime}"
                                                                           pattern="yyyy年MM月dd日"/>
                                </div>
                            </div>
                        </footer><!-- .entry-footer -->


                        <div class="clear"></div>
                    </div><!-- .entry-content -->
                </article><!-- #post -->


            </main>
            <!-- .site-main -->
        </div>
        <%--博客主体-左侧文章正文end--%>
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