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
	function ForbidFreshPage() {
	    if ((window.event.ctrlKey && window.event.keyCode == 116) || window.event.keyCode == 116) {
	       window.event.keyCode = 0;
	       window.event.returnValue = false;
	   } 
	}
	document.onkeydown = ForbidFreshPage;
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
    function Save()
    {
    	var title = document.getElementById("activitytitle");
    	var details = document.getElementById("activitydetails");
    	var startTime = document.getElementById("datepicker1");
    	var endTime = document.getElementById("datepicker2");
    	var div = document.getElementById("activity_members");
	    var oInput = div.getElementsByTagName("input");
    	var i;
    	for(i = 1; i < oInput.length; i++)
   		{
   			if(oInput[i].checked)
   			{
   				break;
   			}
   		}
    	
    	if(title.value == "")
    		alert("标题不能为空！");
    	else if(details.value == "")
    		alert("内容不能为空！");
    	else if(startTime.value == "")
    		alert("开始时间不能为空！");
    	else if(endTime.value == "")
    		alert("结束时间不能为空！");
    	else if(startTime.value > endTime.value)
    		alert("开始时间必须在结束时间之前！");
    	else if(i>=oInput.length)
    	{
    		alert("至少选择一名参与人员！");
    	}
    	else
    	{
    		Validate();
    	}
    }
    
    //验证待提交信息的合法性（是否在数据库有相同记录）
    function Validate()
    {
    	var xhr;
		if(window.XMLHttpRequest)
		{
			xhr = new XMLHttpRequest();
		}
		else if(window.ActiveXObject)
		{
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		}
		
		var title = document.getElementById("activitytitle").value;
		titlename = encodeURI(encodeURI(title));
		xhr.onreadystatechange = function()
		{
			if(xhr.readyState==4)
			{
				if(xhr.status == 200)
				{
					if(xhr.responseText == "success")
					{
						//提交表单
			    		document.form.submit();
					}
					else
					{
						alert("不能建立重复的主题！");
					}
				}
			}
		}
		xhr.open('POST', "newactivitycl?title="+title);
		xhr.send();
    }
</script>
</head>
<body onload="window_load()">
    <form name="form" action="newactivitycl" method="post">
	    <div style="float:right;margin-right:10px;">
			<a href="Login.jsp?relogin=true" style="font-size:14px;text-decoration:none">退出登录</a>
		</div>
	    <div id="head">
	    	<label>新建活动</label>
	    </div>
	    <div id="wrapper">
	    	<div class="activity_title">
	    		<label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">标题</label><br>
	    		<textarea id="activitytitle" name="activitytitle" style="width:95%;height:40%;bottom:5px; margin-left:15px;margin-top:5px;font-size:20px"></textarea>
	    	</div>
	    	<div class="activity_content">
	    		 <label style="margin-left: 15px;margin-top:5px;color: black;font-size: 25px">内容</label><br>
	    		<textarea id="activitydetails" name="activitydetails" style="width: 95%;height: 75%;bottom: 5px; margin-left:15px;margin-top: 5px;font-size: 20px"></textarea>
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
	    		<button type="button"  class="button" style="margin-right: 30px" onclick="Save();">保存</button>
	    		<button type="button" class="button" onclick="javascript:history.go(-1);">取消</button>
	    	</div>
	
	    </div>
	    <div id="footer">
	    	
	    </div>
    </form>
</body>
</html>