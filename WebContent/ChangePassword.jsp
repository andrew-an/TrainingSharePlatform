<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	 <style type="text/css">
		.input{
		border-color:#FF0000;
		border-style:solid;
		}
	</style>
	<script>
		var user = opener.document.getElementById("username").value;
		
		function cancel()
		{
			window.close();
		}
		function checkInputValidity()
		{
			var warning = document.getElementById("warning");
			var username = document.getElementById("username");
			var password_old = document.getElementById("password_old");
			var password_new = document.getElementById("password_new");
			var password_again = document.getElementById("password_again");
			//判断所有输入项是否都不为空值
			if(null!=username.value && username.value!="")
			{
				username.className="";
				if(null!=password_old.value && password_old.value!="")
				{
					password_old.className="";
					if(null!=password_new.value && password_new.value!="")
					{
						password_new.className="";
						if(null!=password_again.value && password_again.value!="")
						{
							password_again.className="";
							//先判断原密码是否正确
							validatePwd(username.value, password_old.value,password_new.value, password_again.value);
						}
						else
						{
							password_again.className="input";
						}
					}
					else
					{
						password_new.className="input";
					}
				}
				else
				{
					password_old.className="input";
				}
			}
			else
			{
				username.className="input";
			}
		}
		
		function validatePwd(uname, pwd_old, pwd_new, pwd_again)
		{
			var xmlhttp;
			if(window.XMLHttpRequest)
			{
				xmlhttp = new XMLHttpRequest();
			}
			else
			{
				xmlhttp = new ActivityXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function()
			{
				if(xmlhttp.readyState==4 && xmlhttp.status == 200)
				{
					alert(xmlhttp.responseText);
					if(xmlhttp.responseText == "success")
					{
						alert("ok");
						//判断原密码与新密码是否相同
						if(pwd_old != pwd_new)
						{
							if(pwd_new == pwd_again)
							{
								window.location.href="changepasswordservlet";
							}
							else
								alert("两次输入密码不相同");
						}
						else
						{
							alert("原密码与新密码不能相同！");
						}
					}
					//window.location.href="changepasswordservlet";
				}
			}
			xmlhttp.open("POST","changepasswordservlet?username="+uname+"&passwordold="+pwd_old,true);
			xmlhttp.send();
		}
	</script>
	<%
		String result = (String)request.getAttribute("result");
		if(null != result)
		{
			if(result.equals("success"))
			{
				out.println("密码更改成功！");
			}
			else
			{
				out.println("密码更改失败");
			}
		}
		
	%>
<title>Insert title here</title>
</head>
<body>
	<form action="changepasswordservlet" method="post">
		<div style="text-align:center;margin:auto">
			<br>
			用  户  名: <input type="text" id="username" name="username" value=""><br><br>
			原  密  码: <input type="password" id="password_old" name="password_old" value=""><br><br>
			新  密  码: <input type="password" id="password_new" name="password_new" value=""><br><br>
			再输一次: <input type="password" id="password_again" name="password_again" value=""><br><br>
			<button onclick="checkInputValidity()" style="margin-right:20px;width:60px;height:30px;font-size: 13">确定</button>
			<button onclick="cancel()" style="width:60px;height:30px;font-size: 13">取消</button><br>
		</div>
		<script>
			//document.all["username"].value = user;
		</script>
	</form>
</body>
</html>