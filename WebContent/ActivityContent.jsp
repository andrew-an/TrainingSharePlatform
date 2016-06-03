<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*,com.trainingshare.model.*,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="style4.css">
<title>活动内容</title>
	<% 
		String title = (String)request.getAttribute("titlename");
		String uname = (String)session.getAttribute("username");
	    if(null == uname || uname.equals(""))
	    {
	    	response.sendRedirect("Login.jsp");
	    }
	%>
    <script type="text/javascript" language="javascript" charset="utf-8">
     
    //更新当前登录人的活动内容
      function UpdateActivityContent(obj,str1,str2,membersId,loginUser)
      {
	      //先插入数据库，再更新显示
	      var xmlhttp;
		  if(window.XMLHttpRequest)
		  {
			  xmlhttp = new XMLHttpRequest();
		  }
		  else
		  {
			  xmlhttp=new ActivityXObject("Microsoft.XMLHTTP");
		  }
		  xmlhttp.onreadystatechange = function()
		  {
			  if(xmlhttp.readyState==4 && xmlhttp.status == 200)
			  {
				  obj.innerHTML = str2;//数据库更新完成，则显示更改后的值
			  }
		  }
		  xmlhttp.open("POST","ActivityContentClServlet?membersId="+membersId
				  +"&loginUser="+loginUser
				  +"&activityContentBefore="+str1
				  +"&activityContent="+str2
				  ,true);
		  xmlhttp.send();
      }
	
      //上传文件并且提交表单
	function uploadAndSubmit(membersId,loginUser)
	{	
		//alert(filename);
	    var row = document.activeElement.parentNode.parentNode.parentNode;
	    //alert(row.nodeName);
	    if(null != row && row.nodeName == "TR")
	    {
	    	//alert(row.cells[1].innerText);
	    	//取得当前用户名称
			var user = document.getElementById("loginUser").innerHTML;				
			user = user.slice(user.indexOf(":")+1,user.length);
			
			//上传成功后执行
			var uploadSuccess = function(data,xhr)
			{
				if(data == "上传成功!")
				{
					document.activeElement.parentNode.childNodes[3].innerText = "点击更新";
					row.cells[2].childNodes[1].innerText = file.name;
				}
				alert(data);
			}
			//上传过程中执行
			var uploadProgress = function(event,position,total,percent)
			{
				 console.log(percent);
			}
			
			var formData = new FormData();
			var file = document.activeElement.files[0];
			var filename = encodeURI(encodeURI(file.name));
			formData.append('upload', file);
			var xhr;
			if(window.XMLHttpRequest)
			{
				xhr = new XMLHttpRequest();
			}
			else if(window.ActiveXObject)
			{
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var titlename = row.cells[1].innerText;
			//去掉会议室和时间字段
			titlename = titlename.substring(0,titlename.indexOf("会议室"));
			titlename = encodeURI(encodeURI(titlename));
			xhr.open('POST', "ActivityContentClServlet?membersId="+membersId
						  +"&loginUser="+loginUser
						  +"&fileName=" + filename
						  +"&activityContent="+titlename);
			xhr.upload.onloadstart = function(){
					//document.getElementById("bytesTotal").textContent = file.size;
			}
			//上传进度
			xhr.upload.onprogress = function(event)
			{
				var percent = 0,position = event.loaded || event.position,total = event.total;
				if (event.lengthComputable) 
				{
					percent = Math.ceil(position / total * 100);
				}
				uploadProgress(event,position,total,percent);
			};
			//上传结果
			xhr.onload = function()
			{
				if (xhr.readyState === 4)
				{
					if (xhr.status === 200)
					{
						uploadSuccess(xhr.responseText, xhr);
					}
				}
			};
			xhr.send(formData);
			return false;
	    }
		
	}
	
	//下载某成员上传的文件
	function UploadMemberUploadFile(membersid,membername)
	{
		var form = document.forms[0];
		if(null !== form && undefined !==form)
		{
			form.action = "zipdownloadservlet?membersId="+membersid+"&membername="+membername;
			form.submit();
		}
	}
	
	function AddNewContent(src)
	{
		var openee = window.open (src,"newwindow", 'height='+400+',,innerHeight='+400
				+',width='+550+',innerWidth='+550+',top='+window.screen.height/5+',left='
				+window.screen.width/3.5+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no'); 
	}
	function EditNewContent(src)
	{
		var openee = window.open (src,"newwindow", 'height='+400+',,innerHeight='+400
				+',width='+550+',innerWidth='+550+',top='+window.screen.height/5+',left='
				+window.screen.width/3.5+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no'); 
	}
</script>
</head>
<body>
	<div style="float:right;margin-right:10px;">
		<a href="javascript:history.go(-1);" style="font-size:14px;z-index:1;text-decoration:none" >返回</a>
		<a href="Login.jsp?relogin=true" style="font-size:14px;text-decoration:none">退出登录</a>
	</div>

	<div id="head">
    	<label id="activitytitle"><%=title%></label><br>
    	<label id="loginUser">登录用户:<%=uname%></label>
    </div>
    <div id="wrapper">
    	<form name="upForm" method="post" enctype="multipart/form-data">    	
			<table class="imagetable" id="mytable">
				<tr>
					<th style="width: 10%;font-size:20px">参与人</th>
					<th style="width: 70%;font-size:20px">培 训 主 题</th>
					<th style="width: 20%;font-size:20px">资 料 上 传</th>
				</tr>
				<% 
				    String MembersId = (String)request.getAttribute("membersId");
				    ArrayList<ArrayList<String>> al = (ArrayList<ArrayList<String>>)(request.getAttribute("activityContentList"));
				    if(null!=al && al.size()>0)
				    {
				    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
				    	Date today = new Date();
				    	String strtoday = sdf.format(today);
				    	
					    Iterator<ArrayList<String>> it = al.iterator();
					    while(it.hasNext())
					    {
					    	ArrayList<String> activityContentList = new ArrayList<String>();
					    	activityContentList = (ArrayList<String>)it.next();
					    	String memberName = activityContentList.get(0);
					    	String titleName = activityContentList.get(1);
					    	String meetingRoom = activityContentList.get(2);
					    	String startTime = activityContentList.get(3).substring(0,16);
					    	String filePath = activityContentList.get(4);
					    	String uploadFlag = activityContentList.get(5);
					    	
					    	long minutes=0;
					    	String strdays="";
					    	String strhours="";
					    	String strminutes="";
					    	String leftTime="";
					    	if(startTime.compareTo(strtoday)>0)
					    	{
					    	  	minutes = (sdf.parse(startTime).getTime()-today.getTime())/1000/60;
						    	long days = minutes/(60*24);
						    	strdays = String.valueOf(days);
						    	long hours = (minutes-days*24*60)/60;
						    	strhours = String.valueOf(hours);
						    	minutes = minutes%60;
						    	strminutes = String.valueOf(minutes);
						    	leftTime = "距离开始还有:"+(days>0?(strdays+"天"):"");
						    	leftTime += hours>0?(strhours+"小时"):"";
						    	leftTime += minutes>0?(strminutes+"分钟"):"";
						    	
					    	}
					    	else
					    	{
					    		minutes = (today.getTime()-sdf.parse(startTime).getTime())/1000/60;
					    		//默认会议进行3小时
					    		if(minutes<=180)
					    		{
					    			leftTime = "已开始";
					    		}
					    		else
					    		{
					    			leftTime = "已结束";
					    		}
					    	}
				%>
						    <tr id="contentname<%=memberName.equals(uname)?uname:"" %>">
								<td id="membername"><strong><%=memberName%></strong></td>
								<td ondblclick="<%=memberName.equals(uname)?"EditNewContent('MyNewTitle.jsp?membersId="+MembersId+"&title="+titleName+"&meetingroom="+meetingRoom+"&starttime="+startTime+"')":null %>">
									<label id="title" style="font-size:20px;font-weight:600;color:<%=memberName.equals(uname)?"red":"blue" %>"> <%= titleName %> </label><br>
									<label id="location" style="display:inline-block;margin-top:8px;font-size:14px;color:black;font-style:italic">会议室: <%=meetingRoom %> /</label>
									<label id="starttime" style="display:inline-block;margin-top:8px;font-size:14px;color:black;font-style:italic">开始时间: <%=startTime %></label> 
									<img style="width:10px;margin-left:10px" src="images//<%=leftTime!="已结束"?"green.png":"red.png"%>">
									<label style="font-size:10px"><%=leftTime%></label>
									</img>
								</td>
				<%
								String filename = "未上传";
								String buttonName = "点击上传";
						        if(uploadFlag.equals("1"))
						        {
						        	filename = filePath.substring(filePath.lastIndexOf("\\")+1,filePath.length());
						        	if(memberName.equals(uname))
						        	{
						        		buttonName = "点击更新";
						        	}
						        	else
						        	{
						        		buttonName = "点击下载";
						        	}
						        }
				%>			
								<td>
									<label id="filepath" style="display:inline-block;margin-bottom:5px;"><%=filename %></label><br>
									
									<a style="display:<%=memberName.equals(uname)?"inline-block":"none" %>" class="a-upload">
										<input type="file" id="upFile" name="upFile" onchange="uploadAndSubmit('<%=MembersId %>','<%=uname %>','<%= filename%>');">
										<label id="buttonname"><%=buttonName %></label>
									</a>
									
									<a style="display:<%=!memberName.equals(uname)&&!filename.equals("未上传")?"inline-block":"none" %>" class="a-upload">										
											<input type="submit" onclick="UploadMemberUploadFile('<%=MembersId %>','<%=memberName %>')"/>
											<label><%=buttonName %></label>
									</a>
									
								</td>
							</tr>
				<%
					    }
				    }
				%>
			</table>
		</form>
		<br>
		<div style="width:85%; float:left">
			<a href="" style="margin-left:50%" 
			onclick="AddNewContent('MyNewTitle.jsp?membersId=<%=MembersId%>')">
			<img alt="" src="images/addnewcontent.png">
			</a>
		</div>
		<div style="width:15%; float:right;margin-top:10px;padding-left:0px;">
			<form  action="zipdownloadservlet?membersId=<%=MembersId%>" method="post">
				<button id="LoadAllPackage">下载全部附件 </button>
			</form>
		</div>

		
    </div>
    
    <div id="footer">
    </div>
</body>
</html>