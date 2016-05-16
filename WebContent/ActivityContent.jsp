<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*,com.trainingshare.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="style4.css">
<title>活动内容</title>
	<% 
	    if(null == session.getAttribute("userName")||session.equals(""))
	    {	
	    	response.sendRedirect("Login.jsp");	    	
	    }
	%>
        <script type="text/javascript" language="javascript" charset="utf-8">
        	function AddMyTitle()
	        {
        		var name = document.getElementById("loginUser").innerHTML.split(" ",2)[0];
	        	var tab = document.getElementById("mytitle");
	        	for(var i=1; i<tab.rows.length; i++)
        		{
	        		//alert(tab.rows[i].cells[0].innerHTML);
        			if(tab.rows[i].cells[0].innerHTML == name)
        			{
        				alert("请执行编辑操作！");
        				break;
        			}
        				
        		}
	        	if(i == tab.rows.length)
	        	{
		        	var row = tab.insertRow(tab.rows.length);
		        	var nameCell = row.insertCell(row.cells.length);
		        	var titleCell = row.insertCell(row.cells.length);
		        	var fileCell = row.insertCell(row.cells.length);
		        	
		        	nameCell.innerHTML = name;
		        	titleCell.innerHTML = "请双击输入你的标题";
		        	fileCell.innerHTML = "未上传";	        		
	        	}
	        }
        
	        function UpdateActivityContent(obj,str1,str2)
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
						  //alert(obj);
						  obj.innerHTML = str2;//数据库更新完成，则显示更改后的值
					  }
				  }
				  xmlhttp.open("POST","ActivityContentClServlet?activityContentBefore="+str1+"&activityContent="+str2,true);
				  xmlhttp.send();
	        }
			var _edit = 
			{
				IN: function (obj, act, id) 
				{
				    var tag = obj.firstChild.tagName;
					if (typeof(tag) != "undefined" && (tag == "INPUT" || tag == "TEXTAREA"))
						return;
					var org = obj.innerHTML;
					var orglen = org.replace(/[^\x00-\xff]/g,'**').length;
					if (obj.offsetHeight <= 22) 
					{
						  var val = window.ActiveXObject ? obj.innerText : obj.textContent;
						  //alert(str1);
						  var txt = document.createElement("INPUT");
						  txt.value = val;
						  txt.style.background = "#FFC";
						  txt.style.width = obj.offsetWidth + "px" ;
						  obj.innerHTML = "";
						  obj.appendChild(txt);
						  txt.focus();
						  txt.onblur = function(e)
						  {
						      if(txt.value.length>35 || txt.value.length==0)
						      {
						    	 alert("输入内容不能为空且不能超过35个字符"); 
						    	 return;
						      }
						      else if(val != txt.value)
						      {
						    	  //先插入数据库，再更新显示
						    	  UpdateActivityContent(obj,val,txt.value);
						      }
						      else
						      {
						    	  obj.innerHTML = txt.value;
						      }
						      
							  //obj.innerHTML = txt.value;
								//_edit.QUERY(act,txt.value);
								//return false;
						  }
				  		  //return false;
				    }
				    else
				    {
						var content = obj.innerHTML;
						var html = document.createElement('TEXTAREA');
						html.style.width = obj.offsetWidth + "px";
						html.style.height = obj.offsetHeight + "px";
						obj.innerHTML = "";
						html.value = content;
						obj.appendChild(html);
						html.focus();
						html.onblur = function(e)
						{
							if(html.value.length>35 || html.value.length==0)
						    {
						    	 alert("输入内容不能为空且不能超过35个字符"); 
						    	 return;
						    }
							else if(content != html.value)
							{
								UpdateActivityContent(obj,content,html.value);
							}
							else
							{
								obj.innerHTML = html.value;
							}
							
							//obj.innerHTML = html.value;
							//_edit.QUERY(act,obj.innerHTML);
				    	}
						//return false;
				    }
				}
			}
			//var editContent = _edit.IN;
		</script>
</head>
<body>
	<div id="head">
    	<label id="activitytitle">活动参与详情</label><br>
    	<label id="loginUser"><%=session.getAttribute("userName") %> <%=session.getAttribute("workNumber") %></label>
    	<button name="addMyTitle" onclick="AddMyTitle()">add my title</button>
    </div>
    <div id="wrapper">
    	<table class="imagetable" id="mytitle">
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
						<td style="font-size:20px;color:<%=activityContentList.get(0).equals(session.getAttribute("userName"))?"red":"black" %>" 
						ondblclick="_edit.IN(this,'index.html?act=edit',3)">
						<%=activityContentList.get(1) %>
						</td>
			<%
			//activityContentList.get(1) == (String)request.getParameter("loginUser")?red:black;
					String name = "未上传";
					String imagename = "";
			        if(null != activityContentList.get(3))
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