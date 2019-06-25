<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="news_Column_Add.aspx.cs" Inherits="WebApplication1.admin.news_Column_Add" %>

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
                <li class="layui-nav-item"><a href="news_List.aspx">文章管理</a></li>
                <li class="layui-nav-item layui-this"><a href="news_Column.aspx">栏目管理</a></li>
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
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="news_Column.aspx">栏目列表</a>
                    </li>
                    <li class="layui-nav-item">
                        <a class="layui-this" href="news_Column_Add.aspx">添加栏目</a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="layui-body">
            <!-- 内容主体区域 -->
            <div style="padding: 15px;">
                <div class="content" style="text-align: center">
                <h1>添加栏目</h1>
           
                    <form id="form1" runat="server">
                        <div class="layui-form-item">
                            <label class="layui-form-label">栏目名称</label>
                            <div class="layui-input-block">
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="layui-input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox1" Text="所填写内容不能为空！" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">链接</label>
                            <div class="layui-input-block">
                                <asp:TextBox ID="TextBox2" runat="server" placeholder="例如：./Default.aspx"  CssClass="layui-input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox2" Text="所填写内容不能为空！" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">排序</label>
                            <div class="layui-input-block">   
                                <asp:TextBox ID="TextBox3" runat="server"  placeholder="数字越大越前" CssClass="layui-input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox3" Text="所填写内容不能为空！" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>


                        
                            &nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Text="添加" CssClass="layui-btn" OnClick="Button1_Click" />
                            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" Text="清空" CssClass="layui-btn layui-btn-danger" OnClick="Button2_Click" />
               </form>
                </div>
            </div>
        </div>
  
  <div class="layui-footer">
      <!-- 底部固定区域 -->
      © 2019
  </div>
    </div>


    <script>
        //一般直接写在一个js文件中
        layui.use(['element'], function () {
            var element = layui.element

        });
    </script>
</body>
</html>


