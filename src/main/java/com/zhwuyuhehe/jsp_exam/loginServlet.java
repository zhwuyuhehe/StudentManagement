package com.zhwuyuhehe.jsp_exam;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/loginServlet")
public class loginServlet extends HttpServlet {
    public void doPost(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String pwd = request.getParameter("pwd");
        String usr = request.getParameter("usr");
        //调用MyRedis的LoginUsr方法，验证用户信息
        String res = MyRedis.LoginUsr(usr, pwd);
        String isRoot = MyRedis.isRoot(usr);
        String stuNum = MyRedis.paramUsrId(usr);
        //将用户信息存入usrinfo中
        usrinfo.setphone(usr);
        usrinfo.setpwd(pwd);
        usrinfo.setisroot(isRoot);
        usrinfo.setusrid(stuNum);

        if (session.isNew() || session.getAttribute("key") == null) {
            if (res.equals("true")) {
                session.setAttribute("key", usr);
//                session.setAttribute("isRoot",isRoot);
                response.getWriter().write("true");
            } else {
                session.invalidate();
                response.getWriter().write(res);
            }
        } else {
            response.getWriter().write("请勿重复登录");
        }
    }
}

//key为用户名:root pwd字段为密码:root;其他字段可以再添加例如num学号字段:20050101001;
//key 用户名，存的手机号，不显示key；pwd 密码； id 存的学号，显示昵称；isRoot 是否为管理员；
// Phone 存的手机号，显示手机号，不可重复，值和key一样，可以索引自己的key