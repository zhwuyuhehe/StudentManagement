package com.zhwuyuhehe.jsp_exam;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

@WebServlet(name = "searchServlet", value = "/searchServlet")
public class searchServlet extends HttpServlet {
    public void doPost(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        String usr = request.getParameter("usrVal");
        int count = 0;
        StringBuilder res = MyRedis.SearchUsr(usr);
        String tmp = String.valueOf(res);
        if (tmp.contains(":")) {//在redis中，每个键值对都有一个冒号，所以可以通过冒号的个数来判断有多少个键值对
            count = tmp.length() - tmp.replace(":", "").length();
        }
//        System.out.println("{\"status\":200,\"message\":\"解析成功\",\"total\":"+count/4+",\"rows\":{"+"\"item\":["+res+"]}}");
        response.getWriter().write("{\"status\":200,\"message\":\"解析成功\",\"total\":" + count / 4 + ",\"rows\":{" + "\"item\":[" + res + "]}}");
    }
}
