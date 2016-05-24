<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>主界面</title>
	<link rel="stylesheet" type="text/css" href="style2.css">
	<% 
		String uname = (String)request.getAttribute("userName");
	    if(null == uname || uname.equals(""))
	    {	
	    	response.sendRedirect("Login.jsp");
	    }
	    String adminFlag = (String)request.getAttribute("administratorFlag");
	%>
</head>
<body>
	<div style="float:right;margin-right:10px;">
		<!-- <a href="Login.jsp" style="font-size:14px;z-index:1;text-decoration:none">返回</a> -->
		<a href="Login.jsp?relogin=true" style="font-size:14px;text-decoration:none">退出登录</a>
	</div>
	<div id="head">
        <h2 style="text-align: center;color: orange;margin-top:3px">Wearable内部培训分享平台</h2>
        <label id="loginUser">登录用户:<%=uname%></label>
        <button name="addNewActivity" style="display:<%=null==adminFlag||adminFlag=="0"?"none":""%>" onclick="window.location.href='NewActivity.jsp'">create</button>
	</div>
	<div id="wrapper">
        <div class="main">
			<form action="" method="post">
				<%
			    	ArrayList<String> titleList = (ArrayList<String>)request.getAttribute("activityTitle");//"Wearable 第二季度内部培训分享会";
			    	if(titleList != null)
			    	{
			    		Iterator<String> it = titleList.iterator();		    		
				    	while(it.hasNext())
				   		{
					    	String title = (String)it.next();
					    	String titleName = title.substring(0,title.indexOf(","));
					    	String completeFlag = title.substring(title.indexOf(",")+1, title.indexOf(",")+2);
					    	
					    	if(completeFlag.equals("0"))
					    	{
				%>
							<div class="activity">
							    <img class="img_title_logo" src="images/titlelogo.png"/>
							    <a class="activity_title_new" href="mainclservlet?username=<%=uname %>&title=<%=titleName %>"><%= titleName%></a>
							    <img class="img_title_status" src="images/new.png"/>
							</div>
			    <%
					    	}
					    	else
					    	{
				%>
					    	<div class="activity">
							    <img class="img_title_logo" src="images/titlelogo.png"/>
								<a class="activity_title_old" href="mainclservlet?username=<%=uname %>&title=<%=titleName %>"><%= titleName%></a>
							</div>
			    <%
					    	}
				   		}
			    	}
				%>
			</form>
		</div>
		<div class="side">
			
		</div>
	</div>
	<div id="footer">

	</div>
</body>
</html>