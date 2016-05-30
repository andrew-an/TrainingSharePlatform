<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*,java.text.*,com.trainingshare.db.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<Link rel="stylesheet" type="text/css" href="style5.css"/>
	<link rel="stylesheet" type="text/css" href="jquery.datetimepicker.css"/>
	<title>创建新主题</title>
	<script>
	
		//新建或更新主题
		function Save(membersId)
		{
			var titleoriginal = document.getElementById("titleoriginal").innerHTML;
			var mytitle = document.getElementById("mytitle").value;
			var time = document.getElementById("datetimepicker").value;
			var meetingroom="";
			var radio = document.getElementsByName("location");  
		    for (i=0; i<radio.length; i++) {  
		        if (radio[i].checked)
		        {  
		        	meetingroom = radio[i].value;
		        	break;
		        }  
		    }
		    //检查输入项的合法性
		    if(mytitle=="")
	    	{
	    		alert("请先输入标题！");
	    	}
		    else if(time=="")
	    	{
	    		alert("开始时间不能为空！");
	    	}
		    else
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
							opener.location.reload();
							var flag=false;
							switch(xmlhttp.responseText)
							{
							case "save_success":
								flag = !confirm("创建成功，继续创建主题吗？");
								break;
							case "edit_success":
								alert("更新成功！");
								flag=true;
								break;
							case "save_failed":
								alert("创建失败！");
								break;
							case "edit_failed":
								alert("更新失败！");
								break;
							case "title exist":
								alert("主题已存在，请勿重复插入！");
								break;
							default:
								break;
							}
							if(flag)
								window.close();
						}
					}
				}
				xmlhttp.open("POST", "newmytitleservlet?membersId="+membersId+"&mytitle="+mytitle+"&titleoriginal="+titleoriginal+"&time="+time+"&roomnumber="+meetingroom, true);
				xmlhttp.send();
		    }
		}
		
		//删除主题
		function DeleteTitle(membersId)
		{
			var mytitle = document.getElementById("mytitle").value;
			if(mytitle=="")
	    	{
	    		alert("标题不能为空！");
	    	}
			else
			{
				if(confirm("确定要删除该主题吗？"))
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
								opener.location.reload();
								var flag=false;
								switch(xmlhttp.responseText)
								{
								case "remove_success":
									alert("删除成功！");
									flag=true;
									break;
								case "remove_failed":
									alert("删除失败！");
									break;
								default:
									break;
								}
								if(flag)
									window.close();
							}
						}
					}
					xmlhttp.open("POST", "newmytitleservlet?removeflag=true&membersId="+membersId+"&mytitle="+mytitle, true);
					xmlhttp.send();	
				}
			}
		}
	</script>
	<% 
	    String membersId = request.getParameter("membersId");
		String title = request.getParameter("title");
		if(null!=title)
			title = new String(title.getBytes("iso-8859-1"),"utf-8");
		else
			title = "";
		
		String meetingRoom = request.getParameter("meetingroom");
		if(null!=meetingRoom)
			meetingRoom = new String(meetingRoom.getBytes("iso-8859-1"),"utf-8");
		else
			meetingRoom = "待定";
		
		String startTime = request.getParameter("starttime");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		if(null==startTime)
		{
			startTime = formatter.format(new Date());
		}
	%>
</head>
<body onload="">
	<div id="head">
		<label id="title">创建新主题</label>
	</div>
	<div id="wrapper">
		<div class="mytitle">
	    	<label style="margin-left: 5px;margin-top:5px;color: black;font-size: 20px">主题名称:</label><br>
	    	<textarea id="mytitle" name="title" rows="1" style="margin-left:5px;width:95%;margin-top:10px;font-size:20px;"><%=title %></textarea>
	    	<label id="titleoriginal" style="display:none"><%=title %></label>
	    </div>
	    <div class="starttime">
    		<label style="margin-left: 5px;color: black;font-size: 20px">开始时间:</label>
    		<!-- <input type="datetime-local" id="starttime" name="starttime" style="margin-top:10px"/> -->
    		<input id="datetimepicker" name="datetimepicker" value='<%=startTime%>' type="text" >
    	</div>
    	
        <div class="location">
        	<label style="margin-left:5px;margin-top:5px;color: black;font-size: 20px">地点:</label>
        	<%
        	    ArrayList<String> meetingRoomList = new ArrayList<String>();
	        	meetingRoomList = new DBConnect().GetAllMeetingRooms();
	        	if(meetingRoomList.size()>0)
	        	{
	        		for(int i=0; i<meetingRoomList.size(); i++)
	        		{
	        			String roomName = meetingRoomList.get(i);
	        %>
	        			<input type="radio" value="<%=roomName %>" name="location" style="font-size: 20px;margin-top:10px;" <%=meetingRoom.equals(roomName)?"checked":"" %>/><%=roomName %>
	        <%
	        		}
	        		
	        	}
        	%>
    	</div>
    	<div class="mybutton">
	    	<button type="button"  class="button" style="margin-right:30px;" onclick="Save(<%=membersId%>);">保存</button>
	    	<button type="button" class="button" style="margin-right:30px;" onclick="javascript:window.close();">取消</button>
	    	<button type="button" class="button" style="display:<%=title.equals("")?"none":""%>; width:120px" onclick="DeleteTitle(<%=membersId%>);">删除该主题</button>
	    </div>
	</div>
	<div id="footer">
	
	</div>
	<form>
		
	</form>
</body>
	<script src="./jquery.js"></script>
	<script src="build/jquery.datetimepicker.full.js"></script>
	<script>
		/*$('#datetimepicker').datetimepicker({
		      lang:"ch",           //语言选择中文
		      format:"Y-m-d H:m",//格式化日期
		      timepicker:true,     //关闭时间选项
		      yearStart:2016,      //设置最小年份
		      yearEnd:2050,        //设置最大年份
		      todayButton:true,    //关闭选择今天按钮
		      step:10
		});*/
   		$('#datetimepicker').datetimepicker({step:10});
	</script>
</html>