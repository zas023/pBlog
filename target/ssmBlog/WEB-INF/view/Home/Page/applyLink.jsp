<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--
    申请友链
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
    <meta name="description" content="${options.optionMetaDescrption}"/>
    <meta name="keywords" content="${options.optionMetaKeyword}"/>
    <title>${options.optionSiteTitle}-${options.optionSiteDescrption}</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/plugin/font-awesome/css/font-awesome.min.css">
    <style>
        .entry-title {
            background: #f8f8f8;
        }
    </style>
    <link rel="stylesheet" href="/plugin/layui/css/layui.css">
</head>
<body>
<div id="page" class="site" style="transform: none;">
    <%--头部--%>
    <%@ include file="../Public/header.jsp" %>
    <%--面包屑导航 start--%>
    <nav class="breadcrumb">
        <a class="crumbs" href="/">
            <i class="fa fa-home"></i>首页
        </a>
        <i class="fa fa-angle-right"></i>
        申请友链
        <i class="fa fa-angle-right"></i>
        正文
    </nav>
    <%--面包屑导航 end--%>

    <div id="content" class="site-content" style="transform: none;">
        <%--博客主体-左侧文章正文 start--%>
        <div id="primary" class="content-area">
            <main id="main" class="site-main" role="main">
                <article class="post" style="min-height: 500px;">
                    <header class="entry-header">
                        <h1 class="entry-title">
                            申请友链
                        </h1>
                    </header><!-- .entry-header -->
                    <div class="entry-content">
                        <div class="single-content">
                            <form class="layui-form layui-form-pane" id="applyLinkForm" method="post">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">网站名称</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="linkName" placeholder="如：${options.optionSiteTitle}"
                                               class="layui-input" required>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">网站地址</label>
                                    <div class="layui-input-block">
                                        <input type="url" name="linkUrl" placeholder="如：" class="layui-input" required>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">网站描述</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="linkDescription"
                                               placeholder="如：${options.optionSiteDescrption}" class="layui-input"
                                               required>
                                    </div>
                                </div>

                                <div class="layui-form-item layui-form-text">
                                    <label class="layui-form-label">备注</label>
                                    <div class="layui-input-block">
                                        <textarea placeholder="申请原因和联系方式" class="layui-textarea" name="linkOwnerContact"
                                                  maxlength="100"></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <button class="layui-btn" lay-submit="">提交申请</button>
                                </div>
                            </form>


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