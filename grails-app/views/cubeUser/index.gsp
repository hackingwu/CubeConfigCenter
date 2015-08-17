<%--
  Created by IntelliJ IDEA.
  User: wuzj
  Date: 2014/10/24
  Time: 14:39
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link href="${g.resource([dir: "/css", file: "bootstrap.min.css"])}" rel="stylesheet" type="text/css"/>
    <link href="${g.resource([dir: "/css", file: "login.css"])}" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${g.resource([dir: "/js", file: "jquery-2.1.3.min.js"])}"></script>

</head>

<body>
<div class="container">

    <div class="row" style="margin-top:20px" id="main">
        <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
            <form role="form">
                <fieldset>
                    <h2>管理员登陆</h2>
                    <hr class="colorgraph">

                    <div class="form-group">
                        <input type="text" name="login" id="login" class="form-control input-lg"
                               placeholder="用户名" autofocus>
                    </div>

                    <div class="form-group">
                        <input type="password" name="password" id="password" class="form-control input-lg"
                               placeholder="密码">
                    </div>

                    <hr class="colorgraph">

                    <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <input type="button" class="btn btn-lg btn-success btn-block" value="登陆" onclick="submitForm()">
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>

    </div>
    <div class="span6 offset3" id="error" style="display: none;text-align: center;font-size: large">用户名或密码错误</div>
</div>
<script type="text/javascript" src="${g.resource([dir: "/js", file: "jquery.md5.js"])}"></script>
<script type="text/javascript">
    function submitForm() {
        var login = $("#login").val();
        var password = $("#password").val();
        password = $.md5(password);
        $.ajax({
            url:"${g.createLink([controller: "cubeUser",action: "login"])}",
            type:"post",
            data:{
                login:login,
                password: password
            },
            success:function(data){
                var result = JSON.parse(data)
                if(result.success){
                    window.location.href="<g:createLink controller="configCenter" action="index"/> ";
                }else{
                    $("#error").fadeIn(1000).fadeOut(2000)
                }
            }
        })
    }
</script>
</body>
</html>