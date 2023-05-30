package com.zhwuyuhehe.jsp_exam;

import com.aliyun.auth.credentials.Credential;
import com.aliyun.auth.credentials.provider.StaticCredentialProvider;
import com.aliyun.sdk.service.dysmsapi20170525.AsyncClient;
import com.aliyun.sdk.service.dysmsapi20170525.models.SendSmsRequest;
import com.aliyun.sdk.service.dysmsapi20170525.models.SendSmsResponse;
import com.google.gson.Gson;
import darabonba.core.client.ClientOverrideConfiguration;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jetbrains.annotations.NotNull;
import org.json.JSONObject;

import java.io.IOException;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@WebServlet(name = "SendSms", value = "/SendSms")
public class SendSms extends HttpServlet {
    public static String SmsInfo(String num) throws ExecutionException, InterruptedException {
        // 连接阿里云RAM账号
        StaticCredentialProvider provider = StaticCredentialProvider.create(Credential.builder()
                .accessKeyId("你RAM用户的ID")
                .accessKeySecret("你RAM用户的secret")
                //.securityToken("<your-token>") // use STS token
                .build());

        // Configure the Client
        AsyncClient client = AsyncClient.builder()
                .region("cn-beijing") // Region ID
                //.httpClient(httpClient) // Use the configured HttpClient, otherwise use the default HttpClient (Apache HttpClient)
                .credentialsProvider(provider)
                //.serviceConfiguration(Configuration.create()) // Service-level configuration
                // Client-level configuration rewrite, can set Endpoint, Http request parameters, etc.
                .overrideConfiguration(
                        ClientOverrideConfiguration.create()
                                .setEndpointOverride("dysmsapi.aliyuncs.com")
                        //.setConnectTimeout(Duration.ofSeconds(30))
                )
                .build();
        String Num = "0123456789";
        StringBuilder SmsCode = new StringBuilder(4);
        JSONObject info = new JSONObject();
        for (int i = 0; i < 4; i++) {
            SmsCode.append(Num.charAt((int) (Math.random() * 10)));
        }
        info.put("code", SmsCode.toString());
//        String code = info.getString("code");
        // Parameter settings for API request
        SendSmsRequest sendSmsRequest = SendSmsRequest.builder()
                .signName("你的签名")
                .templateCode("你的模板名")
                .phoneNumbers(num)
                .templateParam(String.valueOf(info))
                // Request-level configuration rewrite, can set Http request parameters, etc.
                //没用备案的网站或已上线的app（没有企业认证）只能向已回复授权绑定的手机号发送验证码，每小时只能发5条，每分钟只能发一条。
                // .requestConfiguration(RequestConfiguration.create().setHttpHeaders(new HttpHeaders()))
                .build();

        // Asynchronously get the return value of the API request
        CompletableFuture<SendSmsResponse> response = client.sendSms(sendSmsRequest);
        // Synchronously get the return value of the API request
        SendSmsResponse resp = response.get();
        System.out.println(new Gson().toJson(resp));
        // Asynchronous processing of return values
        /*response.thenAccept(resp -> {
            System.out.println(new Gson().toJson(resp));
        }).exceptionally(throwable -> { // Handling exceptions
            System.out.println(throwable.getMessage());
            return null;
        });*/

        // Finally, close the client
        client.close();
        return info.getString("code");
    }

    public void doPost(@NotNull HttpServletRequest request, @NotNull HttpServletResponse response) throws IOException {
        String code, num;
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        num = request.getParameter("usr");
        try {
            code = SmsInfo(num);
            response.getWriter().write(code);
        } catch (ExecutionException | InterruptedException e) {
            response.getWriter().write("验证码发送失败");
            throw new RuntimeException(e);
        }

    }

}
