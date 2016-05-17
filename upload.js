function uploadAndSubmit()
{
	var uploadSuccess = function(data,xhr)
	{
		console.log(data); 
	}
	var uploadProgress = function(event,position,total,percent)
	{
		 document.getElementById("bytesRead").textContent = event.loaded; 
	}
	
	var formData = new FormData();
	var form = document.forms["upForm"]; 
	var file = form["upFile"].files[0]; 
	var filename =  encodeURI(encodeURI(file.name));
	//alert(file.name);
	formData.append('upload', file);
	//额外数据
	formData.append('para1','value1');
	
	var xhr;
	if(window.XMLHttpRequest)
	{
		xhr = new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xhr.open('POST', "upload.jsp?fileName=" + filename );
	// xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	// xhr.setRequestHeader("Content-Type", "text/html;charset=utf-8");
	xhr.upload.onloadstart = function(){
		document.getElementById("bytesTotal").textContent = file.size; 
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
				uploadSuccess(xhr.responseText,xhr);
			}
		}

	};
	xhr.send(formData);
	return false;
};