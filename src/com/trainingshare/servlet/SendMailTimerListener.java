package com.trainingshare.servlet;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.trainingshare.servlet.SendMailTimer;
/**
 * Application Lifecycle Listener implementation class SendMailTimerListener
 *
 */
@WebListener
public class SendMailTimerListener implements ServletContextListener {

	private SendMailTimer sendMailTimer = null;
	
    /**
     * Default constructor. 
     */
    public SendMailTimerListener() {
        // TODO Auto-generated constructor stub
    	super();
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent event)  { 
    	
    	//��ʼ����ʱ�� 
    	sendMailTimer = new SendMailTimer();
        //������ʱ���������ʼ� 
    	sendMailTimer.SendMail(); 
    }
	
	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent event)  { 
    	
    }
}
