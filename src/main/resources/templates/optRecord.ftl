<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>物资管理</title>
    <link href="${rc.contextPath}/static/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${rc.contextPath}/static/css/bootstrap-table.min.css" rel="stylesheet"/>
    <link href="${rc.contextPath}/static/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <link href="${rc.contextPath}/static/css/bootstrap-select.min.css" rel="stylesheet"/>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0
        }

        body {
            font-size: 12px;
            font-family: "宋体", "微软雅黑";
        }

        ul, li {
            list-style: none;
        }

        .menu a:link, .menu a:visited {
            text-decoration: none;
            color: #fff;
        }

        .menu {
            width: 15%;
            border-bottom: solid 1px #316a91;
            margin: 20px 10px 0 10px;
            display: inline-block;
        }

        .menu ul li {
            background-color: #467ca2;
            border: solid 1px #316a91;
            border-bottom: 0;
        }

        .menu ul li a {
            padding-left: 10px;
            color: #fff;
            font-size: 12px;
            display: block;
            font-weight: bold;
            height: 36px;
            line-height: 36px;
            position: relative;
        }

        .menu ul li .inactive {
            background: url(${rc.contextPath}/static/images/off.png) no-repeat 184px center;
        }

        .menu ul li .inactives {
            background: url(${rc.contextPath}/static/images/on.png) no-repeat 184px center;
        }

        .menu ul li ul {
            display: none;
        }

        .menu ul li ul li {
            border-left: 0;
            border-right: 0;
            background-color: #6196bb;
            border-color: #467ca2;
        }

        .menu ul li ul li ul {
            display: none;
        }

        .menu ul li ul li a {
            padding-left: 20px;
        }

        .menu ul li ul li ul li {
            background-color: #d6e6f1;
            border-color: #6196bb;
        }

        .last {
            background-color: #d6e6f1;
            border-color: #6196bb;
        }

        .menu ul li ul li ul li a {
            color: #316a91;
            padding-left: 30px;
        }

        .content {
            /*background-color: aqua;*/

            display: inline-block;
            width: 80%;
            margin-top: 20px;
            vertical-align: top;
        }

        .search {
            background-color: #6196bb;

            display: inline-block;
            width: 100%;
            height: 50px;
            padding: 8px;
        }

        .list {
            background-color: #316a91;

            display: inline-block;
            width: 100%;
            height: 50px;
        }
    </style>
    <script type="text/javascript" src="${rc.contextPath}/static/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/static/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/static/js/bootstrap-table.min.js"></script>
    <script src="${rc.contextPath}/static/js/bootstrap-table-zh-CN.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.inactive').click(function () {
                var className = $(this).parents('li').parents().attr('class');
                if ($(this).siblings('ul').css('display') == 'none') {
                    if (className == "yiji") {
                        $(this).parents('li').siblings('li').children('ul').parent('li').children('a').removeClass('inactives');
                        $(this).parents('li').siblings('li').children('ul').slideUp(100);
                        $(this).parents('li').children('ul').children('li').children('ul').parent('li').children('a').removeClass('inactives');
                        $(this).parents('li').children('ul').children('li').children('ul').slideUp(100);
                    }
                    $(this).addClass('inactives');
                    $(this).siblings('ul').slideDown(100);
                } else {
                    $(this).removeClass('inactives');
                    $(this).siblings('ul').slideUp(100);
                }
            })
        });
    </script>
</head>
<body>
<div class="menu">
    <ul class="yiji">
        <li><a href="${rc.contextPath}/main">物资管理</a></li>
        <li style="background-color: #6f9ecf"><a href="${rc.contextPath}/optRecord">出入库记录</a></li>
    </ul>
</div>
<div class="content">

    <div class="search">
        名称:&nbsp;&nbsp;<input type="text" id="name"/>
        <button style="margin-left: 20px" onclick="search()">查询</button>
        <button style="margin-left: 20px" onclick="clearSearch()">清除</button>
    </div>

    <div class="list">

        <table id="dataTable"></table>

    </div>

</div>

</body>

