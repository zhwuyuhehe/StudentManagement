<%@ page import="com.zhwuyuhehe.jsp_exam.usrinfo" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>JSP - Hello World</title>
    <link href="logo.png" rel="icon">
    <link href="./layui/css/layui.css" rel="stylesheet" type="text/css">
    <script src="./layui/layui.js" type="text/javascript"></script>
    <script src="jquery-3.6.4.js" type="text/javascript"></script>
    <script src="sliderVerify.js" type="text/javascript"></script>
    <script>
        window.localStorage.setItem("usrName", <%= usrinfo.getphone()%>);
        window.localStorage.setItem("isRootPerson", <%= usrinfo.getisroot()%>);
        <%
        //Java代码中获取session
            HttpSession session = request.getSession();
            try{
            session.getAttribute("key");
            if (session.getAttribute("key")==null||"".equals(session.getAttribute("key"))){
                response.sendRedirect("index.jsp");
            }
            }catch (Exception e){
                response.sendRedirect("index.jsp");
            }
        %>
    </script>
</head>
<body>
<!--前端菜单-->
<!--菜单-->
<div class="layui-header">
    <ul class="layui-nav layui-bg-gray layui-layout-right">
        <li class="layui-nav-item"><a href="#">菜单1-未定义</a></li>
        <li class="layui-nav-item"><a href="#">菜单2-未定义</a></li>
        <li class="layui-nav-item">
            <a href="javascript:">下拉菜单-未定义</a>
            <dl class="layui-nav-child">
                <dd><a href="#">选项1</a></dd>
                <dd><a href="#">选项2</a></dd>
                <dd><a href="#">选项3</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item"><a href="#">菜单3-未定义</a></li>
        <li class="layui-nav-item"><a href="index.jsp"><img alt="" class="layui-nav-img" src="logo.png"></a>
            <dl class="layui-nav-child">
                <dd><a href="javascript:getUsr();">个人信息</a></dd>
                <dd><a href="javascript:window.location.reload();">全部信息</a></dd>
                <hr class="layui-border-black">
                <dd style="text-align: center;"><a href="javascript:logout()">退出</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
            <a href="javascript:">
                <i class="layui-icon layui-icon-more-vertical"></i>
            </a>
        </li>
    </ul>
</div>

<jsp:useBean id="userinfo" class="com.zhwuyuhehe.jsp_exam.usrinfo"/>
<jsp:setProperty name="userinfo" property="info" value="你好："/>
<script>
    // 菜单功能的实现
    function getUsr() {

        layer.alert('<jsp:getProperty name="userinfo" property="info"/>' + window.localStorage.getItem("usrName") + '<br>你的密码为：' + '<%= usrinfo.getpwd()%>' + '<br>管理员状态：' + window.localStorage.getItem("isRootPerson") + '<br>你的学号为：' + '<%= usrinfo.getusrid()%>', {
            skin: 'layui-layer-win10', // 2.8+
            shade: 0.01,
            btn: ['确定', '取消']
        });
    }

    function logout() {
        $.ajax({
            url: "logoutServlet",
            type: "post",
            success: function (data) {
                if (data === "success") {
                    window.location.href = "index.jsp";
                } else {
                    layer.msg("退出失败");
                }
            }
        });
    }

    // 右上角的仨点的功能
    layui.use(['element', 'layer', 'util'], function () {
        let element = layui.element;
        let layer = layui.layer;
        let util = layui.util;
        //头部事件
        util.event('lay-header-event', {
            menuRight: function () {  // 右侧菜单事件
                layer.open({
                    type: 1,
                    title: '更多',
                    content: '<div style="padding: 15px;">处理右侧面板的操作<br>是的，这里什么都没有。<br>只能说明这是<q>zhwuyuhehe</q>编辑的页面</div>',
                    area: ['300px', '100%'],
                    offset: 'rt', //右上角
                    anim: 'slideLeft',
                    shadeClose: true,
                    scrollbar: false
                });
            }
        });
    });
