<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>JSP - Hello World</title>
    <link rel="icon" href="logo.png">
    <link href="./layui/css/layui.css" rel="stylesheet" type="text/css">
    <script src="./layui/layui.js" type="text/javascript"></script>
    <script src="jquery-3.6.4.js" type="text/javascript"></script>
    <script src="sliderVerify.js" type="text/javascript"></script>
    <style>
        .demo-reg-container {
            width: 320px;
            margin: 21px auto 0;
        }

        .demo-reg-other .layui-icon {
            position: relative;
            display: inline-block;
            margin: 0 2px;
            top: 2px;
            font-size: 26px;
        }

        body {
            background-color: #ecefff;
            user-select: none; /* 这样用户点按钮的时候就不会选中文字, 更有沉浸感 */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .login-app {
            width: 348px;
            margin-bottom: 60px;
        }

        .login-header {
            display: flex;
        }

        .login-header input[type="radio"] {
            display: none;
        }

        .login-header label {
            background-color: #f5f5f6;
            font-size: 18px;
            color: rgba(37, 38, 43, .36);
            padding: 16px;
            text-align: center;
            width: 100%;
            /* 这里并不是非得100%,利用的是flex的自动收缩,只要大于1/3就好了 */

            cursor: pointer;
        }

        .login-header .m-btn {
            border-top-left-radius: 12px;
        }

        .login-header .u-btn {
            border-top-right-radius: 12px;
        }

        #message:checked + .m-btn,
        #username:checked + .u-btn {
            background-color: #fff;
            color: #25262b;
            cursor: default;
        }


        .login-body {
            overflow: hidden;
            border-radius: 0 0 20px 20px;
            background-color: #fff;
            -webkit-border-radius: 0 0 20px 20px;
            -moz-border-radius: 0 0 20px 20px;
            -ms-border-radius: 0 0 20px 20px;
            -o-border-radius: 0 0 20px 20px;
        }

        #form-bar {
            display: flex;
            transition: transform .6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            -webkit-transition: transform .6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            -moz-transition: transform .6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            -ms-transition: transform .6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            -o-transition: transform .6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .login-body form {
            flex-shrink: 0;
            width: 100%;
            box-sizing: border-box;
            padding: 22px;
            position: relative;
        }

        .login-body input {
            outline: none;
            width: 100%;
            box-sizing: border-box;
            /*height: 46px;*/
            margin-bottom: 16px;
            background-color: rgba(39, 39, 41, .04);
            border: 1px solid transparent;
            border-radius: 8px;
            -webkit-border-radius: 8px;
            -moz-border-radius: 8px;
            -ms-border-radius: 8px;
            -o-border-radius: 8px;
            font-size: 14px;
            padding: 1px 12px;
            color: #25262b;
        }

        .login-body input::placeholder {
            color: rgba(37, 38, 43, .36);
        }

        .login-body input:focus {
            border: 1px solid rgba(99, 125, 255, .48);
            background-color: #fff;
        }

        .login-body .login-btn {
            width: 100%;
            height: 48px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(
                    129.12deg, /* 沿着这个角度的线渐变 */ #446dff, /* 渐变起始颜色 */ rgba(99, 125, 255, .75) /* 渐变终点颜色 */
            );
            color: #fff;
            font-size: 16px;
            margin-top: 16px;
            margin-bottom: 60px;
        }

        button {
            cursor: pointer;
        }

        #sure:not(:checked) ~ .login-btn {
            opacity: .5;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<div class="login-app">
    <!-- 选择登录方式部分 -->
    <div class="login-header" onclick="checkRadio()">
        <input checked="checked" id="message" name="login-opt" type="radio">
        <label class="m-btn" for="message">用户登录</label>
        <input id="username" name="login-opt" type="radio">
        <label class="u-btn" for="username">用户注册</label>
    </div>
    <!-- 登录表单部分 -->
    <div class="login-body">
        <div id="form-bar">
            <!-- <form-append></form-append> -->
            <!-- 用户登录表单 -->
            <form action="#" class="m-form layui-form">
                <div class="layui-form-item">
                    <div class="layui-input-wrap">
                        <div class="layui-input-prefix layui-input-split">
                            <i class="layui-icon layui-icon-username"></i>
                        </div>
                        <input class="layui-input" lay-verify="my_phone" id="login_num" name="login_num"
                               placeholder="请填写手机号" type="tel">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-wrap">
                        <div class="layui-input-prefix layui-input-split">
                            <i class="layui-icon layui-icon-password"></i>
                        </div>
                        <input class="layui-input" lay-verify="required" lay-affix="eye" id="login_pwd" name="login_pwd"
                               placeholder="请填写密码"
                               type="password">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-btn-fluid">
                        <div id="slider"></div>
                    </div>
                </div>
                <div class="layui-form-item layui-row">
                    <button class="layui-btn  layui-btn-normal layui-btn-fluid layui-btn-radius" id="login_btn"
                            type="submit"
                            lay-filter="formDemo"
                            lay-submit
                            style="margin: 0 0 10px 0;background: linear-gradient(129.12deg,#446dff,rgba(99, 125, 255, .75));">
                        用户登录
                    </button>
                    <button class="layui-btn  layui-btn-normal layui-btn-fluid layui-btn-radius" id="reset_slider"
                            type="reset"
                            style="margin: 0 0 10px 0;background: linear-gradient(129.12deg,#446dff,rgba(99, 125, 255, .75));">
                        重置页面
                    </button>
                </div>
            </form>
            <!-- 用户注册表单 -->
            <form action="#" class="layui-form">

                <div class="demo-reg-container" style="margin: 0">
                    <div class="layui-form-item">
                        <div class="layui-row">
                            <div class="layui-input-wrap layui-col-xs7">
                                <div class="layui-input-prefix">
                                    <i class="layui-icon layui-icon-cellphone"></i>
                                </div>
                                <input autocomplete="off" class="layui-input" id="phoneNum" lay-reqtext="请填写手机号"
                                       lay-verify="my_phone"
                                       name="手机号" placeholder="手机号" style="margin: 0"
                                       type="text" value="">
                            </div>
                            <div class="layui-col-xs5">
                                <div style="margin-left: 12px;">
                                    <button class="layui-btn layui-btn-fluid layui-btn-normal layui-btn-radius"
                                            id="verCode"
                                            lay-on="reg-get-vercode"
                                            style="background: linear-gradient(129.12deg,#446dff,rgba(99, 125, 255, .75));"
                                            type="button">
                                        获取验证码
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-wrap">
                            <div class="layui-input-prefix">
                                <i class="layui-icon layui-icon-vercode"></i>
                            </div>
                            <input autocomplete="off" class="layui-input" lay-reqtext="请填写验证码"
                                   lay-verify="required" id="verifyNum" name="验证码"
                                   placeholder="验证码" type="text" value="">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-col-xs6">
                            <div class="layui-input-wrap">
                                <div class="layui-input-prefix">
                                    <i class="layui-icon layui-icon-password"></i>
                                </div>
                                <input autocomplete="off" class="layui-input" style="margin: 0" id="pwd" lay-affix="eye"
                                       lay-verify="my_user_pwd"
                                       name="密码" placeholder="密码" type="password" value="">
                            </div>
                        </div>

                        <div class="layui-col-xs6">
                            <div class="layui-input-wrap">
                                <div class="layui-input-prefix">
                                    <i class="layui-icon layui-icon-password"></i>
                                </div>
                                <input autocomplete="off" class="layui-input" style="margin: 0" lay-affix="eye"
                                       lay-verify="confirmPwd"
                                       name="confirmPwd" placeholder="确认密码" type="password" value="">
                            </div>
                        </div>

                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-wrap">
                            <div class="layui-input-prefix">
                                <i class="layui-icon layui-icon-username"></i>
                            </div>
                            <input autocomplete="off" class="layui-input" lay-affix="clear" lay-verify="required"
                                   name="学号" id="stuNum" placeholder="请输入学号" type="text" value="">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <button class="layui-btn login-btn layui-btn-fluid" lay-filter="demo-reg" lay-submit
                                style="margin: 0">注册
                        </button>
                    </div>
                </div>
            </form>

            <!-- <form-append></form-append> -->
        </div>
    </div>
