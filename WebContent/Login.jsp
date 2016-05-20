<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="javax.servlet.http.Cookie"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>登录界面</title>
	<link rel="stylesheet" type="text/css" href="style1.css">
	<script type="text/javascript">
		/*function refresh(){
   			var user = document.getElementById("username");
   			user.value = "";
   			var pwd = document.getElementById("password");
   			pwd.value = "";
		}
		window.onload = refresh;*/
		function ChangePassword(src)
		{
			var openee = window.open (src+"?username=andrew","newwindow", 'height='+250+',,innerHeight='+250
						+',width='+400+',innerWidth='+400+',top='+window.screen.height/2.5+',left='
						+window.screen.width/2.5+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');   
		}   
	</script>
	<%
		String error = (String)request.getParameter("errorinfo");
		if(null != error && error.equals("login_faild"))
		{
			error = "用户名或密码错误";
		}
		else
		{
			error=" ";
		}
		
		//System.out.println(error);
	    String userName = "";
		String password = "";
		Cookie[] cookies = request.getCookies();
		if(cookies.length>0)
		{
			for(Cookie ck:cookies)
			{
				if(ck.getName().equals("username"))
				{
					userName = ck.getValue();
					if(!password.equals(""))
						break;
				}
				else if(ck.getName().equals("password"))
				{
					password = ck.getValue();
					if(!userName.equals(""))
						break;
				}
			}
		}
	%>
</head>
<body>
<body>
	<div id="head">
		<h1 >Wearable内部培训分享平台</h1>
	</div>
	<div id="wrapper">
 		<div class="left">
			<div class="left_top"></div>
			<div class="left_bottom"><img src="images/logo.png" /></div>
		</div>

		<div class="right">
			<div class="right_top"></div>

			<div class="right_center">
			<!-- <div style="background-color: gray;height: 33%"></div><div style="background-color: green;height: 33%"></div><div style="background-color: black;height: 33%"></div> -->


				<div class="right_center1"></div>
				<div class="right_center2">
					<div style="padding: 10px;"></div>
					<div class="logincontent">
					    <form action="loginClServlet" method="post" >
						           欢迎登录<br><br>
							用户名：<input type="text" id="username" name="username" value=<%=userName %>><br><br>
							密&nbsp码：<input type="password" style="margin-bottom:10px" id="password" name="password" value=<%=password %>><br>
							<label style="display:inline-block;color:red;margin-bottom:5px;padding:0px"><%=error %></label><br>
							记住密码<input type="checkbox" value="on" name="checkbox_keeppwd" <%=userName!=""?"checked":"" %>>
							自动登录<input type="checkbox" value="on" name="checkbox_autologin"><br><br>
							<input type="submit" value="登   录" style="width:80px;height:30px;font-size: 15;margin-right:30px" >
							<input type="button" value="修改密码" style="width:80px;height:30px;font-size: 15" onclick="ChangePassword('ChangePassword.jsp','修改密码','400','200')">	    	
					    </form>
					</div>
				</div>
				<div class="right_center3"></div>
			</div>

			<div class="right_bottom"></div> 


		</div>
	</div>
	<div id="footer" style="text-align: center;">
	    Copyright © Goertek.com, All Rights Reserved
	</div>
</body>
</body>
</html>