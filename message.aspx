<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="message.aspx.cs" Inherits="WebApplication1.message" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-wrap">
        <div class="container">
            <div class="layui-fluid">
                <div class="layui-row">
                    <div class="layui-row layui-col-space20">
                        <div class="layui-col-sm12">
                            <img class="banner-img" src="../images/liuyan.jpg">
                            <div class="layui-form-item layui-form-text">
                                <div class="layui-input-block">
                                    <asp:TextBox ID="TextBox1" placeholder="既然来了，就说几句吧" class="layui-textarea" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block" style="text-align: right;">
                                    <asp:Button ID="Button1" runat="server" Text="确定" CssClass="layui-btn definite" OnClick="Button1_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
