<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Mshow.aspx.cs" Inherits="WebApplication1.Mshow" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    
     <div class="container-wrap">
        <div class="container">
                <div class="layui-fluid">
                    <div class="layui-row">
                        <div class="layui-row layui-col-space20">
                            <div class="layui-col-sm12">
                                <div class="layui-card">
                                    <div class="layui-card-header">        
                                    </div>
                                    <div class="layui-card-body">
                                        <div style="text-align:center;font-size:30px;font-weight:bold ">
                                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                            </div>
                                        <div style="text-align:center;font-size:15px;">
                                            <p>
                                                <span>
                                                    <i class="layui-icon layui-icon-username"></i>
                                                    <a><asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></a>
                                                </span>
                                                <span>
                                                    <i class="layui-icon layui-icon-log"></i>
                                                    <a><asp:Label ID="Label3" runat="server" Text="Label"></asp:Label></a>
                                                </span>
                                            </p>
                                        </div>
      <br />
                                        <div class="item">
                                            <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                                                                                    
                                        </div>
                                            
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>




</asp:Content>