</div>
<!--登录按钮使用的JS-->
<script>
    //一般直接写在一个js文件中
    layui.config({
        base: './sliderVerify/'
    }).use(['sliderVerify', 'jquery', 'form'], function () {
        let sliderVerify = layui.sliderVerify,
            form = layui.form;
        let slider = sliderVerify.render({
            elem: '#slider',
            bg: 'layui-bg-blue',
            onOk: function () {//当验证通过回调
                layer.msg("滑块验证通过");
            }
        });
        //重置滑块
        $('#reset_slider').click(function () {
            slider.reset();
        });
        //监听提交
        form.on('submit(formDemo)', function (data) {
            let login_pwd = $('#login_pwd').val();
            let login_num = $('#login_num').val();
            if (slider.isOk()) {//用于表单验证是否已经滑动成功
                // let field = data.field; // 获取表单字段值
                // 显示填写结果，仅作演示用
                // layer.msg(JSON.stringify(field));
                $.ajax({
                    url: 'loginServlet',
                    type: 'post',
                    async: true,
                    data: {
                        usr: login_num,
                        pwd: login_pwd,
                    },
                    success: function (data) {
                        let res = JSON.stringify(data);
                        if (res === "\"true\"") {
                            layer.msg("欢迎" + login_num + "登录", {icon: 1});
                            setTimeout(function () {
                                // window.location.href = 'user.jsp?usr='+login_num;
                                window.location.href = 'user.jsp';
                            }, 1000);

                        } else if (res == "\"请勿重复登录\"") {
                            layer.msg("请勿重复登录，跳转中！", {icon: 2, time: 2000}, function () {
                                // window.location.href = 'user.jsp?usr='+login_num;
                                window.location.href = 'user.jsp';
                            });
                        } else {
                            layer.msg(res, {icon: 2});
                        }
                    },
                    error: function (data) {
                        let res = JSON.stringify(data);
                        layer.alert('服务器异常' + res, {icon: 2});
                    }
                });
                // slider.reset(); // 重置滑块位置

            } else {
                layer.msg("请先通过滑块验证");
            }
            return false;
        });
    });
