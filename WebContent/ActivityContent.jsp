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
        <script type="text/javascript" language="javascript" charset="utf-8" src="/upload.js">
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
		        	titleCell.innerHTML = "双击输入或更新你的标题";
		        	fileCell.innerHTML = "未上传";


		        	titleCell.ondblclick = function dblclickEvent(){editRowCell(titleCell)};
		        	if(window.addEventListener){
		        		titleCell.addEnevtListener('ondblclick',editRowCell(titleCell),false);
		        		//titleCell.addEnevtListener('ondblclick',function dblclickEvent(){_edit.IN(titleCell,'index.html?act=edit',3)},false);
		        	}
		        	else
		        	{
		        		titleCell.attachEvent('ondblclick',editRowCell(titleCell));
		        		//titleCell.attachEvent('ondblclick',function dblclickEvent(){_edit.IN(titleCell,'index.html?act=edit',3)});
		        	}
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
						  obj.innerHTML = str2;//数据库更新完成，则显示更改后的值
					  }
				  }
				  xmlhttp.open("POST","ActivityContentClServlet?activityContentBefore="+str1+"&activityContent="+str2,true);
				  xmlhttp.send();
	        }
			function editRowCell(obj) 
			{
			    var tag = obj.firstChild.tagName;
				if (typeof(tag) != "undefined" && (tag == "INPUT" || tag == "TEXTAREA"))
					return;
				var org = obj.innerHTML;
				var orglen = org.replace(/[^\x00-\xff]/g,'**').length;
				if (obj.offsetHeight <= 22) 
				{
					  var val = window.ActiveXObject ? obj.innerText : obj.textContent;
					  var txt = document.createElement("INPUT");
					  txt.value = val.trim();
					  txt.style.background = "#FFC";
					  txt.style.width = obj.offsetWidth + "px" ;
					  obj.innerHTML = "";
					  obj.appendChild(txt);
					  txt.focus();
					  txt.onblur = function(e)
					  {
						  var txtvalue = txt.value.trim();
					      if(txtvalue.length>35 || txtvalue.length==0 || txtvalue == "空")
					      {
					    	 alert("输入内容不能为空且不能超过35个字符"); 
					    	 return;
					      }
					      else if(val != txtvalue)
					      {
					    	  //先插入数据库，再更新到界面上
					    	  UpdateActivityContent(obj,val,txtvalue);
					      }
					      else
					      {
					    	  obj.innerHTML = txtvalue;
					      }
					  }
			    }
			    else
			    {
			    	//取出该单元格内容
					var content = obj.innerHTML;
					var html = document.createElement('TEXTAREA');
					html.style.width = obj.offsetWidth + "px";
					html.style.height = obj.offsetHeight + "px";
					obj.innerHTML = "";
					//将大单元格内容付给textarea
					html.value = content.trim();
					obj.appendChild(html);
					html.focus();
					html.onblur = function(e)
					{
						var htmlvalue = html.value.trim(); 
						if(htmlvalue.length>35 || htmlvalue.length==0 || htmlvalue == "空")
					    {
					    	 alert("输入内容不能为空且不能超过35个字符");
					    	 return;
					    }
						else if(content != htmlvalue)
						{
							UpdateActivityContent(obj,content,htmlvalue);
						}
						else
						{
							obj.innerHTML = htmlvalue;
						}
			    	}
			    }
			}
		</script>
</head>
<body>
	<div id="head">
    	<label id="activitytitle">活动参与详情</label><br>
    	<label id="loginUser"><%=session.getAttribute("userName") %> <%=session.getAttribute("workNumber") %></label>
    	<!-- <button name="addMyTitle" onclick="AddMyTitle()">add my title</button> -->
    </div>
    <div id="wrapper">
		<table class="imagetable" id="mytitle">
			<tr>
				<th style="width: 15%;font-size:20px">参 与 人</th>
				<th style="width: 70%;font-size:20px">培 训 主 题</th>
				<th style="width: 15%;font-size:20px">资 料 上 传</th>
			</tr>
			<% 
			    String loginUser = (String)session.getAttribute("userName");
			    ArrayList<ArrayList<String>> al = (ArrayList<ArrayList<String>>)(request.getAttribute("activityContentList"));
			    Iterator<ArrayList<String>> it = al.iterator();
			    while(it.hasNext())
			    {
			    	ArrayList<String> activityContentList = new ArrayList<String>();
			    	activityContentList = (ArrayList<String>)it.next();
			    	String memberName = activityContentList.get(0);
			    	String titleName = activityContentList.get(1);
			    	String filePath = activityContentList.get(2);
			    	String uploadFlag = activityContentList.get(3);
			%>    	
				    <tr>
						<td><%=memberName%></td>
						<td style="font-size:20px;color:<%=memberName.equals(loginUser)?"red":"black" %>" 
						ondblclick=<%=memberName.equals(loginUser)?"editRowCell(this)":null %>; >
						<%=titleName%>
						</td>
			<%
						String name = "未上传";
						//String imagename = "";
						String buttonName = "点击上传";
				        if(uploadFlag.equals("1"))
				        {
				        	name = filePath.substring(0,10);
				        	//imagename = "images/file_complete.png";
				        	buttonName = "点击更新";
				        }
			%>			
						<td>
							<form id="upForm" name="upForm" action="javascript:uploadAndSubmit();" method="post" enctype="multipart/form-data">
								<label><%=name %></label><br>
								<a href="javascript:uploadAndSubmit();" class="a-upload">
									<input type="file" name="upFile" id="upFile"><%=buttonName %>
								</a>
							</form>
						
						</td>
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