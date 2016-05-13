<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>主界面</title>
	<link rel="stylesheet" type="text/css" href="style2.css">
	<script type="text/javascript">
	    function CreateNewActivity(){
	    	
	    	
	    }
	</script>
</head>
<body>
	<div id="head">
        <h2 style="text-align: center;color: orange;margin-top:3px">Wearable内部培训分享平台</h2>
        <label id="loginUser"><%=session.getAttribute("userName") %>&nbsp<%=session.getAttribute("workNumber") %></label>
        <button name="addNewActivity" onclick="window.location.href='NewActivity.jsp'">create</button>
	</div>
	<div id="wrapper">
        <div class="main">
 			<!--<div class="activity">
				<img class="img_title_logo" src="images/titlelogo.png"/>
				<a class="activity_title_new" href=""></a>
				<img class="img_title_status" src="images/new.png"/>
			</div>
			<div class="activity">
				<img class="img_title_logo" src="images/titlelogo.png"/>
				<a class="activity_title_old" href=""></a>
			</div> -->
			
			<%
		    	ArrayList titleList = (ArrayList)session.getAttribute("activityTitle");//"Wearable 第二季度内部培训分享会";
		    	Iterator it = titleList.iterator();
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
						    <a class="activity_title_new" href=""><%= titleName%></a>
						    <img class="img_title_status" src="images/new.png"/>
						</div>
		    <%
			    	}
			    	else
			    	{
			%>
				    	<div class="activity">
						    <img class="img_title_logo" src="images/titlelogo.png"/>
							<a class="activity_title_old" href=""><%= titleName%></a>
						</div>
		    <%
			    	}
		   		}
			%>
			
			
		</div>
		<div class="side">
			
		</div>
	</div>
	<div id="footer">

	</div>
</body>
</html>