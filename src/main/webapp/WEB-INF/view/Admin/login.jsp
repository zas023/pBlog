<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<!--[if IE 8]>
<html xmlns="http://www.w3.org/1999/xhtml" class="ie8" lang="zh-CN">
<![endif]-->
<!--[if !(IE 8) ]><!-->
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<!--<![endif]-->
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>${options.optionSiteTitle} &lsaquo; 登录</title>
    <link rel="stylesheet" href="/plugin/layui/css/layui.css">
    <link rel="shortcut icon" href="/img/logo.png">
    <style>
        .main {
            margin: 0 auto;
            width: 400px;
            border: 1px solid;
            border-color: #eeeeee;
            border-radius: 5px;
            margin-top: 100px;
        }
    </style>

</head>

<body>
<div class="main layui-clear">
    <%
        String username = "";
        String password = "";
        //获取当前站点的所有Cookie
        Cookie[] cookies = request.getCookies();
        for (int i = 0; i < cookies.length; i++) {//对cookies中的数据进行遍历，找到用户名、密码的数据
            if ("username".equals(cookies[i].getName())) {
                username = cookies[i].getValue();
            } else if ("password".equals(cookies[i].getName())) {
                password = cookies[i].getValue();
            }
        }
    %>
    <div id="loginForm" name="loginForm">
        <div class="fly-panel fly-panel-user" pad20>
            <div class="layui-tab layui-tab-brief">

                <ul class="layui-tab-title">
                    <li class="layui-this">欢迎登录后台系统</li>
                </ul>

                <div class="layui-form layui-tab-content" style="padding-top: 20px; padding-left: 50px;  ">

                    <div class="layui-form layui-form-pane">

                        <div class="layui-form-item">
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" id="user_login" placeholder="用户名"
                                       autocomplete="off" class="layui-input" value="<%=username%>">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">密码</label>
                            <div class="layui-input-inline">
                                <input id="user_pass" type="password" name="password" placeholder="密码"
                                       autocomplete="off" class="layui-input" value="<%=password%>">
                            </div>
                        </div>

                        <%--<div class="layui-form-item">--%>
                            <%--<label class="layui-form-label">记住密码</label>--%>
                            <%--<div class="layui-input-block">--%>
                                <%--<input type="checkbox" name="switch" lay-skin="switch">--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <div class="layui-form-item" style="float: right; margin-right: 42px;">

                        <input type="checkbox" name="rememberme" checked value="1"
                        title="记住密码">

                        </div>

                        <div class="layui-form-item">
                            <button id="submit-btn" class="layui-btn btn-submit"
                                    style="width: 300px; border-radius:3px">
                                立即登录
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="clear"></div>

<script src="/js/jquery.min.js"></script>
<script src="/plugin/layui/layui.js"></script>
<script type="text/javascript">
    <%--登录验证--%>
    $(function () {
        $("#submit-btn").click(function () {
            var user = $("#user_login").val();
            var password = $("#user_pass").val();
            if (user == "") {
                alert("用户名不可为空!");
            } else if (password == "") {
                alert("密码不可为空!");
            } else {
                $.ajax({
                    async: false,//同步，待请求完毕后再执行后面的代码
                    type: "POST",
                    url: '/loginVerify',
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data: {username: user, password: password},
                    dataType: "json",
                    success: function (data) {
                        if (data.code == 0) {
                            alert(data.msg);
                        } else {
                            window.location.href = "/admin";
                        }
                    },
                    error: function () {
                        alert("数据获取失败")
                    }
                })
            }
        })
    });
</script>
<script type="text/javascript">
    layui.use('form', function () {
        var form = layui.form;
    });
</script>
</body>
</html>