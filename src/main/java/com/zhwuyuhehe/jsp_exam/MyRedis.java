package com.zhwuyuhehe.jsp_exam;

import com.alibaba.fastjson2.JSONObject;
import org.jetbrains.annotations.NotNull;
import redis.clients.jedis.Jedis;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public interface MyRedis {//redis操作接口

    static @NotNull String LoginUsr(String name, String pwd) {//用户登录
        if (!connRedis.conn.exists(name)) {
            connRedis.conn.close();
            return "用户不存在";
        } else if (!connRedis.conn.hget(name, "pwd").equals(pwd)) {//密码错误
            connRedis.conn.close();
            return "密码错误";
        } else {
            connRedis.conn.close();
            return "true";
        }
    }

    static @NotNull String AddUsr(String name, String pwd, String stuNum) {//添加用户，注册用户。
        if (connRedis.conn.exists(name)) {
            connRedis.conn.close();
            return "用户已存在";
        } else {
            Map<String, String> usrMap = new HashMap<>();
            usrMap.put("id", stuNum);//学号
            usrMap.put("Phone", name);//用户名,即电话号码
            usrMap.put("pwd", pwd);//密码
            usrMap.put("isRoot", "false");//是否为管理员
            connRedis.conn.hmset(name, usrMap);//调用数据库添加用户
            connRedis.conn.close();
            return "true";
        }
    }

    static @NotNull String fileAddUsr(String name, String pwd, String stuNum, String isRoot) {//添加用户，注册用户。
        if (connRedis.conn.exists(name)) {
            connRedis.conn.close();
            return "用户已存在";
        } else {
            Map<String, String> usrMap = new HashMap<>();
            usrMap.put("id", stuNum);//学号
            usrMap.put("Phone", name);//用户名,即电话号码
            usrMap.put("pwd", pwd);//密码
            usrMap.put("isRoot", isRoot);//是否为管理员
            connRedis.conn.hmset(name, usrMap);//调用数据库添加用户
            connRedis.conn.close();
            return "true";
        }
    }

    static @NotNull String DelUsr(String name) {//删除用户
        if (!connRedis.conn.exists(name)) {
            connRedis.conn.close();
            return "用户不存在";
        } else {
            connRedis.conn.del(name);
            connRedis.conn.close();
            return "true";
        }
    }

    static @NotNull String editUsr(String name, String pos, String val) {//修改用户信息
        if (!connRedis.conn.exists(name)) {
            connRedis.conn.close();
            return "用户不存在";
        } else {
            Map<String, String> usrMap = new HashMap<>();
            usrMap.put(pos, val);//pos为要修改的信息，val为修改后的值
            connRedis.conn.hset(name, usrMap);//调用数据库修改用户信息
            connRedis.conn.close();
            return "true";
        }
    }

    static @NotNull StringBuilder SearchUsr(String name) {//查询用户信息，并输出。
        /*
        Map 是一种键值对的映射表，它将一个键（key）映射到一个值（value）。Map 中的键是唯一的，而值可以重复。Map 中的常用实现类有 HashMap、TreeMap、LinkedHashMap 等。
        Set 是一种不允许重复元素的集合，它存储的元素是无序的。Set 中的常用实现类有 HashSet、TreeSet、LinkedHashSet 等。
         */
        String usrKey = usrinfo.getphone();//获取当前登录用户的用户名
        String isRoot = usrinfo.getisroot();//获取当前登录用户的是否为管理员
        if (connRedis.conn.keys("*" + name + "*").isEmpty()) {
            connRedis.conn.close();
            return new StringBuilder("{\"id\":\"用户不存在\",\"Phone\":\"用户不存在\",\"isRoot\":\"false\"}");
        } else {
            Set<String> keys = connRedis.conn.keys("*" + name + "*");
            StringBuilder res_all = new StringBuilder();//StringBuilder用于拼接字符串
            for (String key : keys) {//用key自动遍历所有keys
//                System.out.println(key);
                Map<String, String> tmp = connRedis.conn.hgetAll(key);
                JSONObject jo = new JSONObject(tmp);//阿里巴巴的json包，用于将map转换为json
                if (isRoot.equals("false")) {
                    if (!jo.get("Phone").equals(usrKey)) jo.put("pwd", "贵州魅魔：你能不能死啊");
                }
                res_all.append(jo).append(",");
            }
            res_all = new StringBuilder(res_all.substring(0, res_all.length() - 1));//去掉最后一个逗号
            connRedis.conn.close();
            return res_all;
        }
    }

    static String isRoot(String name) {//判断是否为管理员
        String isRoot = connRedis.conn.hget(name, "isRoot");
        connRedis.conn.close();
        return isRoot;
    }

    static String paramUsrId(String name) {//获取用户学号
        String id = connRedis.conn.hget(name, "id");
        connRedis.conn.close();
        return id;
    }

    interface connRedis {
        Jedis conn = new Jedis("localhost", 6379);//连接redis
    }
}