</script>

<!--表格-->
<div class="layui-container" style="padding: 16px; width: 80%;">
    <table class="layui-hide" id="test" lay-filter="test"></table>
    <!-- 在次设置表格 -->
</div>

<%--这里放文件上传的按钮--%>
<button class="layui-btn layui-btn-primary upload_demo layui-btn-sm layui-btn-disabled" disabled="disabled"
        style="display: none"
        name="fileUpload" id="fileUpload"
        lay-options="{accept: 'file',exts: 'csv'}">
    <i class="layui-icon layui-icon-upload"></i>
    仅可上传CSV文件
</button>
<!--表格的按钮-显示_前端-->
<script id="toolbarDemo" type="text/html">
    <!-- 设置自定义工具栏按钮 -->
    <div class="layui-btn-container" style="margin: 0">
        <%--搜索功能的前端显示--%>
        <form class="layui-form layui-row" style="padding-bottom: 10px">
            <div class="layui-col-md6" style="padding-right: 8px">
                <div class="layui-input-wrap">
                    <div class="layui-input-prefix">
                        <i class="layui-icon layui-icon-username"></i>
                    </div>
                    <input type="text" name="search_Phone" value="" placeholder="请输入要搜索的用户名"
                           class="layui-input" lay-affix="clear">
                </div>
            </div>
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-radius layui-btn-primary" lay-submit lay-filter="demo-table-search">
                    搜索
                </button>
                <button type="reset" class="layui-btn layui-btn-radius layui-btn-primary">清空</button>
            </div>
        </form>

        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getData">获取当前页数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">是否全选</button>
        <button class="layui-btn layui-btn-sm" lay-event="insert_data">插入数据</button>
        <!--        <button class="layui-btn layui-btn-sm" id="dropdownButton">-->
        <!--            下拉按钮-->
        <!--            <i class="layui-icon layui-icon-down layui-font-12"></i>-->
        <!--        </button>-->
        <button class="layui-btn layui-btn-sm layui-bg-blue" id="reloadTest" lay-event="reload">
            重载表格
            <!--            <i class="layui-icon layui-icon-down layui-font-12"></i>-->
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="del_many">删除选中行</button>
        <button class="layui-btn layui-btn-sm layui-btn-primary" id="rowMode">
            <span>{{= d.lineStyle ? '多行' : '单行' }}模式</span>
            <i class="layui-icon layui-icon-down layui-font-12"></i>
        </button>
        <button class="layui-btn layui-btn-sm layui-btn-primary" lay-event="fileUpload"><i
                class="layui-icon layui-icon-upload"></i>上传
        </button>
    </div>

</script>


<script id="isRoot_dropdown" type="text/html">
    <button class="layui-btn layui-btn-primary dropdpwn-demo">
        <span>{{= d.isRoot || 'false' }}</span>
        <!--    这里d.xxx，其中xxx是表格中的数据关键字的名字，也就是field的值，需要显示哪一列的从数据库获取的值，就改成d.哪一列-->
        <i class="layui-icon layui-icon-down layui-font-12"></i>
    </button>
</script>

<script id="barDemo" type="text/html">
    <div class="layui-clear-space">
        <a class="layui-btn layui-btn-xs" lay-event="print_val">查看</a>
        <a class="layui-btn layui-btn-xs" lay-event="del_val">删除</a>
    </div>
</script>

