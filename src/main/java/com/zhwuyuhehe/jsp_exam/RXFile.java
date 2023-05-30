package com.zhwuyuhehe.jsp_exam;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

@MultipartConfig
@WebServlet(name = "RXFile", value = "/RXFile")
public class RXFile extends HttpServlet {
    public void doPost(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        Part File = request.getPart("MyData");
        InputStream FileInput = File.getInputStream();
        CSVFormat csvFormat = CSVFormat.DEFAULT.builder().setHeader("id", "Phone", "pwd", "isRoot").setSkipHeaderRecord(true).build();
        CSVParser csvParser = new CSVParser(new InputStreamReader(FileInput), csvFormat);
        List<CSVRecord> csvRecords = csvParser.getRecords();
        String flag = "true";
        for (CSVRecord csvRecord : csvRecords) {
            String id = csvRecord.get("id");
            String Phone = csvRecord.get("Phone");
            String pwd = csvRecord.get("pwd");
            String isRoot = csvRecord.get("isRoot");
//            System.out.println("Phone:"+Phone+MyRedis.fileAddUsr(Phone, pwd, id, isRoot));
            flag = MyRedis.fileAddUsr(Phone, pwd, id, isRoot);
//            System.out.println(id+" "+pwd+" "+Phone+" "+isRoot);
        }
        if (flag.equals("false")) {
            response.getWriter().write("false");
        } else {
            response.getWriter().write("true");
        }
    }
}