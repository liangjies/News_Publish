<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="news_Column.aspx.cs" Inherits="WebApplication1.admin.news_Column" %>

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
                        <a class="layui-this" href="news_Column.aspx">栏目列表</a>
                    </li>
                    <li class="layui-nav-item">                    
                        <a class="" href="news_Column_Add.aspx">添加栏目</a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="layui-body">
            <!-- 内容主体区域 -->
            <div style="padding: 15px;">
                <a href="news_Column_Add.aspx" class="layui-btn">添加栏目</a>
            </div>
            <table id="demo" lay-filter="test"></table>
            <table class="layui-hide" id="LAY_table_user" lay-filter="useruv"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="up">上移</a>
                <a class="layui-btn layui-btn-xs" lay-event="down">下移</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>


            <script src="/layui/layui.js"></script>
            <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
            <script>
                layui.use(['table','form','jquery','layer'], function () {
                    var table = layui.table;
                    var form = layui.form;
                    var jquery = layui.jquery;
                    var layer = layui.layer;
                    var statusTpl = function (d) { // 参数d是当前行数据
                        //if else
                        if (d.state == 1) {
                            return '<input type="checkbox" lay-skin="switch" value="'+d.id+'" lay-filter="switchTest" lay-text="启用|禁用" checked> ';
                        } else {
                            return '<input type="checkbox" lay-skin="switch" value="'+d.id+'" lay-filter="switchTest"  lay-text="启用|禁用"> ';
                        }
                    };

                    //第一个实例
                    table.render({
                        elem: '#LAY_table_user'
                        , id: 'testReload'
                        , height: 400
                        , url: '/api/Col' //数据接口
                        , page: false //开启分页
                        , cols: [[ //表头
                            { field: 'id', title: 'ID', width: 80, sort: true, fixed: 'left' }
                            , { field: 'name', title: '栏目名称', width: 200, sort: true }
                            , { field: 'link', title: '链接', width: 200, sort: true }
                            , { field: 'order', title: '排序', width: 80 }
                            , { field: 'state', title: '状态', align: 'center', templet: statusTpl }
                            , { field: 'right', title: '操作', align: 'center', toolbar: "#barDemo" }
                        ]]
                    });


                    //监听工具条
                    table.on('tool(useruv)', function (obj) {
                        var data = obj.data;
                        if (obj.event === 'down') {
                            var tdata = {
                                Id: data.id,
                                Order: data.order,
                                Memthodname: "down"
                            };
                            $.ajax({
                                url: "/api/Col",
                                type: "POST",
                                data: JSON.stringify(tdata),
                                dataType: "json",
                                contentType: "application/json",
                                success: function (data) {
                                    table.reload('testReload');
                                    layer.msg("下移成功", { icon: 6 });
                                }

                            });
                        } else if (obj.event === 'del') {
                            layer.confirm('真的要删除吗', function (index) {
                                console.log(data);
                                var tdata = {
                                    Id: data.id,
                                    Memthodname: "C_delete"
                                };
                                $.ajax({
                                    url: "/api/Del",
                                    type: "POST",
                                    //data:{"Id":data.id,"Memthodname":"delete"},
                                    data: JSON.stringify(tdata),
                                    dataType: "json",
                                    contentType: "application/json",
                                    success: function (data) {
                                        if (data.state == 1) {
                                            obj.del();
                                            layer.close(index);
                                            layer.msg("删除成功", { icon: 6 });
                                        } else {
                                            layer.msg("删除失败", { icon: 5 });
                                        }
                                    }

                                });
                            });
                        } else if (obj.event === 'up') {
                            var tdata = {
                                Id: data.id,
                                Order: data.order,
                                Memthodname: "up"
                            };
                            $.ajax({
                                url: "/api/Col",
                                type: "POST",
                                //data:{"Id":data.id,"Memthodname":"delete"},
                                data: JSON.stringify(tdata),
                                dataType: "json",
                                contentType: "application/json",
                                success: function (data) {
                                    table.reload('testReload');
                                    layer.msg("上移成功", { icon: 6 });
                                }
                            });
                        }
                    });




                    //监听提交
                    
                    form.on('switch(switchTest)', function (data) {
                        var id = data.elem.value;
                        console.log(data.elem); //得到checkbox原始DOM对象
                        console.log(data.elem.checked); //开关是否开启，true或者false
                        console.log(data.value); //开关value值，也可以通过data.elem.value得到
                        console.log(data.othis); //得到美化后的DOM对象
                        var x = data.elem.checked;
                        layer.open({
                            content: '你确定是否修改导航栏状态？'
                            , btn: ['确定', '取消']
                            , yes: function (index, layero) {
                                data.elem.checked = x;
                                form.render();
                                layer.close(index);
                                if (x) {
                                    var tdata = {
                                        Id: id,
                                        On: 1,
                                    };
                                    $.ajax({
                                        url: "/api/ColOn",
                                        type: "POST",
                                        //data: { "id": "1", "on": "1" },
                                        data: JSON.stringify(tdata),
                                        dataType: "json",
                                        contentType: "application/json",
                                        success: function (data) {
                                            if (data.state == 1) {
                                                layer.close(index);
                                                layer.msg("开启成功", { icon: 6 });
                                            } else {
                                                layer.msg("开启失败", { icon: 5 });
                                            }
                                        }
                                    });
                                } else {
                                    var tdata = {
                                            Id: id,
                                            On: 0,
                                        };
                                    $.ajax({

                                        url: "/api/ColOn",
                                        type: "POST",
                                        //data: { "uvid": "1", "On": "0" },
                                        data: JSON.stringify(tdata),
                                        dataType: "json",
                                        contentType: "application/json",
                                        success: function (data) {
                                            if (data.state == 1) {
                                                layer.close(index);
                                                layer.msg("关闭成功", { icon: 6 });
                                            } else {
                                                layer.msg("关闭失败", { icon: 5 });
                                            }
                                        }
                                    });
                                }
                                //按钮【按钮一】的回调
                            }
                            , btn2: function (index, layero) {
                                //按钮【按钮二】的回调
                                data.elem.checked = !x;
                                form.render();
                                layer.close(index);
                                //return false;
                            }
                            , cancel: function () {
                                //右上角关闭回调
                                data.elem.checked = !x;
                                form.render();
                                //return false 开启该代码可禁止点击该按钮关闭
                            }
                        });
                        return false;
                    });
                });
                


                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
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
        layui.use(['element'], function () {
            var element = layui.element

        });
    </script>
</body>
</html>