</script>

<!--注册页面使用的JS-->
<script>
    window.VerifyCode = '1234';
    layui.use(function () {
        let form = layui.form;
        let layer = layui.layer;
        let util = layui.util;

        //自定义验证规则
        form.verify({
            my_user_pwd: [
                /^(?!^(\d+|[a-z]+|[A-Z]+)$)[\da-zA-Z]{8,16}$/
                , '密码必须8到16位，只能包含字母和数字。'
            ],
            my_phone: [
                /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/
                , '请输入正确的手机号。'
            ],
            confirmPwd: function (value) {
                let passwordValue = $('#pwd').val();
                if (value !== passwordValue) {
                    return '两次密码输入不一致';
                }
            }
        });
        // 提交事件
        form.on('submit(demo-reg)', function (data) {
            // let field = data.field; // 获取表单字段值
            // 显示填写结果，仅作演示用
            // layer.alert(JSON.stringify(field), {
            //     title: '当前填写的字段值'
            // });

            // 此处可执行 Ajax 等操作
            // 调用后端，把注册的信息给后端，传入手机号和密码。
            let usrPhone = $('#phoneNum').val();
            let regPwd = $('#pwd').val();
            let usrNum = $('#stuNum').val();
            let verifyNum = "\"" + $('#verifyNum').val() + "\"";
            if (verifyNum != window.VerifyCode) {
                layer.msg("验证码错误", {icon: 2});
                return false;
            }
            $.ajax({
                url: 'regServlet',
                type: 'post',
                async: true,
                data: {
                    usr: usrPhone,
                    pwd: regPwd,
                    stuNum: usrNum
                },
                success: function (data) {
                    let res = JSON.stringify(data);
                    if (res === "\"true\"") {
                        layer.msg("欢迎" + usrPhone + "加入我们", {icon: 1});
                        setTimeout(function () {
                            window.location.href = 'index.jsp';
                        }, 1000);

                    } else {
                        layer.msg(res, {icon: 2});
                    }
                },
                error: function (data) {
                    let res = JSON.stringify(data);
                    layer.alert('服务器异常' + res, {icon: 2});
                }
            });

            return false; // 阻止默认 form 跳转
        });

        // 获取验证码
        $('#verCode').on('click', function () {
            let usrPhone = $('#phoneNum').val();
            let isValid = form.validate('#phoneNum');  // 主动触发验证，v2.7.0 新增
            // 验证通过
            if (isValid) {
                // 此处可继续书写「发送验证码」等后续逻辑
                // …
                $.ajax({
                    url: 'SendSms',
                    type: 'post',
                    async: true,
                    data: {
                        usr: usrPhone,
                    },
                    success: function (data) {
                        let res = JSON.stringify(data);
                        layer.msg(res + "\<br\>" + "验证码发送成功");
                        layer.msg("验证码发送成功" + "\<br\>" + "1分钟后才可获取下次验证码");
                        window.VerifyCode = res;
                    },
                    error: function (data) {
                        let res = JSON.stringify(data);
                        layer.alert('服务器异常' + res, {icon: 2});
                    }
                });
            }
            /*按钮禁用60秒,并显示倒计时*/
            $("#verCode").attr({"disabled": "disabled"}).addClass("layui-btn-disabled");     //控制按钮为禁用
            let second = 3;
            let intervalObj = setInterval(function () {
                $("#verCode").text("重新操作" + "(" + second + ")");
                if (second == 0) {
                    $("#verCode").text("获取验证码");
                    $("#verCode").removeAttr("disabled").removeClass("layui-btn-disabled");//将按钮可用
                    /* 清除已设置的setInterval对象 */
                    clearInterval(intervalObj);
                }
                second--;
            }, 1000);
        });
        form.on('submit(demo1)', function (data) {
            layer.msg(JSON.stringify(data.field));
            return false;
        });
    });
</script>
<!-- 前端显示效果使用的JS -->
<script>
    let login_opt = document.getElementsByName('login-opt');
    let form_bar = document.getElementById('form-bar');

    function checkRadio() {
        for (let i = 0; i < login_opt.length; i++) {
            if (login_opt[i].checked) {
                form_bar.style.transform = 'translateX(' + (-348 * i) + 'px)';
            }
        }
    }
</script>
</body>
</html>
