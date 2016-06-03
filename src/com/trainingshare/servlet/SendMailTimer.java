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
 * 自动发送邮件的定时器类
 * @author andrew.an
 *
 */
public class SendMailTimer {
	
	//定义定时器1，用来循环检索活动开始时间
	private ScheduledExecutorService scheduler1 = Executors.newScheduledThreadPool(1);
	private ScheduledExecutorService scheduler2 = Executors.newScheduledThreadPool(1);
	static int seconds=10; //定时器初始间隔时间，10分钟600
	int intervalHours=10;  //邮件推送时间距开始时间间隔，2小时2*60*60
	int timerInitialDelay=0;//定时器启动延时时间，0秒
	Boolean timer2StartFlag=false;
	ActivityContentViewBean acvb = new ActivityContentViewBean();
	public void SendMail()
	{
		try{
			//任务2：发送邮件
			Runnable task2 = new Runnable(){
				public void run(){
					    System.out.println("任务2已执行！");
					    
						//执行发送邮件业务代码
						SendMail sm = new SendMail();
						sm.SendMailToMembers(acvb);
						
						//关闭定时器2并置位
						System.out.println("定时器2已关闭！");
						scheduler2.shutdownNow();
						timer2StartFlag = false;
				}
			};
			
			//任务1，根据活动开始时间距当前时间的间隔判断是否启动定时器
			Runnable task1 = new Runnable(){
				public void run(){
					System.out.println("任务1已执行");
					int second = CalcuteTimerStartTime();
					System.out.println(second);
					if(second!=0 && second <= 120)//intervalHours/2*60*60-600)
					{
						if(!timer2StartFlag)
						{
							timer2StartFlag = true;
							//启动定时器2.用来发送邮件,定时器2只启动一次
							scheduler2.scheduleAtFixedRate(task2, 0, 10000, TimeUnit.SECONDS);
						}
					}
					else
					{
						System.out.println("没有符合条件的记录！");
					}
				}
			};

			//启动定时器
			//scheduler1.scheduleAtFixedRate(task1, 10, seconds, TimeUnit.SECONDS);
			System.out.println("定时器未启动");
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
	
	//计算定时器开启时间
	public int CalcuteTimerStartTime()
	{
		int seconds = 0;
		//获取最近一次活动的开始时间
		DBConnect dbc = new DBConnect();
		acvb = dbc.GetTheLatestContent();
		try{
			System.out.println(acvb.getTitle()+acvb.getStartTime());
			//如果最近一次活动时间不为空,则将其转化为日期格式
			if(null != acvb)
			{
				if(null!=acvb.getMemberList() && !acvb.getMemberList().equals(""))
				{
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date latestDate = sdf.parse(acvb.getStartTime());
					//如果最近的日期时间在上午10:30之前，则需要将日期调整至前一天下午5点
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
						//将时间向前推2个小时
						cal.add(cal.HOUR_OF_DAY, -2);
					}
					
					//获得以秒计算的时间差
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
