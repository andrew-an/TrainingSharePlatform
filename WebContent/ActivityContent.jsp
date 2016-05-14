<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*,com.trainingshare.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="style4.css">
<title>活动内容</title>
</head>
<body>
	<div id="head">
    	<label>活动参与详情</label>
    </div>
    <div id="wrapper">
    	<table class="imagetable">
			<tr>
				<th style="width: 15%;font-size:20px">参 与 人</th>
				<th style="width: 70%;font-size:20px">培 训 主 题</th>
				<th style="width: 15%;font-size:20px">资 料 上 传</th>
			</tr>
			<% 
			    ArrayList al = (ArrayList)request.getAttribute("activityContentList");
			    Iterator it = al.iterator();
			    while(it.hasNext())
			    {
			    	ArrayList activityContentList = new ArrayList();
			    	activityContentList = (ArrayList)it.next();
			%>    	
				    <tr>
						<td><%=activityContentList.get(0) %></td>
						<td><input type="text" value=<%=activityContentList.get(1) %> /></td>
			<%
					String name = "未上传";
					String imagename = "";
			        if(null!=activityContentList.get(3))
			        {
			        	name = "";
			        	imagename = "images/file_complete.png";   	
			        }
			%>			
						<td><%=name%><img src="<%=imagename%>"></td>
					</tr> 
			<%
			    }			
			%> 



		</table>
    </div>
    <div id="footer">

    </div>
</body>
</html>