<script>
    layui.use(['table', 'dropdown'], function () {
        let table = layui.table;
        let layer = layui.layer;
        let dropdown = layui.dropdown;
        let form = layui.form;
        let upload = layui.upload;
        let options = this;

        // 创建渲染实例
        table.render({
            elem: '#test'
            , url: 'printAll' // 实际使用时需换成真实接口
            , method: 'post'
            , toolbar: '#toolbarDemo'
            , defaultToolbar: ['filter', 'exports', {
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , height: 'full-120' // 最大高度减去其他容器已占有得高度差'full-35'
            , css: [ // 重设当前表格样式
                '.layui-table-tool-temp{padding-right: 145px;}',
                '.layui-table-cell{height: 50px; line-height: 40px;}',
            ].join('')
            , cellMinWidth: 80
            // ,totalRow: true // 开启合计行
            // ,page: true // 开启分页
            , response: {
                statusCode: 200 // 重新规定成功的状态码为 200，table 组件默认为 0
            }
            // 将原始数据解析成 table 组件所规定的数据格式
            , parseData: function (res) {
                return {
                    "code": res.status, //解析接口状态
                    "msg": res.message, //解析提示文本
                    "count": res.total, //解析数据长度
                    "data": res.rows.item //解析数据列表
                };
            }
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {
                    field: 'id',
                    fixed: 'left',
                    width: 240,
                    fieldTitle: '学号',
                    title: 'ID<i class="layui-icon layui-icon-tips layui-font-14" title="该字段开启了编辑功能" style="margin-left: 5px;"></i>',
                    edit: 'text',
                    sort: true
                }
                , {field: 'Phone', width: 240, title: '用户名', fieldTitle: '手机号', sort: true}
                , {
                    field: 'pwd',
                    width: 240,
                    fieldTitle: '密码',
                    title: '密码<i class="layui-icon layui-icon-tips layui-font-14" title="这里也可以编辑" style="margin-left: 5px;"></i>',
                    edit: 'textarea'
                }
                , {
                    field: 'isRoot',
                    width: 120,
                    title: '管理员',
                    minWidth: 80,
                    templet: '#isRoot_dropdown'
                    // , exportTemplet: function (d, obj) {
                    // //     处理该字段的导出数据
                    //     let td = obj.td(this.field); // 获取当前 td
                    //     return td.find('span').text(); // 返回 span 中的内容,而不是span标签内的val值
                    //
                    // }
                }
                , {fixed: 'right', title: '操作', width: 160, minWidth: 125, toolbar: '#barDemo'}
            ]]
            , initSort: {
                field: 'id' // 排序字段，对应 cols 设定的各字段名
                , type: 'asc' // 排序方式  asc: 升序；desc: 降序、null: 默认排序
            }
            , done: function (res, curr, count) {
                let id = this.id;
                // 获取当前行数据，done之后才可以写这个函数。
                let options = this;
                table.getRowData = function (elem) {
                    let index = $(elem).closest('tr').data('index');
                    return table.cache[options.id][index] || {};
                };

                // dropdown 方式的下拉选择，设置是否为管理员
                dropdown.render({
                    elem: '.dropdpwn-demo'
                    // ,trigger: 'hover'
                    // 此处的 data 值，可根据 done 返回的 res 遍历来赋值，<这里是下拉的选项?>
                    , data: [{
                        title: 'true'
                        , id: 1
                    }, {
                        title: 'false'
                        , id: 0
                    }]
                    , click: function (obj) {
                        let data_val = table.getRowData(this.elem); // 获取当前行数据(如 id 等字段，以作为数据修改的索引),Layui，自动获取
                        this.elem.find('span').html();
                        let isRoot = obj.title;
                        let Phone = data_val.Phone;
                        // console.log(isRoot);
                        // console.log(Phone);
                        let isRootPerson = window.localStorage.getItem("isRootPerson");
                        if (isRootPerson === "true") {
                            this.elem.find('span').html(obj.title);
                            $.ajax({
                                url: 'editUsr',
                                type: 'post',
                                async: true,
                                data: {
                                    Phone: Phone,
                                    pos: "isRoot",
                                    val: isRoot
                                },
                                success: function (data) {
                                    let res = JSON.stringify(data);
                                    if (res === "\"true\"") {
                                        layer.msg("设置管理员权限为：" + isRoot, {icon: 1});
                                    } else {
                                        layer.msg(res, {icon: 2});
                                    }
                                },
                                error: function (data) {
                                    let res = JSON.stringify(data); // 得到 JSON 字符串形式的所有键值
                                    console.log(res.Phone);
                                    layer.alert('服务器异常' + res, {icon: 2});
                                }
                            });
                        }
                        //如果不是管理员，则不可设置管理员权限。
                        else {
                            layer.msg("你谁啊，你当你谁啊？？？", {icon: 2});
                        }

                        // 显示 - 仅用于演示
                        // layer.msg('选中值: ' + isRoot + '<br>当前行数据：' + JSON.stringify(data_val));
                    }
                });

                // 行模式
                dropdown.render({
                    elem: '#rowMode'
                    , data: [{
                        id: 'default-row',
                        title: '单行模式（默认）'
                    }, {
                        id: 'multi-row',
                        title: '多行模式'
                    }]
                    // 菜单被点击的事件
                    , click: function (obj) {
                        let checkStatus = table.checkStatus(id)
                        let data = checkStatus.data; // 获取选中的数据
                        switch (obj.id) {
                            case 'default-row':
                                table.reload('test', {
                                    lineStyle: null // 恢复单行
                                });
                                layer.msg('已设为单行');
                                break;
                            case 'multi-row':
                                table.reload('test', {
                                    // 设置行样式，此处以设置多行高度为例。若为单行，则没必要设置改参数 - 注：v2.7.0 新增
                                    lineStyle: 'height: 95px;'
                                });
                                layer.msg('即通过设置 lineStyle 参数可开启多行');
                                break;
                        }
                    }
                });
            }
            , error: function (res, msg) {
                console.log(res, msg)
            }
        });


        form.on('submit(demo-table-search)', function (data) {
            let field = data.field; // 获得表单字段
            // 执行搜索重载,可以遍历全部数据，查看包含，实现模糊搜索
            table.reload('test', {
                where: {usrVal: field.search_Phone} // 搜索的字段，name的值为search_Phone获取整个输入框的值
                , method: 'post'
                , url: 'searchServlet'
                , parseData: function (res) { // res 即为原始返回的数据
                    return {
                        "code": res.status, // 解析接口状态
                        "msg": res.message, // 解析提示文本
                        "count": res.total, // 解析数据长度
                        "data": res.rows.item // 解析数据列表
                    };
                }
                , response: {
                    statusCode: 200 // 重新规定成功的状态码为 200，table 组件默认为 0
                }
            });

            layer.msg('搜索成功<br>' + field.search_Phone);
            return false; // 阻止默认 form 跳转
        });

        // 工具栏事件
        table.on('toolbar(test)', function (obj) {
            let id = obj.config.id;
            let checkStatus = table.checkStatus(id);//框架自动处理选中行的数据
            switch (obj.event) {
                case 'getCheckData':
                    let data = checkStatus.data;//定义一个data变量，储存选中的信息。
                    layer.alert(layui.util.escape(JSON.stringify(data)));//格式化输出选择的信息
                    break;
                case 'getData':
                    let getData = table.getData(id);
                    // console.log(getData);
                    layer.alert(layui.util.escape(JSON.stringify(getData)));//格式化输出信息
                    break;
                case 'isAll':
                    layer.msg(layui.table.checkStatus(obj.config.id).isAll ? '全选' : '未全选');
                    break;
                case 'insert_data':
                    let isRootPerson = window.localStorage.getItem("isRootPerson");//判断当前登录的用户是否有管理员权限，如果没有就不能插入数据
                    if (isRootPerson === "true") {
                        let form_index =
                            layer.open({
                                type: 1,// page 层类型，内部包含了一个页面。
                                area: ['auto', '300px'],
                                resize: false,// 禁止拉伸
                                shadeClose: true,// 点击遮罩开启，背景变暗
                                title: '添加用户信息',
                                content: '<div class="layui-form" lay-filter="filter-test-layer" style="margin: 16px;">\n' +
                                    '    <div class="demo-login-container">\n' +
                                    '<div class="layui-form-item">\n' +
                                    '                    <div class="layui-input-wrap">\n' +
                                    '                        <div class="layui-input-prefix">\n' +
                                    '                            <i class="layui-icon layui-icon-cellphone"></i>\n' +
                                    '                        </div>\n' +
                                    '                        <input type="text" name="cellphone" value="" lay-verify="phone" placeholder="手机号" lay-reqtext="请填写手机号" autocomplete="off" class="layui-input" id="reg-cellphone">\n' +
                                    '                    </div>\n' +
                                    '                </div>' +
                                    '        <div class="layui-form-item">' +
                                    '            <div class="layui-input-wrap">\n' +
                                    '                <div class="layui-input-prefix">\n' +
                                    '                    <i class="layui-icon layui-icon-username"></i>\n' +
                                    '                </div>\n' +
                                    '                <input type="text" name="id" value="" lay-verify="required" placeholder="学号" lay-reqtext="请填写学号" autocomplete="off" class="layui-input" lay-affix="clear">\n' +
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '        <div class="layui-form-item">\n' +
                                    '            <div class="layui-input-wrap">\n' +
                                    '                <div class="layui-input-prefix">\n' +
                                    '                    <i class="layui-icon layui-icon-password"></i>\n' +
                                    '                </div>\n' +
                                    '                <input type="password" name="password" value="" lay-verify="required" placeholder="密   码" lay-reqtext="请填写密码" autocomplete="off" class="layui-input" lay-affix="eye">\n' +
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '        <div class="layui-form-item">\n' +
                                    '            <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo-login">确认</button>\n' +
                                    '        </div>\n' +
                                    '    </div>\n' +
                                    '</div>',
                                success: function () {
                                    form.render();// 对弹层中的表单进行初始化渲染

                                    // 表单提交事件
                                    form.on('submit(demo-login)', function (data) {
                                        console.log("表单提交事件\n" + JSON.stringify(data.field));
                                        let field = data.field; // 获取表单字段值
                                        // 显示填写结果，仅作演示用
                                        layer.close(form_index);
                                        layer.msg(JSON.stringify(field));
                                        let usrPhone = field.cellphone;
                                        let regPwd = field.password;
                                        let usrNum = field.id;
                                        $.ajax({
                                            url: 'regServlet',//请求地址
                                            type: 'post',//请求方式
                                            async: true,//是否异步请求
                                            data: {//请求参数
                                                usr: usrPhone,//手机号，作为用户名，唯一不可重复，传给后端的名字：传递的值
                                                pwd: regPwd,
                                                stuNum: usrNum
                                            },
                                            success: function (data) {
                                                let res = JSON.stringify(data);//将返回的数据转换成字符串
                                                if (res === "\"true\"") {//后端的返回值是否为true
                                                    layer.msg("添加" + usrPhone + "成功", {icon: 1});
                                                } else {
                                                    layer.msg(res, {icon: 2});
                                                }
                                            },
                                            error: function (data) {
                                                let res = JSON.stringify(data);
                                                layer.alert('服务器异常' + res, {icon: 2});
                                            }
                                        });
                                        return false; // 阻止默认 form 跳转
                                    });
                                }
                            });
                    } else {
                        layer.msg("你谁啊，你当你谁啊？？？", {icon: 2});
                    }
                    break;
                case 'reload':
                    // 数据重载 - 参数重置
                    table.reloadData('test', {
                        // where: {
                        // id: '20050100001'
                        //,test: '新的 test2'
                        //,token: '新的 token2'
                        // },
                        scrollPos: 'fixed'  // 保持滚动条位置不变 - v2.7.3 新增
                        , height: 2000 // 测试无效参数（即与数据无关的参数设置无效，此处以 height 设置无效为例）
                        , url: 'printAll'
                        //,page: {curr: 1, limit: 30} // 重新指向分页
                    });
                    layer.msg('已重新加载数据');
                    break;
                case 'del_many':
                    let rootVal = window.localStorage.getItem("isRootPerson");
                    if (rootVal === "false") {
                        layer.msg("你谁啊，你当你谁啊？？？", {icon: 2});
                        break;
                    }
                    let data_del = checkStatus.data;//获取当前选中行的信息
                    let del_phones = [];//储存用户手机号，用来批量删除
                    for (let x of data_del) {//依次把手机号添加到del_Phones里
                        // console.log(x['Phone']);
                        del_phones.push(x['Phone']);
                    }
                    // console.log(del_phones);
                    layer.confirm('真的删除行 [用户名: ' + del_phones + '] 么', function (index) {
                        $.ajax({
                            url: 'delMany',
                            type: 'post',
                            async: true,
                            data: {
                                Phone: JSON.stringify(del_phones)
                            },
                            success: function (data_inner) {
                                let res = JSON.stringify(data_inner);
                                if (res === "\"true\"") {
                                    layer.msg("删除成功", {icon: 1});
                                    table.reloadData('test', {
                                        // where: {
                                        // id: '20050100001'
                                        //,test: '新的 test2'
                                        //,token: '新的 token2'
                                        // },
                                        scrollPos: 'fixed'  // 保持滚动条位置不变 - v2.7.3 新增
                                        , height: 2000 // 测试无效参数（即与数据无关的参数设置无效，此处以 height 设置无效为例）
                                        , url: 'printAll'
                                        //,page: {curr: 1, limit: 30} // 重新指向分页
                                    });
                                } else {
                                    layer.msg("某些或全部所选的数据删除失败，请刷新表格查看！", {icon: 2});
                                }
                            },
                            error: function (data_inner) {
                                let res = JSON.stringify(data_inner);
                                layer.alert('服务器异常' + res, {icon: 2});
                            }
                        });
                    });
                    break;
                case'fileUpload':
                    let ifYouRoot = window.localStorage.getItem("isRootPerson");
                    if (ifYouRoot !== "true") {
                        layer.msg("你在想桃子？？？", {icon: 2});
                        break;
                    }
                    $('#fileUpload').click();
                    break;
                case 'LAYTABLE_TIPS':
                    layer.alert('<i class="layui-icon layui-icon-mute" style="font-size: 4em"></i>禁止狗叫', {
                        icon: 0,
                        title: '说你呢'
                    });
                    break;
            }
        });

        // 触发单元格工具事件单元格操作栏目
        table.on('tool(test)', function (obj) { // 双击 toolDouble
            let data = obj.data; // 获得当前行数据
            // console.log(obj)
            if (obj.event === 'print_val') {
                layer.alert('当前行数据：<br>' + JSON.stringify(data), {
                    title: '查看: ' + data.id,
                    shadeClose: true,
                    shade: 0.4,
                });
            } else if (obj.event === 'del_val') {
                let isRootPerson = window.localStorage.getItem("isRootPerson");
                let usrNameInner = window.localStorage.getItem("usrName");
                if (isRootPerson === "true") {
                    layer.confirm('真的删除行 [用户名: ' + data.Phone + '] 么', function (index) {
                        //向服务端发送删除指令
                        $.ajax({
                            url: 'delUsr',
                            type: 'post',
                            async: true,
                            data: {
                                Phone: data.Phone
                            },
                            success: function (data_inner) {
                                let res = JSON.stringify(data_inner);
                                if (res === "\"true\"") {
                                    obj.del(); // 删除对应行（tr）的DOM结构，并更新缓存
                                    layer.close(index);
                                    layer.msg("删除" + "成功", {icon: 1});
                                } else {
                                    layer.msg(res, {icon: 2});
                                }
                            },
                            error: function (data_inner) {
                                let res = JSON.stringify(data_inner);
                                layer.alert('服务器异常' + res, {icon: 2});
                            }
                        });
                    });
                } else if (!(usrNameInner === data.Phone)) {
                    layer.msg("你谁啊，你当你谁啊？？？", {icon: 2});
                    return false;
                } else {
                    layer.confirm('真的删除行 [用户名: ' + data.Phone + '] 么', function (index) {
                        //向服务端发送删除指令
                        $.ajax({
                            url: 'delUsr',
                            type: 'post',
                            async: true,
                            data: {
                                Phone: data.Phone
                            },
                            success: function (data_inner) {
                                let res = JSON.stringify(data_inner);
                                if (res === "\"true\"") {
                                    obj.del(); // 删除对应行（tr）的DOM结构，并更新缓存
                                    layer.close(index);
                                    layer.msg("删除" + "成功", {icon: 1});
                                } else {
                                    layer.msg(res, {icon: 2});
                                }
                            },
                            error: function (data_inner) {
                                let res = JSON.stringify(data_inner);
                                layer.alert('服务器异常' + res, {icon: 2});
                            }
                        });
                    });
                }

            }
        });

        // 触发表格复选框选择
        table.on('checkbox(test)', function (obj) {
            // console.log(obj)
        });

        // 触发表格单选框选择
        table.on('radio(test)', function (obj) {
            // console.log(obj)
        });

        // 行单击事件
        table.on('row(test)', function (obj) {
            //console.log(obj);
            //layer.closeAll('tips');
        });
        // 行双击事件
        table.on('rowDouble(test)', function (obj) {
            console.log(obj);
        });

        // 单元格编辑事件
        table.on('edit(test)', function (obj) {
            let isRootPerson = window.localStorage.getItem("isRootPerson");//判断是否为管理员
            let usrNameInner = window.localStorage.getItem("usrName");//当前登录的用户名
            let field = obj.field; // 得到字段
            let value = obj.value; // 得到修改后的值
            let data_val = obj.data; // 得到所在行所有键值
            // 值的校验
            if (isRootPerson === "true") {
                if (field === 'id') {
                    if (!/^\d{11}$/.test(obj.value)) {
                        layer.tips('输入的学号格式不正确，请重新编辑', this, {tips: 1});
                        return obj.reedit(); // 重新编辑 -- v2.8.0 新增
                    }
                    console.log(data_val.id, data_val.Phone); //根据Phone查询用户，修改id
                    //Phone pos id pwd

                    $.ajax({
                        url: 'editUsr',
                        type: 'post',
                        async: true,
                        data: {
                            Phone: data_val.Phone,
                            pos: "id",
                            val: value
                        },
                        success: function (data) {
                            let res = JSON.stringify(data);
                            if (res === "\"true\"") {
                                layer.msg("编辑用户昵称为：" + value, {icon: 1});
                            } else {
                                layer.msg(res, {icon: 2});
                            }
                        },
                        error: function (data) {
                            layer.alert('服务器异常' + res, {icon: 2});
                        }
                    });


                } else if (field === 'pwd') {
                    if (/^$/.test(obj.value)) {
                        layer.tips('输入的密码格式不正确，请重新编辑', this, {tips: 1});
                        return obj.reedit(); // 重新编辑 -- v2.8.0 新增
                    }
                    // console.log(data.pwd,data.Phone); 根据Phone查询用户，修改pwd
                    $.ajax({
                        url: 'editUsr',
                        type: 'post',
                        async: true,
                        data: {
                            Phone: data_val.Phone,
                            pos: "pwd",
                            val: value
                        },
                        success: function (data) {
                            let res = JSON.stringify(data);
                            if (res === "\"true\"") {
                                layer.msg("编辑用户密码为：" + value, {icon: 1});
                            } else {
                                layer.msg(res, {icon: 2});
                            }
                        },
                        error: function (data) {
                            let res = JSON.stringify(data);
                            console.log(res.Phone);
                            layer.alert('服务器异常' + res, {icon: 2});
                        }
                    });


                }
            } else if (!(usrNameInner === data_val.Phone)) {
                layer.msg("你谁啊，你当你谁啊？？？", {icon: 2});
                table.reloadData('test', {
                    // where: {
                    // id: '20050100001'
                    //,test: '新的 test2'
                    //,token: '新的 token2'
                    // },
                    scrollPos: 'fixed'  // 保持滚动条位置不变 - v2.7.3 新增
                    , height: 2000 // 测试无效参数（即与数据无关的参数设置无效，此处以 height 设置无效为例）
                    , url: 'printAll'
                    //,page: {curr: 1, limit: 30} // 重新指向分页
                });
                // window.setTimeout(function () {
                //     window.location.reload();
                // },2000)
                return false;
            } else {
                if (field === 'id') {
                    if (!/^\d{11}$/.test(obj.value)) {
                        layer.tips('输入的学号格式不正确，请重新编辑', this, {tips: 1});
                        return obj.reedit(); // 重新编辑 -- v2.8.0 新增
                    }
                    console.log(data_val.id, data_val.Phone); //根据Phone查询用户，修改id
                    //Phone pos id pwd

                    $.ajax({
                        url: 'editUsr',
                        type: 'post',
                        async: true,
                        data: {
                            Phone: data_val.Phone,
                            pos: "id",
                            val: value
                        },
                        success: function (data) {
                            let res = JSON.stringify(data);
                            if (res === "\"true\"") {
                                layer.msg("编辑用户昵称为：" + value, {icon: 1});
                            } else {
                                layer.msg(res, {icon: 2});
                            }
                        },
                        error: function (data) {
                            layer.alert('服务器异常' + res, {icon: 2});
                        }
                    });


                } else if (field === 'pwd') {
                    if (/^$/.test(obj.value)) {
                        layer.tips('输入的密码格式不正确，请重新编辑', this, {tips: 1});
                        return obj.reedit(); // 重新编辑 -- v2.8.0 新增
                    }
                    // console.log(data.pwd,data.Phone); 根据Phone查询用户，修改pwd
                    $.ajax({
                        url: 'editUsr',
                        type: 'post',
                        async: true,
                        data: {
                            Phone: data_val.Phone,
                            pos: "pwd",
                            val: value
                        },
                        success: function (data) {
                            let res = JSON.stringify(data);
                            if (res === "\"true\"") {
                                layer.msg("编辑用户密码为：" + value, {icon: 1});
                            } else {
                                layer.msg(res, {icon: 2});
                            }
                        },
                        error: function (data) {
                            let res = JSON.stringify(data);
                            console.log(res.Phone);
                            layer.alert('服务器异常' + res, {icon: 2});
                        }
                    });


                }
            }

            // 编辑后续操作，如提交更新请求，以完成真实的数据更新
            // …
            // layer.msg('编辑成功', {icon: 1});

            // 其他更新操作
            let update = {};
            update[field] = value;
            obj.update(update);

        });
    });

    //上传文件的方法，如何设置为点击后再渲染，则按钮失效
    layui.use(function () {
        {
            let upload = layui.upload;
            let layer = layui.layer;
            let table = layui.table;
            // 渲染上传文件

            let areYouRoot = window.localStorage.getItem("isRootPerson");
            if (areYouRoot === "true") {
                $("#fileUpload").removeAttr("disabled").removeClass("layui-btn-disabled");//将按钮可用
            }
            upload.render({
                elem: '#fileUpload', // 绑定多单个元素
                url: 'RXFile', // 此处配置你自己的上传接口即可
                method: 'post',
                field: 'MyData', // 文件域字段名，默认为file
                accept: 'file', // 普通文件
                drag: true, // 支持拖拽上传
                done: function (res_val) {
                    if (res_val) {
                        layer.msg('上传成功');
                        table.reloadData('test', {
                            // where: {
                            // id: '20050100001'
                            //,test: '新的 test2'
                            //,token: '新的 token2'
                            // },
                            scrollPos: 'fixed'  // 保持滚动条位置不变 - v2.7.3 新增
                            , height: 2000 // 测试无效参数（即与数据无关的参数设置无效，此处以 height 设置无效为例）
                            , url: 'printAll'
                            //,page: {curr: 1, limit: 30} // 重新指向分页
                        });
                    }
                },
                error: function (res_val) {
                    layer.msg('error');
                    console.log(res_val);
                }
            });
        }
    });

</script>

</body>
</html>
