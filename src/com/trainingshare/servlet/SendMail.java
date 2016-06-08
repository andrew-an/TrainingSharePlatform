package com.trainingshare.servlet;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import com.trainingshare.model.*;
import com.trainingshare.db.*;
public class SendMail {
	
	public Boolean SendMailToMembers(ActivityContentViewBean acvb)
	{
		Boolean ret = false;
		try{
			DBConnect dbc = new DBConnect();
			if(null != acvb.getMemberList())
			{
				String[] members = acvb.getMemberList().split(",");
				//System.out.println("准备提取发送人列表...");
				if(members.length>0)
				{
					for(String member : members)
					{
						String memberAddress = dbc.GetMemberName(Integer.parseInt(member)) + "@goertek.com";
						String memberName = acvb.getMemberName();
						String mailTitle = "Wearable内部培训开讲通知";
						String mailContent = "Dear All,\n\n"
						+ memberName.substring(0, memberName.lastIndexOf("."))
						+ "将于"+acvb.getStartTime()
						+ "进行 “"+acvb.getTitle()
						+ "” 的培训，欢迎大家登录培训分享平台，下载相关资料。\n\n"
						+ "培训平台网址："+"http://192.168.75.112:8888/TrainingSharePlatform/Login.jsp"+"\n\n\n\n"
						+ "注：此邮件为系统自动发送！";
						//System.out.println("准备给"+memberAddress+"发送邮件...");
						ret = SendMailTo(memberAddress,mailTitle,mailContent);
						//如果有用户发送邮件失败，则退出发送循环
						if(!ret)
							break;
					}
				}
			}
		}
		catch(Exception ex)
		{
			System.out.println("SendMail:");
			ex.printStackTrace();
		}
		return ret;
	}
	
	public Boolean SendMailTo(String memberAddress, String mailTitle, String mailContent)
	{
		Boolean ret = false;
		try{			
			//获取系统属性
			Properties properties = System.getProperties();
			//发送服务器需要身份验证
			properties.setProperty("mail.smtp.auth", "ture");
			//设置邮件服务器
			properties.setProperty("mail.host", "smtp.goertek.com");
			//发送邮件协议名称
			properties.setProperty("mail.transport.protocol", "smtp");
			
			//设置环境信息
			Session session = Session.getInstance(properties);
			
			//创建邮件对象
			Message msg = new MimeMessage(session);
			msg.setSubject(mailTitle);
			//设置邮件内容
			msg.setText(mailContent+"\n"+new Date().toString());
			//设置发送人
			msg.setFrom(new InternetAddress("andrew.an@goertek.com"));
			
			Transport transport = session.getTransport();
			//连接邮件服务器
			transport.connect("andrew.an@goertek.com","Ajch2097498");
			if(transport.isConnected())
			{
				//System.out.println("邮件服务器连接成功！");
				ret = true;
				//发送邮件
				transport.sendMessage(msg, new Address[]{new InternetAddress(memberAddress)});
			}
			else
			{
				//System.out.println("邮件服务器连接不成功！");
			}
			//关闭链接
			transport.close();
		}
		catch(Exception ex)
		{
			System.out.println("SendMail:");
			ex.printStackTrace();
		}
		return ret;
	}
}
