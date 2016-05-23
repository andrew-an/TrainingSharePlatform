<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<Link rel="stylesheet" type="text/css" href="style3.css"/>
<title>创建新活动</title>
<script type="text/javascript">
    function window_load()
    {
    	var myDate = new Date();
    	document.getElementById("datetime-starttime").valueAsDate  = myDate;
    	document.getElementById("datetime-endtime").valueAsDate  = myDate.setDate(myDate.getDate()+10);

    	var div = document.getElementById("activity_members");
	    var oInput = div.getElementsByTagName("input");
		var oLabel = div.getElementsByTagName("label")[1];
		var isCheckAll = function ()
		{
			for (var i = 1, n = 0; i < oInput.length; i++)
			{
				oInput[i].checked && n++	
			}
			oInput[0].checked = n == oInput.length - 1;
			oLabel.innerHTML = oInput[0].checked ? "全不选" : "全选&nbsp"
		};
		//全选/全不选
		oInput[0].onclick = function ()
		{
			for (var i = 1; i < oInput.length; i++)
			{
				oInput[i].checked = this.checked			
			}
			isCheckAll()
		};
		//根据复选个数更新全选框状态
		for (var i = 1; i < oInput.length; i++)
		{
			oInput[i].onclick = function ()	
			{
				isCheckAll();
			}	
		}
    }
</script>
</head>
<body onload="window_load()">
    <form action="newactivitycl" method="post">
	    <div style="float:right;margin-right:10px;">
			<a href="Main.jsp" style="font-size:14px;z-index:1;text-decoration:none">返回</a>
			<a href="Login.jsp?relogin=true" style="font-size:14px;text-decoration:none">退出登录</a>
		</div>
	    <div id="head">
	    	<label>新建活动</label>
	    </div>
	    <div id="wrapper">
	    	<div class="activity_title">
	    		<label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">标题</label><br>
	    		<textarea name="activitytitle" style="width: 95%;height: 40%;bottom: 5px; margin-left:15px;margin-top: 5px;font-size: 20px"></textarea>
	    	</div>
	    	<div class="activity_content">
	    		 <label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">内容</label><br>
	    		<textarea name="activitydetails" style="width: 95%;height: 75%;bottom: 5px; margin-left:15px;margin-top: 5px;font-size: 20px"></textarea>
	    	</div>
	    	<div class="activity_location">
	    		<label style="margin-left:15px;margin-top:5px;color: black;font-size: 25px">地点</label>
	    		<input type="radio" value="A31" name="location" checked style="font-size: 20px"/>A31
	    		<input type="radio" value="A32" name="location"  style="font-size: 20px"/>A32
	    		<input type="radio" value="A33" name="location"  style="font-size: 20px"/>A33
	    		<input type="radio" value="A21" name="location"  style="font-size: 20px"/>A21
	    		<input type="radio" value="A22" name="location"  style="font-size: 20px"/>A22
	    		<input type="radio" value="A23" name="location"  style="font-size: 20px"/>A23
	    		<input type="radio" value="pending" name="location"  style="font-size: 20px"/>待定
	    	</div>
	    	<div class="activity_time">
	    		<label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">时间</label>
	    		开始：<input type="date" id="datetime-starttime" name="starttime" />
	    		        结束：<input type="date" id="datetime-endtime" name="endtime" />
	    	</div>
	    	<div id="activity_members" class="activity_members">
	    	    <label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">参与人</label>
	    	    
	    	    <input type="checkbox" id="item"><label>全选&nbsp</label>
	    	    <input type="checkbox" id="item" name="item" value="andrew"><label>andrew</label>
	    	    <input type="checkbox" id="item" name="item" value="Carl"><label>Carl</label>
	    	    <input type="checkbox" id="item" name="item" value="vigoss"><label>vigoss</label>
	    	    <input type="checkbox" id="item" name="item" value="snowy"><label>snowy</label>
	    	    <br><br>
	    	</div>
	    	<div class="activity_button">
	    		<button type="submit"  class="button" style="margin-right: 30px" >Save</button>
	    		<button type="button" class="button" onclick="window.location.href='Main.jsp'">Cancel</button>
	    	</div>
	
	    </div>
	    <div id="footer">
	    	
	    </div>
    </form>
</body>
</html>