<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication1.login" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录-管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="/layui/css/layui.css">
    <link rel="stylesheet" href="/css/login.css">
    <script>
        var TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC96bGtiLm5ldCIsImF1ZCI6IlJQQyIsImV4cCI6MTU1OTMxNjAwOX0.t1Qr8bY2jk_uvy6NAKY_1LxFC2mjh9-7VkksBwNRBGynKqbhdkSbJ1ScDYMBry9IsBdPNBT1N8h6YsDaXdqJol8CpUKnsA6TPbLpqhC1SW2bwcHhwfN2ZDwsZJERohbb_Zv36zPWXYXt4j88oR7mtnzKxm8cDLxoYULQqOM584s";
        var ADMIN_DIR = "Admin";
        if (self != top) {
            top.location = self.location;
        }
    </script>
</head>

<body>

    <!--登录背景-->
    <div class="video_mask">
        <img src="/images/bg7.jpg">
    </div>
    <div class="login">
        <h1>登录</h1>

        <form class="layui-form" id="form1" runat="server">
            <div class="layui-form-item">
                <asp:TextBox ID="TextBox1" placeholder="用户名" runat="server" CssClass="layui-input" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox1" Text="所填写内容不能为空！" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="layui-form-item">
                <asp:TextBox ID="TextBox2" placeholder="密码" runat="server" type="password" CssClass="layui-input"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox2" Text="所填写内容不能为空！" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <asp:Button ID="Button1" runat="server" Text="登录" CssClass="layui-btn login_btn" OnClick="Button1_Click" />
        </form>
    </div>
</body>

</html>
<script src="/layui/layui.js"></script>
<script>
    layui.config({
        version: "1.4.0",
        base: '/res/mods/'
    }).use('common');
    layui.use('element', function () {
        var element = layui.element;
    });
    layui.use('adminlogin');
</script>
