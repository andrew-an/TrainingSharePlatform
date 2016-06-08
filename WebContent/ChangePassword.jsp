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
		String.prototype.trim = function() 
		{
			return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		}
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
			//判断用户名输入是否为空
			if(null!=username.value && username.value!="")
			{
				username.className="";
				//判断原密码输入是否为空
				if(null!=password_old.value && password_old.value.trim()!="")
				{
					password_old.className="";
					//判断新密码输入是否为空
					if(null!=password_new.value && password_new.value.trim()!="")
					{
						password_new.className="";
						if(null!=password_again.value && password_again.value.trim()!="")
						{
							password_again.className="";
							//判断新旧密码是否不同
							if(password_old.value.trim() != password_new.value.trim())
							{
								//判断两次输入的新密码输入是否相同
								if(password_new.value.trim() == password_again.value.trim())
								{
									//判断原密码是否正确
									validatePwd(username.value.trim(), password_old.value,password_new.value.trim(), password_again.value.trim());
								}
								else
								{
									alert("两次新密码输入不一致！");
								}
							}
							else
							{
								alert("新旧密码不能相同！");
							}
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
				if(xmlhttp.readyState==4)
				{
					if(xmlhttp.status == 200)
					{
						if(xmlhttp.responseText == "success")
						{
							//window.location.href = "changepasswordservlet";
							changePwd(uname, pwd_new);
						}
						else
						{
							alert("原密码输入不正确！");
						}
					}
				}
			}
			xmlhttp.open("POST","changepasswordservlet?uname="+uname+"&pwd_old="+pwd_old,true);
			xmlhttp.send();
		}
		function changePwd(uname, pwd_new)
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
				if(xmlhttp.readyState==4)
				{
					if(xmlhttp.status == 200)
					{
						if(xmlhttp.responseText == "success")
						{
							alert("密码修改成功");
							window.close();
						}
						else
						{
							alert("密码修改失败");
						}
					}
				}
			}
			xmlhttp.open("POST","changepasswordservlet?uname="+uname+"&pwd_new="+pwd_new,true);
			xmlhttp.send();
		}
	</script>
	<%
		//String result = (String)request.getAttribute("return");
		//if(null != result)
		//{
		//	if(result.equals("success"))
		//	{
		//		out.println("密码更改成功！");
		//	}
		//	else
		//	{
		//		out.println("密码更改失败");
		//	}
		//}
	%>
<title>Insert title here</title>
</head>
<body>
	<!-- <form action="" method="post"> -->
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
			document.all["username"].value = user;
		</script>
	<!-- </form> -->
</body>
</html>