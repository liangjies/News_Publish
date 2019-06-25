<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.admin.WebForm1" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>layui</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui//css/layui.css"  media="all">
  <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
    <form class="layui-form" action="">
            <div class="layui-form-item">
                        <label class="layui-form-label">标题</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" required lay-verify="required" value="请输入标题" autocomplete="off" class="layui-input" />
                        </div>
                    </div> 
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>完整功能（没错，目前工具栏只有这么多）</legend>
</fieldset>
 
<textarea class="layui-textarea" id="LAY_demo1" style="display: none">  
  把编辑器的初始内容放在这textarea即可
</textarea>
 
<div class="site-demo-button" style="margin-top: 20px;">
  <button class="layui-btn site-demo-layedit" data-type="content">获取编辑器内容</button>
  <button class="layui-btn site-demo-layedit" data-type="text">获取编辑器纯文本内容</button>
  <button class="layui-btn site-demo-layedit" data-type="selection">获取编辑器选中内容</button>
</div>         
          
<script src="../layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
layui.use('layedit', function(){
  var layedit = layui.layedit
  ,$ = layui.jquery;
  
  //构建一个默认的编辑器
  var index = layedit.build('LAY_demo1');
  
  //编辑器外部操作
  var active = {
    content: function(){
      alert(layedit.getContent(index)); //获取编辑器内容
    }
    ,text: function(){
      alert(layedit.getText(index)); //获取编辑器纯文本内容
    }
    ,selection: function(){
      alert(layedit.getSelection(index));
    }
  };
  
  $('.site-demo-layedit').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
  
});
</script>

</body>
</html>