<script type="text/javascript">
    $(function () {
        // selectMenu("clinic");
        var table = new TableInit();
        table.Init();
    });

    var TableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Reloader = function () {
            var name = $("input[name='name']").val();
            $.ajax({
                type: "POST",
                url: "${rc.contextPath}/item/data",
                success: function (msg) {
                    //这里的msg是json对象，不是json字符串。
                    $('#dataTable').refresh('load', msg);
                }
            });
        }
        oTableInit.Init = function () {
            $('#dataTable').bootstrapTable({
                url: '${rc.contextPath}/itemOpt/data',         //请求后台的URL（*）
                method: 'GET',                      //请求方式（*）
                toolbar: '#toolbar',              //工具按钮用哪个容器
                toolbarAlign: 'right',
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                paginationHAlign: "right",
                paginationDetailHAlign: "left",
                sortable: false,                     //是否启用排序
                sortOrder: "desc",                   //排序方式
                sortName: "",
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
                pageSize: 10,                     //每页的记录行数（*）
                pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                search: false,                      //是否显示表格搜索
                strictSearch: true,
                showColumns: false,                  //是否显示所有的列（选择显示的列）
                showRefresh: false,                  //是否显示刷新按钮
                minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                //height: 500,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                showToggle: false,                   //是否显示详细视图和列表视图的切换按钮
                cardView: false,                    //是否显示详细视图
                detailView: false,                  //是否显示父子表
                queryParams: oTableInit.queryParams,
                queryParamsType: 'limit',
                columns: [
                    {
                        field: '',
                        title: '序号',
                        formatter: function (value, row, index) {
                            return index + 1;
                        }
                    }, {
                        field: 'name',
                        title: '名称',
                    }, {
                        field: 'type',
                        title: '出库/入库',
                        formatter: function (value, row, index) {
                            if(value == "1"){
                                return "入库";
                            }else if(value == "2"){
                                return "出库";
                            }
                        }
                    }, {
                        field: 'num',
                        title: '操作数量数量',
                    }, {
                        field: 'optTime',
                        title: '操作时间',
                        formatter: function (value, row, index) {
                            var now = new Date();
                            var yy = now.getFullYear();      //年
                            var mm = now.getMonth() + 1;     //月
                            var dd = now.getDate();          //日
                            var hh = now.getHours();         //时
                            var ii = now.getMinutes();       //分
                            var ss = now.getSeconds();       //秒
                            var clock = yy + "-";
                            if(mm < 10) clock += "0";
                            clock += mm + "-";
                            if(dd < 10) clock += "0";
                            clock += dd + " ";
                            if(hh < 10) clock += "0";
                            clock += hh + ":";
                            if (ii < 10) clock += '0';
                            clock += ii + ":";
                            if (ss < 10) clock += '0';
                            clock += ss;
                            return clock;
                        }
                    },{
                        field: 'remark',
                        title: '备注',
                    }

                ],
                onLoadError: function (status, jqXHR) {
                    alert("error")
                },
                rowStyle: function (row, index) {
                    var classesArr = ['colors1', 'colors2'];
                    var strclass = "";
                    var str = row.signData;
                    if (!isEmpty(str)) {
                        var st = str.substring(str.length - 1, str.length)
                        var s = parseInt(st);
                        if (s % 2 === 0) {//偶数行
                            strclass = classesArr[0];
                        } else {//奇数行
                            strclass = classesArr[1];
                        }
                        return {classes: strclass};
                    } else {
                        return {classes: classesArr[1]};
                    }
                },//变色
            });
        };


        //得到查询的参数
        oTableInit.queryParams = function (params) {

            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                pageSize: params.limit,   //页面大小
                pageNumber: (params.offset / params.limit) + 1, //当前页码
                offset: params.offset,
                sort: params.sort,
                sortOrder: params.order,
                name: $('#name').val(),
            };
            return temp;
        };
        return oTableInit;
    };

    function search() {

        var opt = $("#dataTable").bootstrapTable('getOptions', '');
        opt.pageNumber = 1;
        opt.name = $('#name').val();
        $("#dataTable").bootstrapTable('refreshOptions', opt);

    }

    function clearSearch() {
        $("#name").val("");
    }

    function toRuku(row) {
        $('#ruku').modal({
            show: true,
            backdrop: 'static',
            keyboard: false
        });
        $('#ruku').on('shown.bs.modal', function (e) {
            $("#rukuId").val(row.id);
            $("#rukuNum").val("");
            $("#rukuRemark").val("");
        });
    }

    function ruku() {
        var id = $("#rukuId").val();
        var num = $("#rukuNum").val();
        var remark = $("#rukuRemark").val();
        if (!num) {
            alert("请填写数量");
            return;
        }
        if (num.length <= 0) {
            alert("数量不可小于0");
            return;
        }

        var data = new FormData();
        data.append("id", id);
        data.append("num", num);
        data.append("remark", remark);
        data.append("type", "1");
        submit(data);
    }

    function toChuku(row) {
        $('#chuku').modal({
            show: true,
            backdrop: 'static',
            keyboard: false
        });
        $('#chuku').on('shown.bs.modal', function (e) {
            $("#chukuId").val(row.id);
            $("#chukuNum").val("");
            $("#chukuRemark").val("");
        });
    }

    function chuku() {
        var id = $("#chukuId").val();
        var num = $("#chukuNum").val();
        var remark = $("#chukuRemark").val();
        if (!num) {
            alert("请填写数量");
            return;
        }
        if (num.length <= 0) {
            alert("数量不可小于0");
            return;
        }

        var data = new FormData();
        data.append("id", id);
        data.append("num", num);
        data.append("remark", remark);
        data.append("type", "2");
        submit(data);
    }

    function submit(data) {
        $.ajax({
            type: "POST",
            url: "${rc.contextPath}/item/opt",
            data: data,
            // dataType: "json",
            async: false,
            processData: false,
            contentType: false,
            beforeSend: function (request) {

            },
            complete: function () {

            },
            success: function (msg) {
                if (msg.success) {
                    if (data.get("type") == 1) {
                        hideModal("ruku");
                        refreshTable('dataTable');
                    } else if (data.get("type") == 2) {
                        hideModal("chuku");
                        refreshTable('dataTable');
                    } else if (data.get("type") == -1) {
                        refreshTable('dataTable');
                    }
                } else {
                    alert(msg.errorDesc);
                    // return;
                }
            },
        });
    }

    function del(row) {
        var data = new FormData();
        data.append("id", row.id);
        data.append("type", "-1");
        submit(data);
    }

    function toAdd() {
        $('#add').modal({
            show: true,
            backdrop: 'static',
            keyboard: false
        });
        $('#add').on('shown.bs.modal', function (e) {
            $("#itemName").val("");
            $("#itemNum").val("");
            $("#itemDescription").val("");
        });
    }

    function add() {
        var name = $("#itemName").val();
        var num = $("#itemNum").val();
        var description = $("#itemDescription").val();
        if (!name) {
            alert("请填写名称");
            return;
        }
        if (!num) {
            alert("请填写数量");
            return;
        }
        if (num.length <= 0) {
            alert("数量不可小于0");
            return;
        }

        var data = new FormData();
        data.append("name", name);
        data.append("num", num);
        data.append("description", description);

        $.ajax({
            type: "POST",
            url: "${rc.contextPath}/item/add",
            data: data,
            // dataType: "json",
            async: false,
            processData: false,
            contentType: false,
            beforeSend: function (request) {

            },
            complete: function () {

            },
            success: function (msg) {
                if (msg.success) {
                    hideModal("add");
                    refreshTable('dataTable');
                } else {
                    alert(msg.errorDesc);
                }
            },
        });
    }


    function isEmpty(obj) {
        if (typeof obj == "undefined" || obj == null || obj == "") {
            return true;
        } else {
            return false;
        }
    }

    //模态框关闭
    function hideModal(modalId, callback) {
        $("#" + modalId).map(function () {
            $(this).modal('hide');
        });

        $("#" + modalId).on('hidden.bs.modal', function (e) {
            try {
                callback();
            } catch (e) {
                console.log(e);
            }
        });
    }

    //刷新table表格
    function refreshTable(tableId, parameter) {
        if (!tableId) {
            return;
        }
        if (parameter) {
            $('#' + tableId).bootstrapTable('refreshOptions', parameter);
        } else {
            var option = $('#' + tableId).bootstrapTable('getOptions', '');
            $('#' + tableId).bootstrapTable('refreshOptions', option);
        }

    }
</script>
</html>