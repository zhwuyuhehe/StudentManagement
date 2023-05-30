package com.zhwuyuhehe.jsp_exam;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

@WebServlet(name = "delMany", value = "/delMany")
public class delMany extends HttpServlet {
    public void doPost(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        String usr = request.getParameter("Phone");
        usr = usr.substring(1, usr.length() - 1);
        String[] usrArr = usr.split(",");
        String flag = "true";
        for (String s : usrArr) {
            s = s.substring(1, s.length() - 1);
            if (!MyRedis.DelUsr(s).equals("true")) {
                flag = "false";
            }
        }
        response.getWriter().write(flag);
    }
}
