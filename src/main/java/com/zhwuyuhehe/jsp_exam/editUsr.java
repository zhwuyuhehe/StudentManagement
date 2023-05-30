package com.zhwuyuhehe.jsp_exam;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

@WebServlet(name = "editUsr", value = "/editUsr")
public class editUsr extends HttpServlet {
    public void doPost(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        String usr = request.getParameter("Phone");
        String pos = request.getParameter("pos");
        String val = request.getParameter("val");
        response.getWriter().write(MyRedis.editUsr(usr, pos, val));
    }
}
