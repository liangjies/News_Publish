﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="news_Edit.aspx.cs" Inherits="WebApplication1.admin.news_Edit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="../layui/css/layui.css" />
    <title>后台管理</title>
</head>

<body class="layui-layout-body">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <div class="layui-logo">后台管理</div>
            <!-- 头部区域（可配合layui已有的水平导航） -->
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item layui-this"><a href="news_List.aspx">文章管理</a></li>
                <li class="layui-nav-item"><a href="news_Column.aspx">栏目管理</a></li>
                <li class="layui-nav-item"><a href="news_User.aspx">用户管理</a></li>
            </ul>
            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <img src="http://t.cn/RCzsdCq" class="layui-nav-img" />
                        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="news_Password.aspx">安全设置</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="logout.aspx">退出</a></li>
            </ul>
        </div>

        <div class="layui-side layui-bg-black">
            <div class="layui-side-scroll">
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree" lay-filter="test">
                    <li class="layui-nav-item">
                        <a href="news_List.aspx">文章列表</a>
                    </li>
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="news_Add.aspx">添加文章</a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="layui-body">
            <!-- 内容主体区域 -->
            <div style="padding: 15px;">
                <div class="content" style="text-align: center">
                    <h1>编辑文章</h1>
                    <form class="layui-form"  action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">标题</label>
                        <div class="layui-input-block">                          
                            <input type="text" id = "title" name="title" required lay-verify="required" value="" autocomplete="off" class="layui-input" />
                        </div>
                    </div>


                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                        <legend>内容</legend>
                    </fieldset>
                    <textarea class="layui-textarea" id="LAY_demo1" style="display: none"> </textarea>
                        </form>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <div class="layui-footer">
            <!-- 底部固定区域 -->
            © 2019
        </div>
    </div>

    <script src="../layui/layui.js"></script>
    <script>
        //一般直接写在一个js文件中
        layui.use(['layedit', 'form'], function () {
            var form = layui.form;
            var layedit = layui.layedit
                , $ = layui.jquery;

            //构建一个默认的编辑器
            var index = layedit.build('LAY_demo1');

            //编辑器外部操作
            var active = {
                content: function () {
                    //alert(layedit.getContent(index)); //获取编辑器内容
                    alert(data.field);
                }
                , text: function () {
                    alert(layedit.getText(index)); //获取编辑器纯文本内容
                }
                , selection: function () {
                    alert(layedit.getSelection(index));
                }
            };

            $('.site-demo-layedit').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
            
            function GetQueryString(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }
            $(function () {
                $.ajax({
                    url: "/api/newsAdd",
                    type: "GET",
                    data: { "id": GetQueryString("id") },
                    dataType: "json",
                    contentType: "application/json",
                    success: function (data) {
                        if (data[0].state == 1) {
                            document.getElementById("title").value = data[0].title;
                            layedit.setContent(index,data[0].content);
                        } else {
                            layer.msg("接口失败", { icon: 5 });
                        }
                    }
                });
            });
            //监听提交
            form.on('submit(formDemo)', function (data) {
                //layer.msg(JSON.stringify(data.field.city));
                //alert(layedit.getContent(index));
                var tdata = {
                    Label: 0,
                    Title: document.getElementById("title").value ,
                    Content: layedit.getContent(index),
                    Memthodname:GetQueryString("id")
                };
                $.ajax({
                    url: "/api/newsAdd",
                    type: "POST",
                    data: JSON.stringify(tdata),
                    dataType: "json",
                    contentType: "application/json",
                    success: function (data) {
                        if (data.state == 1) {
                            layer.msg("编辑成功", { icon: 6 });
                        } else {
                            layer.msg("编辑失败", { icon: 5 });
                        }
                    }
                });
                return false;
            });
        });
    </script>
</body>
</html>
