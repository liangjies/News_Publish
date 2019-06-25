<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="WebApplication1.admin.WebForm3" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
</head>
<body>
<form class="layui-form" action="">
    <div class="layui-form-item">

        <div class="layui-input-block">
            <input type="checkbox" value="1" name="zzz" lay-skin="switch" lay-filter="switchTest" lay-text="开启|关闭">
        </div>
    </div>
    <script type="text/html" id="statusTpl">
    <input type="checkbox" lay-skin="switch" lay-text="启用|禁用" {{d.state == "1" ?"checked":"" }}>
  </script>

</form>
<script src="../layui/layui.js"></script>
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
<script>
    //Demo
    layui.use(['form','jquery','layer'], function () {
        var form = layui.form;
        var jquery = layui.jquery;
        var layer = layui.layer;

        //监听提交
        form.on('switch(switchTest)', function (data) {
            console.log(data.elem); //得到checkbox原始DOM对象
            console.log(data.elem.checked); //开关是否开启，true或者false
            console.log(data.value); //开关value值，也可以通过data.elem.value得到
            console.log(data.othis); //得到美化后的DOM对象
            var x=data.elem.checked;
            layer.open({
                content: '你确定是否修改导航栏状态？'
                ,btn: ['确定', '取消']
                ,yes: function(index, layero){
                    data.elem.checked=x;
                    form.render();
                    layer.close(index);
                    if (x) {
                        $.ajax({
                            url: "news_Del.aspx",
                            type: "POST",
                            data: { "uvid": "1", "on": "1" },
                            dataType: "json",
                            success: function (data) {
                                if (data.state == 1) {
                                    obj.del();
                                    layer.close(index);
                                    layer.msg("开启成功", { icon: 6 });
                                } else {
                                    layer.msg("开启失败", { icon: 5 });
                                }
                            }
                        });
                    } else {
                        $.ajax({
                            url: "news_Del.aspx",
                            type: "POST",
                            data: { "uvid": "1", "on": "0" },
                            dataType: "json",
                            success: function (data) {

                                if (data.state == 1) {
                                    obj.del();
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
                ,btn2: function(index, layero){
                    //按钮【按钮二】的回调
                    data.elem.checked=!x;
                    form.render();
                    layer.close(index);
                    //return false;
                }
                ,cancel: function(){
                    //右上角关闭回调
                    data.elem.checked=!x;
                    form.render();
                    //return false 开启该代码可禁止点击该按钮关闭
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
