<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebApplication1.admin.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="stylesheet" href="../layui/css/layui.css" />
   
    <title>栏目管理</title>
</head>

    <body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">后台管理</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="news_List.aspx">文章管理</a></li>
      <li class="layui-nav-item layui-this"><a href="news_Column.aspx">栏目管理</a></li>
      <li class="layui-nav-item"><a href="news_File">文件管理</a></li>
      <li class="layui-nav-item"><a href="news_User">用户管理</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="http://t.cn/RCzsdCq" class="layui-nav-img" />
          <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        </a>
        <dl class="layui-nav-child">
          <dd><a href="news_Password">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="logout.aspx">退出</a></li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree">
        <li class="layui-nav-item">
          <a class="layui-this" href="news_Column.aspx">栏目列表</a>
        </li>
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">
        <div class="demoTable">
    搜索文章：
    <div class="layui-inline">
        <input class="layui-input" name="keyword" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<table id="demo" lay-filter="test"></table>
    <table class="layui-hide" id="LAY_table_user" lay-filter="useruv"></table>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    
<script src="../layui/layui.js"></script>
<script>
    layui.use('table', function () {
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#LAY_table_user'
            ,id: 'testReload'
            , height: 400
            , url: 'news_Api.aspx' //数据接口
            , page: true //开启分页
            , cols: [[ //表头
                { field: 'id', title: 'ID', width: 80, sort: true, fixed: 'left' }
                , { field: 'name', title: '栏目名称', width: 200, sort: true }
                , { field: 'content', title: '排序', width: 200, sort: true }
                , { field: 'user', title: '状态', width: 80, toolbar: "#statusDemo"  }
                , { field: 'right', title: '操作', width: 177, toolbar: "#barDemo" }
            ]]
        });

        var $ = layui.$, active = {
            reload: function () {
                var demoReload = $('#demoReload');

                table.reload('testReload', {
                    where: {
                        keyword: demoReload.val()
                    }
                });
            }
        };

        //监听工具条
        table.on('tool(useruv)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                //layer.msg('ID：' + data.id + ' 的查看操作');
                window.open("../Mshow.aspx?id="+data.id);
            } else if(obj.event === 'del'){
                layer.confirm('真的要删除吗', function(index){
                    console.log(data);
                    $.ajax({
                        url: "news_Del.aspx",
                        type: "POST",
                        data:{"uvid":data.id,"memthodname":"deleteuv"},
                        dataType: "json",
                        success: function(data){

                            if(data.state==1){
                                obj.del();
                                layer.close(index);
                                layer.msg("删除成功", {icon: 6});
                            }else{
                                layer.msg("删除失败", {icon: 5});
                            }
                        }

                    });
                });
            } else if (obj.event === 'edit') {
                location.href="news_Edit.aspx?id="+data.id;
                /*
                layer.prompt({
                    formType: 2
                    ,title: '修改 ID 为 ['+ data.id +'] 的访问量'
                    ,value: data.uv
                }, function(value, index){
                    EidtUv(data,value,index,obj);               
                });
                layer.open({
                    type: 1
                    , offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                    , id: 'layerDemo' +  'auto' //防止重复弹出
                    , content: '<div style="padding: 20px 100px;">' + data.content + '</div>'
                    , btn: '关闭'
                    , btnAlign: 'c' //按钮居中
                    , shade: 0 //不显示遮罩
                    , yes: function () {
                        layer.closeAll();
                    }
                });*/
            }
        });
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
        
</script>
    </div>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 2019
  </div>
</div>


<script>
//一般直接写在一个js文件中
layui.use(['element'], function(){
  var element = layui.element
  
});
</script>
</body>
</html>

