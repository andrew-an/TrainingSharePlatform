<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<Link rel="stylesheet" type="text/css" href="style5.css"/>
	<link rel="stylesheet" type="text/css" href="jquery.datetimepicker.css"/>
	<title>创建新主题</title>
	<script>
		function Save(membersId)
		{
			var mytitle = document.getElementById("mytitle").value;
			var time = document.getElementById("datetimepicker").value;
			var meetingroom="";
			var radio = document.getElementsByName("location");  
		    for (i=0; i<radio.length; i++) {  
		        if (radio[i].checked) {  
		        	meetingroom = radio[i].value;
		        	break;
		        }  
		    } 
		    
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
							alert("新建主题成功！");
						}
						else
						{
							alert("新建主题失败！");
						}
					}
				}
			}
			alert(mytitle);
			xmlhttp.open("POST", "newmytitleservlet?membersId="+membersId+"&mytitle="+mytitle+"&time="+time+"&roomnumber="+meetingroom, true);
			xmlhttp.send();
		}
	</script>
	<% 
	    String membersId = request.getParameter("membersId");
	%>
</head>
<body onload="">
	<div id="head">
		<label id="title">创建新主题</label>
	</div>
	<div id="wrapper">
		<div class="mytitle">
	    	<label style="margin-left: 5px;margin-top:5px;color: black;font-size: 20px">主题名称:</label><br>
	    	<textarea id="mytitle" name="title" rows="1" style="margin-left:5px;width:95%;margin-top:10px;font-size:20px;"></textarea>
	    </div>
	    
	    <div class="starttime">
    		<label style="margin-left: 5px;color: black;font-size: 20px">开始时间:</label>
    		<!-- <input type="datetime-local" id="starttime" name="starttime" style="margin-top:10px"/> -->
    		<input id="datetimepicker" name="datetimepicker" type="text" >
    	</div>
    	
        <div class="location">
    		<label style="margin-left:5px;margin-top:5px;color: black;font-size: 20px">地点:</label>
    		<input type="radio" value="A31" name="location" checked style="font-size: 20px;margin-top:10px;"/>A31
    		<input type="radio" value="A32" name="location"  style="font-size: 20px"/>A32
    		<input type="radio" value="A33" name="location"  style="font-size: 20px"/>A33
    		<input type="radio" value="A21" name="location"  style="font-size: 20px"/>A21
    		<input type="radio" value="A22" name="location"  style="font-size: 20px"/>A22
    		<input type="radio" value="A23" name="location"  style="font-size: 20px"/>A23
    		<input type="radio" value="pending" name="location"  style="font-size: 20px"/>待定
    	</div>
    	<div class="mybutton">
	    	<button type="button"  class="button" style="margin-right: 30px" onclick="Save(<%=membersId%>);">保存</button>
	    	<button type="button" class="button" onclick="javascript:history.go(-1);">取消</button>
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
   		$('#datetimepicker').datetimepicker({lang:'ch'});
   		$('#datetimepicker').datetimepicker({value:new Date(),step:10});
	</script>
</html>