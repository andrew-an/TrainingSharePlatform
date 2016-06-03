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
				System.out.println("׼����ȡ�������б�...");
				if(members.length>0)
				{
					for(String member : members)
					{
						String memberAddress = dbc.GetMemberName(Integer.parseInt(member)) + "@goertek.com";
						String mailTitle = "Wearable��һ���ڲ���ѵ����֪ͨ";
						String mailContent = "�˴���ѵ�������£�\n"
						+"��ѵ��Ŀ��"+acvb.getTitle()+"\n"
						+"��ѵ��    ��"+acvb.getMemberName()+"\n"
						+"��ѵʱ�䣺"+acvb.getStartTime()+"\n"
						+"��ѵ�ص㣺"+acvb.getLocation()+"\n\n"
						+"��ѵƽ̨��ַ��"+"http://192.168.75.112:8888/TrainingSharePlatform/Login.jsp"+"\n"
						+"ע�����ʼ�Ϊϵͳ�Զ����ͣ�";
						System.out.println("׼����"+memberAddress+"�����ʼ�...");
						SendMailTo(memberAddress,mailTitle,mailContent);
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
			//��ȡϵͳ����
			Properties properties = System.getProperties();
			//���ͷ�������Ҫ�����֤
			properties.setProperty("mail.smtp.auth", "ture");
			//�����ʼ�������
			properties.setProperty("mail.host", "smtp.goertek.com");
			//�����ʼ�Э������
			properties.setProperty("mail.transport.protocol", "smtp");
			
			//���û�����Ϣ
			Session session = Session.getInstance(properties);
			
			//�����ʼ�����
			Message msg = new MimeMessage(session);
			msg.setSubject(mailTitle);
			//�����ʼ�����
			msg.setText(mailContent+"\n"+new Date().toString());
			//���÷�����
			msg.setFrom(new InternetAddress("andrew.an@goertek.com"));
			
			Transport transport = session.getTransport();
			//�����ʼ�������
			transport.connect("andrew.an@goertek.com","Ajch2097498");
			if(transport.isConnected())
			{
				System.out.println("�ʼ����������ӳɹ���");
				//�����ʼ�
				transport.sendMessage(msg, new Address[]{new InternetAddress(memberAddress)});
			}
			else
			{
				System.out.println("�ʼ����������Ӳ��ɹ���");
			}
			//�ر�����
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
