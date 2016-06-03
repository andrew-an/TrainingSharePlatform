package com.trainingshare.servlet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import com.trainingshare.servlet.SendMail;
import com.trainingshare.db.*;
import com.trainingshare.model.*;
/**
 * �Զ������ʼ��Ķ�ʱ����
 * @author andrew.an
 *
 */
public class SendMailTimer {
	
	//���嶨ʱ��1������ѭ���������ʼʱ��
	private ScheduledExecutorService scheduler1 = Executors.newScheduledThreadPool(1);
	private ScheduledExecutorService scheduler2 = Executors.newScheduledThreadPool(1);
	static int seconds=10; //��ʱ����ʼ���ʱ�䣬10����600
	int intervalHours=10;  //�ʼ�����ʱ��࿪ʼʱ������2Сʱ2*60*60
	int timerInitialDelay=0;//��ʱ��������ʱʱ�䣬0��
	Boolean timer2StartFlag=false;
	ActivityContentViewBean acvb = new ActivityContentViewBean();
	public void SendMail()
	{
		try{
			//����2�������ʼ�
			Runnable task2 = new Runnable(){
				public void run(){
					    System.out.println("����2��ִ�У�");
					    
						//ִ�з����ʼ�ҵ�����
						SendMail sm = new SendMail();
						sm.SendMailToMembers(acvb);
						
						//�رն�ʱ��2����λ
						System.out.println("��ʱ��2�ѹرգ�");
						scheduler2.shutdownNow();
						timer2StartFlag = false;
				}
			};
			
			//����1�����ݻ��ʼʱ��൱ǰʱ��ļ���ж��Ƿ�������ʱ��
			Runnable task1 = new Runnable(){
				public void run(){
					System.out.println("����1��ִ��");
					int second = CalcuteTimerStartTime();
					System.out.println(second);
					if(second!=0 && second <= 120)//intervalHours/2*60*60-600)
					{
						if(!timer2StartFlag)
						{
							timer2StartFlag = true;
							//������ʱ��2.���������ʼ�,��ʱ��2ֻ����һ��
							scheduler2.scheduleAtFixedRate(task2, 0, 10000, TimeUnit.SECONDS);
						}
					}
					else
					{
						System.out.println("û�з��������ļ�¼��");
					}
				}
			};

			//������ʱ��
			//scheduler1.scheduleAtFixedRate(task1, 10, seconds, TimeUnit.SECONDS);
			System.out.println("��ʱ��δ����");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	public void stop()
	{
		scheduler1.shutdownNow();
		scheduler2.shutdownNow();
	}
	
	//���㶨ʱ������ʱ��
	public int CalcuteTimerStartTime()
	{
		int seconds = 0;
		//��ȡ���һ�λ�Ŀ�ʼʱ��
		DBConnect dbc = new DBConnect();
		acvb = dbc.GetTheLatestContent();
		try{
			System.out.println(acvb.getTitle()+acvb.getStartTime());
			//������һ�λʱ�䲻Ϊ��,����ת��Ϊ���ڸ�ʽ
			if(null != acvb)
			{
				if(null!=acvb.getMemberList() && !acvb.getMemberList().equals(""))
				{
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date latestDate = sdf.parse(acvb.getStartTime());
					//������������ʱ��������10:30֮ǰ������Ҫ�����ڵ�����ǰһ������5��
					Calendar cal = Calendar.getInstance();
					cal.setTime(latestDate);
					if(cal.HOUR_OF_DAY<10 && cal.MINUTE<30)
					{
						cal.add(cal.DAY_OF_YEAR, 0);
						cal.set(cal.YEAR, cal.MONTH, cal.DAY_OF_MONTH, 17, 00);
						latestDate = cal.getTime();
					}
					else
					{
						//��ʱ����ǰ��2��Сʱ
						cal.add(cal.HOUR_OF_DAY, -2);
					}
					
					//�����������ʱ���
					seconds = ((int)latestDate.getTime()-(int)new Date().getTime())/1000;
				}
			}
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return seconds;
	}
}
