# StudentManagement
JavaWeb/JSP写的一个学生信息管理系统

#### 环境配置
Redis，Tomcat，Oracle_JDK。

#### 本项目构建时使用
Windows_Redis 3.0.504  |  Linux_Redis 3.2.12 @epel  
Tomcat 10.1.8  
Oracle_JDK 17  

#### 使用了阿里云短信服务发送验证码
在SendSMS.java文件中配置你的阿里云RAM账户，以及你的短信签名与模板，就可以正常发送验证码了。

#### 数据库使用说明
可以在Redis-CLI中添加用户数据  
例：
