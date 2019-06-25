<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.admin.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
                <a href="news_Add.aspx">添加文章</a>
            </li>
        </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">欢迎登陆，<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></div>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 2019
  </div>
</div>

    <script src="../layui/layui.js"></script>
<script>
//一般直接写在一个js文件中
layui.use(['element'], function(){
  var element = layui.element
  
});
</script>
</body>
</html>
