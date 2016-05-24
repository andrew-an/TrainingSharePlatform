<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<Link rel="stylesheet" type="text/css" href="style3.css"/>
<link rel="stylesheet" type="text/css" href="pikaday.css"/>
<script type="text/javascript" src="pikaday.min.js"></script>

<title>创建新活动</title>
<script type="text/javascript">
    function window_load()
    {
    	var myDate = new Date();
    	var picker = new Pikaday(
	    {
	        field: document.getElementById('datepicker1'),
	        firstDay: 1,
	        minDate: myDate,
	        maxDate: new Date('2099-12-31'),
	        yearRange: [2000,2099]
	    });
    	var picker2 = new Pikaday(
	    {
	        field: document.getElementById('datepicker2'),
	        firstDay: 1,
	        minDate: myDate,
	        maxDate: new Date('2099-12-31'),
	        yearRange: [2000,2099]
	    });
    	    

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
<body">
    <form action="newactivitycl" method="post">
	    <div style="float:right;margin-right:10px;">
			<a href="Login.jsp?relogin=true" style="font-size:14px;text-decoration:none">退出登录</a>
		</div>
	    <div id="head">
	    	<label>新建活动</label>
	    </div>
	    <div id="wrapper">
	    	<div class="activity_title">
	    		<label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">标题</label><br>
	    		<textarea name="activitytitle" style="width:95%;height:40%;bottom:5px; margin-left:15px;margin-top:5px;font-size:20px"></textarea>
	    	</div>
	    	<div class="activity_content">
	    		 <label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">内容</label><br>
	    		<textarea name="activitydetails" style="width: 95%;height: 75%;bottom: 5px; margin-left:15px;margin-top: 5px;font-size: 20px"></textarea>
	    	</div>
	    	<div class="activity_time">
	    		<label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">时间</label>
	    		开始：<input type="text" id="datepicker1" name="starttime" />
	    		        结束：<input type="text" id="datepicker2" name="endtime" />
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
	    		<button type="submit"  class="button" style="margin-right: 30px" >保存</button>
	    		<button type="button" class="button" onclick="javascript:history.go(-1);">取消</button>
	    	</div>
	
	    </div>
	    <div id="footer">
	    	
	    </div>
    </form>
</body>
</html>