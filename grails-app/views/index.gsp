<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2014/10/24
  Time: 14:39
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link href="${g.resource([ dir: "/css", file: "bootstrap.min.css"])}" rel="stylesheet" type="text/css"/>
    <link href="${g.resource([dir: "/css",file: "login.css"])}" rel="stylesheet" type="text/css"/>

</head>

<body>
<div class="container">

    <div class="row" style="margin-top:20px">
        <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
            <form  role="form" >
                <fieldset>
                    <h2>管理员登陆</h2>
                    <hr class="colorgraph">
                    <div class="form-group">
                        <input type="text" name="user.loginName" id="username" class="form-control input-lg"
                               placeholder="用户名" autofocus>
                    </div>
                    <div class="form-group">
                        <input type="password" name="user.pwd" id="password" class="form-control input-lg"
                               placeholder="密码">
                    </div>

                    <div class="row">
                        %{--<div class="col-xs-6 col-sm-6 col-md-6">--}%
                            %{--<input type="text" name="ValidateCode" id="ValidateCode" class="form-control input-lg"--}%
                                   %{--placeholder="验证码">--}%
                        %{--</div>--}%
                        %{--<div class="col-xs-3 col-sm-3 col-md-3">--}%
                            %{--<img src="image.jsp" onclick="this.src='image.jsp?date='+new Date();" title="点击重新获取验证码"/>--}%
                        %{--</div>--}%
                        <div class="col-xs-3 col-sm-3 col-md-3">
                            <div class="btn btn-lg btn-warning btn-block"><input id="RememberMe" type="checkbox"
                                                                                 name="RememberMe"
                                                                                 onclick="RememberMeClick()"><label
                                    for="RememberMe"> 记住账号</label></div>
                        </div>
                    </div>

                    <hr class="colorgraph">
                    <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <input type="submit" class="btn btn-lg btn-success btn-block" value="登陆">
                        </div>
                        %{--<div class="col-xs-6 col-sm-6 col-md-6">--}%
                            %{--<a href="" class="btn btn-lg btn-primary btn-block">注册</a>--}%
                        %{--</div>--}%
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>
</body>
</html>