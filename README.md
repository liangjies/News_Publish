# News_Publish
新言信息发布系统

# 1设计概述

新闻发布与管理系统包括新闻管理、栏目管理模块、用户管理模块。具体描述如下：

1．新闻发布管理：

(1)基本新闻信息的录入，包括新闻标题、新闻内容；

(2)基本新闻信息的修改；

(3)基本新闻信息的删除；

2．系统用户管理功能：

(1)系统用户信息的录入，包括用户名和密码等信息；

(2)系统用户信息的修改；

(3)系统用户信息的删除。

\3. 栏目管理模块：

(1)栏目信息的录入，包括栏目名称和链接等信息；

(2) 栏目信息的排序显示；

(3) 栏目信息的删除。

 

## 1.1目录结构

│  about.aspx      //关于页面

│  ColController.cs      //栏目列表 Web API 接口

│  ColOnController.cs      //栏目管理 Web API 接口

│  Default.aspx      //首页

│  DelController.cs      //删除文章 Web API 接口

│  favicon.ico   

│  login.aspx      //登录页面

│  message.aspx      //留言页面

│  Mshow.aspx      //查看文章页面

│  newsAddController.cs      //添加文章 Web API 接口

│  newsController.cs       //文章列表Web API 接口

│  Site1.Master      //首页母版

│  UserController.cs      //用户管理 Web API 接口

│

└─admin

​        Default.aspx      //后台欢迎页

​        logout.aspx      //退出登录

​        news_Add.aspx       //添加文章

​        news_Column.aspx       //栏目列表

​        news_Column_Add.aspx      //添加栏目

​        news_Edit.aspx      //文章编辑

​        news_List.aspx      //文章列表

​        news_Password.aspx      //更改密码

​        news_User.aspx      //用户管理

​        news_User_Add.aspx      //添加用户

 

├─css       //css目录

├─images      //图片目录

├─layui      // layui前端 UI 框架

└─Scripts      //Scripts目录

# 2系统详细设计

## 2.1系统主页

## 2.1.1首页

​     ![](https://cdn.icewx.com/github/News_Publish/image001.png)                                             

移动端自适应页面：

   ![](https://cdn.icewx.com/github/News_Publish/image002.png)       

## 2.1.2文章内容

![](https://cdn.icewx.com/github/News_Publish/image003.png)       

## 2.1.3留言页面
  ![](https://cdn.icewx.com/github/News_Publish/image004.png)       


## 2.2系统后台

## 2.2.1后台登录
  ![](https://cdn.icewx.com/github/News_Publish/image005.png)       


输入正确的用户名和密码即可登录成功
  ![](https://cdn.icewx.com/github/News_Publish/image006.png)       


## 2.2.2文章管理

## 文章列表
  ![](https://cdn.icewx.com/github/News_Publish/image007.png)       
​    

## 添加文章
  ![](https://cdn.icewx.com/github/News_Publish/image008.png)       






选择类型、输入标题和内容点击提交就能添加到数据库Message表中
  ![](https://cdn.icewx.com/github/News_Publish/image009.png)       


## 搜索文章
  ![](https://cdn.icewx.com/github/News_Publish/image010.png)       


## 编辑文章
![](https://cdn.icewx.com/github/News_Publish/image011.png)  


## 分页
![](https://cdn.icewx.com/github/News_Publish/image012.png)  

![](https://cdn.icewx.com/github/News_Publish/image013.png)  




## 2.2.3栏目管理

## 栏目列表
![](https://cdn.icewx.com/github/News_Publish/image014.png)  




## 添加栏目
![](https://cdn.icewx.com/github/News_Publish/image015.png)  
输入栏目名称链接、和排序点击提交就能添加栏目到数据库Column表中
![](https://cdn.icewx.com/github/News_Publish/image016.png)  


## 2.2.4用户管理

## 用户列表
![](https://cdn.icewx.com/github/News_Publish/image017.png)  




## 添加管理员
![](https://cdn.icewx.com/github/News_Publish/image019.png)  
输入账号和密码点击添加就能添加管理员到数据库User表中

 ![](https://cdn.icewx.com/github/News_Publish/image018.png)  

   

## 管理员密码修改
![](https://cdn.icewx.com/github/News_Publish/image020.png)  