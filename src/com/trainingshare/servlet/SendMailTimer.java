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
	//private ScheduledExecutorService scheduler2;
	static int seconds=5*60; //定时器初始间隔时间，5分钟
	int intervalSeconds=2*60*60;  //邮件推送时间距开始时间间隔，2小时
	//int timerInitialDelay=0;//定时器启动延时时间，0秒
	//Boolean timer2StartFlag=false;
	ActivityContentViewBean acvb = new ActivityContentViewBean();
	public void SendMail()
	{
		try{
			//任务2：发送邮件
			/*Runnable task2 = new Runnable(){
				public void run(){
					    //System.out.println("任务2已执行！");
						//执行发送邮件业务代码
						SendMail sm = new SendMail();
						if(sm.SendMailToMembers(acvb))
						{
							//System.out.println("邮件发送成功");
							//发送成功后，更新activitycontent表中的该主题的sendmail标志位
							new DBConnect().UpdateSendMailFlag(acvb.getTitle());
						}
						
						//关闭定时器2并置位
						//System.out.println("定时器2已关闭！");
						//scheduler2.shutdownNow();
						//timer2StartFlag = false;
				}
			};*/
			
			//任务1，根据活动开始时间距当前时间的间隔判断是否启动定时器
			Runnable task1 = new Runnable(){
				public void run(){
					System.out.println("定时器正在运行！----"+(new Date()).toString());
					int second = CalcuteTimerStartTime();
					//System.out.println("距发送邮件还有"+(second-7200)+"秒");
					if(second > 0 && second <= intervalSeconds)
					{
						//if(!timer2StartFlag)
						//{
							//timer2StartFlag = true;
							//启动定时器2.用来发送邮件,定时器2只启动一次
							//scheduler2 = Executors.newScheduledThreadPool(1);
							//scheduler2.scheduleAtFixedRate(task2, 0, 30, TimeUnit.SECONDS);
							
							SendMail sm = new SendMail();
							if(sm.SendMailToMembers(acvb))
							{
								//System.out.println("邮件发送成功");
								//发送成功后，更新activitycontent表中的该主题的sendmail标志位
								new DBConnect().UpdateSendMailFlag(acvb.getTitle());
							}
						//}
					}
					else
					{
						//System.out.println("没有符合条件的记录！");
					}
				}
			};

			//启动定时器
			scheduler1.scheduleAtFixedRate(task1, 10, seconds, TimeUnit.SECONDS);
			System.out.println("定时器已启动");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	public void stop()
	{
		scheduler1.shutdownNow();
		//scheduler2.shutdownNow();
	}
	
	//计算定时器开启时间
	public int CalcuteTimerStartTime()
	{
		int seconds = 0;
		//获取最近一次活动的开始时间
		DBConnect dbc = new DBConnect();
		acvb = dbc.GetTheLatestContent();
		try{
			//System.out.println(acvb.getTitle()+acvb.getStartTime());
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
					//System.out.println(cal.HOUR_OF_DAY);
					int hour = cal.get(Calendar.HOUR_OF_DAY);
					int minute = cal.get(Calendar.MINUTE);
					//System.out.println("小时为："+hour+" 分钟为："+minute);
					if(hour<10 || (hour==10 && minute<40))
					{
						cal.add(Calendar.DAY_OF_YEAR, -1);
						//System.out.println("邮件中显示的活动开始时间为："+cal.getTime());
						cal.set(Calendar.HOUR_OF_DAY, 17);
						cal.set(Calendar.MINUTE, 00);
					}
					latestDate = cal.getTime();
					//System.out.println("邮件中显示的活动开始时间为："+latestDate);
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
