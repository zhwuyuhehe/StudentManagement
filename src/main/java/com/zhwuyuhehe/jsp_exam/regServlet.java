package com.zhwuyuhehe.jsp_exam;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

@WebServlet(name = "regServlet", value = "/regServlet")
public class regServlet extends HttpServlet {
    public void doPost(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        String phoneNum = request.getParameter("usr");//手机号，唯一标识
        String pwd = request.getParameter("pwd");//密码
        String stuNum = request.getParameter("stuNum");//学号，当昵称用
        //isRoot默认为false
        response.getWriter().write(MyRedis.AddUsr(phoneNum, pwd, stuNum));//调用MyRedis的AddUsr方法，注册用户信息，返回结果
    }
}
