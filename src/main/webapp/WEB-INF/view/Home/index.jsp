<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/myTag.tld" prefix="lyz" %>
<%--
    主页面
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

</head>

<body>
<div id="page" class="site" style="transform: none;">

    <%--头部--%>
    <%@ include file="Public/header.jsp" %>
    <nav class="breadcrumb">
        <div class="bull"><i class="fa fa-volume-up"></i></div>
        <div id="scrolldiv">
            <div class="scrolltext">
                <ul style="margin-top: 0px;">
                    <c:forEach items="${noticeCustomList}" var="n">
                        <li class="scrolltext-title">
                            <a href="/notice/${n.noticeId}" rel="bookmark">${n.noticeTitle}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </nav>

    <%--内容--%>
    <div id="content" class="site-content" style="transform: none;">

        <%--左侧--%>
        <div id="primary" class="content-area">

            <%-- 轮播--%>
            <c:if test="${articleListVoList[0].page.pageNow==1}">
                <div style="margin-bottom: 10px">
                    <div class="layui-carousel" id="banner">
                        <div carousel-item>
                            <c:forEach items="${mostCommentArticleList}" var="item">
                                <a href="/article/${item.articleId}"
                                   style="position: relative; width: 100%; height: 240px;">
                                    <img src="/img/thumbnail/random/img_${item.articleId%400}.jpg" width="100%"
                                         height="240px"
                                         alt="">
                                    <span style="position: absolute;bottom: 50px; left: -1px;background: #398898;color: #fff;
                                            padding: 0 12px;display: block;border-radius: 2px 0 0 2px;">
                                            ${item.articleTitle}
                                    </span>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
            <%--博文--%>
            <main id="main" class="site-main" role="main">
                <%--列表--%>
                <c:forEach items="${articleListVoList}" var="a">
                    <article class="post type-post">

                        <figure class="thumbnail">
                            <a href="/article/${a.articleCustom.articleId}">
                                <img width="280" height="210"
                                     src="/img/thumbnail/random/img_${a.articleCustom.articleId%400}.jpg"
                                     class="attachment-content size-content wp-post-image"
                                     alt="${a.articleCustom.articleTitle}">
                            </a>
                            <span class="cat">
                                <a href="/category/${a.categoryCustomList[a.categoryCustomList.size()-1].categoryId}">
                                        ${a.categoryCustomList[a.categoryCustomList.size()-1].categoryName}
                                </a>
                            </span>
                        </figure>

                        <header class="entry-header">
                            <h2 class="entry-title">
                                <a href="/article/${a.articleCustom.articleId}"
                                   rel="bookmark">
                                        ${a.articleCustom.articleTitle}
                                </a>
                            </h2>
                        </header>

                        <div class="entry-content">
                            <div class="archive-content">
                                <lyz:htmlFilter>${a.articleCustom.articleContent}</lyz:htmlFilter>......
                            </div>
                            <span class="title-l"></span>
                            <span class="new-icon">
                                    <c:choose>
                                        <c:when test="${a.articleCustom.articleStatus==2}">
                                            <i class="fa fa-bookmark-o"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <jsp:useBean id="nowDate" class="java.util.Date"/>
                                            <c:set var="interval"
                                                   value="${nowDate.time - a.articleCustom.articlePostTime.time}"/><%--时间差毫秒数--%>
                                            <fmt:formatNumber value="${interval/1000/60/60/24}" pattern="#0"
                                                              var="days"/>
                                            <c:if test="${days <= 7}">NEW</c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            <span class="entry-meta">
                                    <span class="date">
                                        <fmt:formatDate value="${a.articleCustom.articlePostTime}"
                                                        pattern="yyyy年MM月dd日"/>
                                    &nbsp;&nbsp;
                                    </span>
                                    <span class="views">
                                        <i class="fa fa-eye"></i>
                                            ${a.articleCustom.articleViewCount} views
                                    </span>
                                    <span class="comment">&nbsp;&nbsp;
                                        <a href="/article/${a.articleCustom.articleId}#comments"
                                           rel="external nofollow">
                                          <i class="fa fa-comment-o"></i>
                                            <c:choose>
                                                <c:when test="${a.articleCustom.articleCommentCount==0}">
                                                    发表评论
                                                </c:when>
                                                <c:otherwise>
                                                    ${a.articleCustom.articleCommentCount}
                                                </c:otherwise>
                                            </c:choose>

                                        </a>
                                    </span>
                                </span>
                            <div class="clear"></div>
                        </div><!-- .entry-content -->

                        <span class="entry-more">
                                <a href="/article/${a.articleCustom.articleId}"
                                   rel="bookmark">
                                    阅读全文
                                </a>
                            </span>
                    </article>
                </c:forEach>
            </main>
            <%--页码--%>
            <c:if test="${articleListVoList[0].page.totalPageCount>1}">
                <nav class="navigation pagination" role="navigation">
                    <div class="nav-links">
                        <c:choose>
                            <c:when test="${articleListVoList[0].page.totalPageCount <= 3 }">
                                <c:set var="begin" value="1"/>
                                <c:set var="end" value="${articleListVoList[0].page.totalPageCount }"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="begin" value="${articleListVoList[0].page.pageNow-1 }"/>
                                <c:set var="end" value="${articleListVoList[0].page.pageNow + 2}"/>
                                <c:if test="${begin < 2 }">
                                    <c:set var="begin" value="1"/>
                                    <c:set var="end" value="3"/>
                                </c:if>
                                <c:if test="${end > articleListVoList[0].page.totalPageCount }">
                                    <c:set var="begin" value="${articleListVoList[0].page.totalPageCount-2 }"/>
                                    <c:set var="end" value="${articleListVoList[0].page.totalPageCount }"/>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                            <%--上一页 --%>
                        <c:choose>
                            <c:when test="${articleListVoList[0].page.pageNow eq 1 }">
                                <%--当前页为第一页，隐藏上一页按钮--%>
                            </c:when>
                            <c:otherwise>
                                <a class="page-numbers" href="/p/${articleListVoList[0].page.pageNow-1}">
                                    <span class="fa fa-angle-left"></span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                            <%--显示第一页的页码--%>
                        <c:if test="${begin >= 2 }">
                            <a class="page-numbers" href="/p/1">1</a>
                        </c:if>
                            <%--显示点点点--%>
                        <c:if test="${begin  > 2 }">
                            <span class="page-numbers dots">…</span>
                        </c:if>
                            <%--打印 页码--%>
                        <c:forEach begin="${begin }" end="${end }" var="i">
                            <c:choose>
                                <c:when test="${i eq articleListVoList[0].page.pageNow }">
                                    <a class="page-numbers current">${i}</a>
                                </c:when>
                                <c:otherwise>
                                    <a class="page-numbers" href="/p/${i}">${i }</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                            <%-- 显示点点点 --%>
                        <c:if test="${end < articleListVoList[0].page.totalPageCount-1 }">
                            <span class="page-numbers dots">…</span>
                        </c:if>
                            <%-- 显示最后一页的数字 --%>
                        <c:if test="${end < articleListVoList[0].page.totalPageCount }">
                            <a href="/p/${articleListVoList[0].page.totalPageCount}">
                                    ${articleListVoList[0].page.totalPageCount}
                            </a>
                        </c:if>
                            <%--下一页 --%>
                        <c:choose>
                            <c:when test="${articleListVoList[0].page.pageNow eq articleListVoList[0].page.totalPageCount }">
                                <%--到了尾页隐藏，下一页按钮--%>
                            </c:when>
                            <c:otherwise>
                                <a class="page-numbers" href="/p/${articleListVoList[0].page.pageNow+1}">
                                    <span class="fa fa-angle-right"></span>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </nav>
                <%--分页 end--%>
            </c:if>
        </div>

        <%--右侧--%>
        <%@ include file="Public/sidebar-2.jsp" %>
    </div>
    <div class="clear"></div>

    <%--友情链接 satrt--%>
    <div class="links-box">
        <div id="links">
            <c:forEach items="${linkCustomList}" var="l">
                <ul class="lx7">
                    <li class="link-f link-name">
                        <a href="${l.linkUrl}" target="_blank">
                                ${l.linkName}
                        </a>
                    </li>
                </ul>
            </c:forEach>
            <div class="clear"></div>
        </div>
    </div>
    <%--友情链接 end--%>

    <%--底部--%>
    <%@ include file="Public/footer.jsp" %>

</div>

<script src="/js/jquery.min.js"></script>
<script src="/js/superfish.js"></script>
<script src="/js/script.js"></script>
<script src="/plugin/layui/layui.all.js"></script>
<script src="/plugin/layui/layui.all.js"></script>
<script>
    layui.use('carousel', function () {
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#banner',
            width: '100%', //设置容器宽度
            height: '240px',
            arrow: 'always', //始终显示箭头
        });
    });
</script>

</body>
