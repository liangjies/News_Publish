<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="container-wrap">
        <div class="container">
                <div class="layui-fluid">
                    <div class="layui-row">
                        <div class="layui-row layui-col-space20">
                            <div class="layui-col-sm8">
                                <div class="layui-card">
                                    <div class="layui-card-header">
                                        最近更新         
                                    </div>
                                    <div class="layui-card-body">

                                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                        
                                        <!--
                                        <div class="item">
                                            <div class="item-box  layer-photos-demo1 layer-photos-demo">
                                                <h3><a href="details.html">拥有诗意的心态,才能拥有诗意的生活</a></h3>
                                                <h5>发布于：<span>刚刚</span></h5>
                                            </div>                                        
                                        </div>
                                        !-->
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-sm4">
                                <div class="layui-card">
                                    <div class="layui-card-header">随机推荐</div>
                                    <div class="layui-card-body">
                                        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                                         <!--
                                        <div class="item">
                                            <div class="item-box  layer-photos-demo1 layer-photos-demo" style="font-size:12px">
                                                <p><a href="details.html">拥有诗意的心态,才能拥有诗意的生活</a></p>
                                            </div>
                                        </div>
                                         !-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <div class="item-btn">
                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                <!--
                <button class="layui-btn layui-btn-normal">上一页</button>
                <button class="layui-btn layui-btn-normal">下一页</button>
                !-->
            </div>
            </div>
        </div>
    					
</asp:Content>
