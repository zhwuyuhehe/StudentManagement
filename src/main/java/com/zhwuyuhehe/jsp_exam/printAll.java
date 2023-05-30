package com.zhwuyuhehe.jsp_exam;

import com.alibaba.fastjson2.JSONObject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;
import redis.clients.jedis.Jedis;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

@WebServlet(name = "printAll", value = "/printAll")
public class printAll extends HttpServlet {
    public void doPost(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        String usrKey = usrinfo.getphone();
        String isRoot = usrinfo.getisroot();
        int count = 0;
        Jedis conn = new Jedis("localhost", 6379);//链接数据库
        Set<String> keys = conn.keys("*");
        StringBuilder res = new StringBuilder();
//        System.out.println(keys);
        for (String key : keys) {
            count++;//计数器/累加器，统计返回用户的数量
            Map<String, String> tmp = conn.hgetAll(key);
            JSONObject jo = new JSONObject(tmp);
            if (isRoot.equals("false")) {
                if (!jo.get("Phone").equals(usrKey)) jo.put("pwd", "贵州魅魔：你能不能死啊");
            }
            res.append(jo).append(",");
        }
        res = new StringBuilder(res.substring(0, res.length() - 1));
//        System.out.println("{\"status\":200,\"message\":\"解析成功\",\"total\":"+count+",\"rows\":{"+"\"item\":["+res+"]}}");
        response.getWriter().write("{\"status\":200,\"message\":\"解析成功\",\"total\":" + count + ",\"rows\":{" + "\"item\":[" + res + "]}}");//模板给定的格式JSON
    }
}
