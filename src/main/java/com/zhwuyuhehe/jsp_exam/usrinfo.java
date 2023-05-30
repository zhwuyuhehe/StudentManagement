package com.zhwuyuhehe.jsp_exam;

import jakarta.servlet.http.HttpServlet;

public class usrinfo extends HttpServlet {
    private static String usrid;//学号
    private static String pwd;//密
    private static String phone;//电话号码
    private static String isroot;//是否为管理员

    private String info;

    public static String getusrid() {
        return usrid;
    }

    public static void setusrid(String param) {
        usrid = param;
    }

    public static String getpwd() {
        return pwd;
    }

    public static void setpwd(String param) {
        pwd = param;
    }

    public static String getphone() {
        return phone;
    }

    public static void setphone(String param) {
        phone = param;
    }

    public static String getisroot() {
        return isroot;
    }

    public static void setisroot(String param) {
        isroot = param;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
