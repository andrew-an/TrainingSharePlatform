package com.trainingshare.db;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.trainingshare.model.*;

public class DBConnect {

    Connection ct = null;
    PreparedStatement psmt = null;
    ResultSet rs = null;
    public DBConnect()
    {
    	
    	try{
    		
    		Context ctx=new InitialContext();
    		Context envContext = (Context)ctx.lookup("java:/comp/env"); 
    		DataSource ds = (DataSource)envContext.lookup("jdbc/mysqlds"); 
            ct = ds.getConnection();
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    }
    protected void finalize()
    {
    	try{
    		if(null != rs)
    		{
    			System.out.println("ResultSet close");
    			rs.close();
    		}
        	if(null != psmt)
        	{
        		System.out.println("PreparedStatement close");
        		psmt.close();
        	}
        	if(null != ct)
        	{
        		System.out.println("Connection close");
        		ct.close();
        	}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    }
    //MD5加密算法
    public static String getMD5(String message) {  
        MessageDigest messageDigest = null;  
        StringBuffer md5StrBuff = new StringBuffer();  
        try {  
            messageDigest = MessageDigest.getInstance("MD5");  
            messageDigest.reset();  
            messageDigest.update(message.getBytes("UTF-8"));  
               
            byte[] byteArray = messageDigest.digest();  
            for (int i = 0; i < byteArray.length; i++)   
            {  
                if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)  
                    md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));  
                else 
                    md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));  
            }  
        } 
        catch (Exception e) 
        {  
        	System.out.println("DBConnect:");
            throw new RuntimeException();  
        }  
        return md5StrBuff.toString().toUpperCase();//字母大写  
    }   
	
    //检查用户合法性
    public UserInfoBean checkUser(String username, String password)
    {
    	try{
    		psmt = ct.prepareStatement("select * from userinfo where UserName=?");
    		psmt.setString(1, username);
    		rs = psmt.executeQuery();
    		if(rs.next())
    		{
    			String pwd = (String)rs.getString("Password");
    			if(pwd.equals(getMD5(password)))
    			{
    				UserInfoBean user = new UserInfoBean();
    				user.setId(Integer.parseInt(rs.getString(1)));
    				user.setWorkNumber(rs.getString(2));
    				user.setUserName(rs.getString(3));
    				user.setRealName(rs.getString(4));
    				user.setPassword(rs.getString(5));
    				user.setSex(rs.getString(6));
    				user.setEmail(rs.getString(7));
    				user.setAdministratorFlag(rs.getString(8));
    				user.setRemark(rs.getString(9));
    				return user;
    			}
    			
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
		return null;
    }
    //更新用户密码
    public Boolean UpdatePassword(String username, String pwd_new)
    {
    	Boolean ret=false;
    	try
    	{
    		if(null!=username && null!=pwd_new)
    		{
        		pwd_new = getMD5(pwd_new);
        		String strsql = "update userinfo set PassWord='"+pwd_new+"' where UserName='"+username+"'";
        		strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
        		psmt = ct.prepareStatement(strsql);
        		int result = psmt.executeUpdate();
        		if(result > 0)
        		{
        			ret = true;
        		}    			
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return ret;    	
    }
    //根据姓名查找Id号
    public int GetUserId(String userName)
    {
    	int id=0;
    	try{
    		String strsql = "select Id from userinfo where UserName='"+userName+"'";
    		strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
    			id = rs.getInt(1);
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return id;
    }
    //返回活动列表
    public ArrayList<String> GetActivityTitle()
    {
    	ArrayList<String> al = new ArrayList<String>();
    	try{
    		psmt = ct.prepareStatement("select Title, CompleteFlag from activity order by id desc");
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
				String title = rs.getString(1)+","+rs.getString(2);
				al.add(title);
    		}
    	}
    	catch(Exception ex){
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
		return al;
    }
    
    //添加一个新活动信息,返回新添加的获得Id号
    public int AddNewAcivity(ActivityBean ab)
    {
    	int ret=0;
    	try{
    		String strsql = "insert into activity(title,details,membersId,startTime,endTime,remark)values('"
            		+ab.getTitle()+"','"+ab.getDetails()+"',"+ab.getMembersId()
            		+",'"+ab.getStartTime()+"','"+ab.getEndTime()+"','"+ab.getRemak()+"')";
    		strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
            psmt = ct.prepareStatement(strsql);
            int rows = psmt.executeUpdate();
            if(rows>0)
            {
            	strsql = "select LAST_INSERT_ID() as Id from activity";
            	psmt = ct.prepareStatement(strsql);
            	ResultSet rs = psmt.executeQuery();
            	while(rs.next())
            	{
            		ret = rs.getInt("Id");
            	}
            }
            
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return ret;
    }
    //判断是否存在相同标题的项
    public Boolean CheckActivityExistorNot(String title)
    {
    	Boolean ret=true;
    	try{
        	String strsql = "SELECT COUNT(*) FROM activity WHERE Title='"+title+"'";
        	strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
        	psmt = ct.prepareStatement(strsql);
        	ResultSet rs = psmt.executeQuery();
        	if(rs.next())
        	{
        		if(rs.getInt(1) == 0)//不存在记录
        			ret = false;
        	}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return ret;
    }
    
    //判断是否存在未删除的相同的个人标题
    public Boolean CheckActivityContentExistorNot(int membersId, String title)
    {
    	Boolean ret=true;
    	try{
        	String strsql = "SELECT COUNT(*) FROM activitycontent WHERE Title='"+title+"' and MembersId="+membersId+" and DeleteFlag='"+0+"'";
        	strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
        	psmt = ct.prepareStatement(strsql);
        	ResultSet rs = psmt.executeQuery();
        	if(rs.next())
        	{
        		if(rs.getInt(1) == 0)//不存在记录
        			ret = false;
        	}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return ret;
    }
    
    //添加一个新的活动内容详情
    public Boolean AddNewAcivityContent(ActivityContentBean acb)
    {
    	Boolean ret = false;
    	try{
    		String strsql = "insert into activitycontent(MembersId,MemberId,Title,MeetingRoomId,StartTime,FilePath,UploadFlag,Remark)values("
            		+acb.getMembersId()+","+acb.getMemberId()+",'"+acb.getTitle()+"',"
            		+acb.getMeetingRoomId()+",'"+acb.getStartTime()+"','"
            		+acb.getFilePath()+"','"+acb.getUploadFlag()+"','"+acb.getRemark()+"')";
    		strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
            psmt = ct.prepareStatement(strsql);
            int rows = psmt.executeUpdate();
            if(rows>0)
            {
            	ret=true;
            }
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return ret;
    }
    
    //根据会议室名称查询ID
    public int QueryMeetingRomId(String strMeetingRoom)
    {
    	int id = 0;
    	try{
    		psmt = ct.prepareStatement("select id from meetingroom where roomName='"+strMeetingRoom+"'");
    		
    		ResultSet rs = psmt.executeQuery();
    		if(rs.next())
    		{
    			id = Integer.parseInt(rs.getString(1));
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return id;
    }
    
    //根据活动标题获取人员列表Id号
    public int GetActivityIdByTitle(String activityTitle)
    {
    	int id=0;
    	try{
    		String strsql = "select ActivityId from activity where Title='"+activityTitle+"'";
    		strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		if(rs.next())
    		{
    			id = rs.getInt(1);
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return id;
    }
    //根据活动标题获取人员列表Id号
    public int GetMembersIdByTitle(String activityTitle)
    {
    	int id=0;
    	try{
    		String strsql = "select MembersId from activity where Title='"+activityTitle+"'";
    		strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		if(rs.next())
    		{
    			id = rs.getInt(1);
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	
    	return id;
    }
    //根据活动标题获取人员列表Id号
    public int GetMembersIdByactivityId(int activityId)
    {
    	int id=0;
    	try{
    		String strsql = "select MembersId from activity where Id="+activityId;
    		//strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		if(rs.next())
    		{
    			id = rs.getInt(1);
    		}
    	}
    	catch(Exception ex)
    	{
    		ex.printStackTrace();
    	}
    	return id;
    }
    //根据Id号获得参加该活动的所有人员名
    public ArrayList<String> GetAllMembersById(int membersId)
    {
    	ArrayList<String> membersList = new ArrayList<String>();
    	try{
    		
    		String strsql = "select MemberList from members where Id="+membersId;
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		if(rs.next())
    		{
    			String[] members = rs.getString(1).split(",");
    			for(int i=0; i<members.length;i++)
    			{
    				membersList.add(members[i]);
    			}
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return membersList;
    }
    
    //获取活动详情——某活动中所有人的信息内容（标题，上传文件等）
    public ArrayList<ArrayList<String>> GetActivityContentByMembersId(int membersId)
    {
    	ArrayList<ArrayList<String>> contentList = new ArrayList<ArrayList<String>>();
    	try
    	{
    		String strsql = "select MemberId,Title,MeetingRoomId,StartTime,FilePath,UploadFlag from activitycontent where MembersId="+membersId + " and DeleteFlag='"+0+"' order by RecordTime desc";
    		
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
    			ArrayList<String> al = new ArrayList<String>();
    			String memberName = GetMemberName(rs.getInt(1));
    			al.add(memberName);//成员名
    			al.add(rs.getString(2));//主题名称
    			al.add(GetMeetingRoomNameById(rs.getInt(3)));//活动地点
    			al.add(rs.getString(4));//开始时间
    			al.add(rs.getString(5));//上传文件路径
    			al.add(rs.getString(6));//是否上传标志
    			contentList.add(al);
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return contentList;
    }
    //根据成员Id获取成员名称
    public String GetMemberName(int memberId)
    {
    	String memberName=null;
    	try
    	{
    		String strsql = "select UserName from userinfo where Id="+memberId;
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		if(rs.next())
    		{
    			memberName = rs.getString(1);
    		}
    	}
    	catch(Exception ex)
    	{
    		ex.printStackTrace();
    	}
    	return memberName;
    }
    
    public Boolean UpdateActivityContentByTitle(String titleOriginal, ActivityContentBean acb)
    {
    	Boolean ret=false;
    	try{
        	String sql = "update activitycontent set Title='"+acb.getTitle()
        	+"', MeetingRoomId="+acb.getMeetingRoomId()
        	+", StartTime='"+acb.getStartTime()
        	+"' where Title='"+titleOriginal
        	+"' and MembersId="+acb.getMembersId()
        	+" and MemberId="+acb.getMemberId();
        	
        	sql = new String(sql.getBytes("iso-8859-1"),"utf-8");
        	psmt = ct.prepareStatement(sql);  
        	int result = psmt.executeUpdate();
        	if(result>0)
        	{
        		ret=true;
        	}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	
    	return ret;
    }
    
    //存储上传文件的路径
    public Boolean UpdateUploadFilePath(String membersId, String memberName, String filePath, String activityContent)
    {
    	Boolean ret=false;
    	try{
    		int userId = GetUserId(memberName);
    		filePath = "G:\\\\TrainingShare\\\\" + filePath;
        	String sql = "update activitycontent set FilePath='"+filePath+"', UploadFlag='1'"
        			   +" where MembersId="+membersId
    			       +" and memberId="+userId
    			       +" and Title='"+activityContent+"'"
    			       +" and DeleteFlag='"+0+"'";
        	//sql = new String(sql.getBytes("iso-8859-1"),"utf-8");
        	psmt = ct.prepareStatement(sql);  
        	int result = psmt.executeUpdate();
        	if(result>0)
        	{
        		ret=true;
        	}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return ret;
    }
    
    //获取某次活动的所有成员上传文件路径
    public ArrayList<String> GetAllUploadFilePathById(int membersId)
    {
    	ArrayList<String> al = new ArrayList<String>();
    	try
    	{
    		String strsql = "select FilePath from activitycontent where MembersId="+membersId+" and DeleteFlag='"+0+"'";
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
    			String filePath = rs.getString(1);
    			if(null != filePath && !filePath.equals(""))
    				al.add(filePath);
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return al;
    }
    
    //获取某次活动的某个成员上传文件路径
    public ArrayList<String> GetUploadFilePathByMemberName(int membersId, String memberName)
    {
    	ArrayList<String> al = new ArrayList<String>();
    	try
    	{
    		String strsql = "select T1.FilePath from activitycontent as T1 "
    				+ "inner join userinfo as T2 on T1.MemberId=T2.Id "
    				+ "where T1.MembersId=" + membersId+" "
    				+ "and T2.UserName='" + memberName
    				+ "' and DeleteFlag='" + 0 + "'";
    		
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
    			String filePath = rs.getString(1);
    			if(null != filePath && !filePath.equals(""))
    				al.add(filePath);
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return al;
    }
    
    //从userinfo表中获取与姓名对应的所有Id号
    public ArrayList<Integer> GetMemberIdByName(String[] memberName)
    {
    	ArrayList<Integer> al = new ArrayList<Integer>();
    	try
    	{
    		String strsql = "SELECT Id FROM userinfo WHERE";
    		for(int i=0; i<memberName.length; i++)
    			strsql += " UserName='"+memberName[i]+"' OR";
    		if(memberName.length>0 && strsql.endsWith(" OR"))
    			strsql = strsql.substring(0, strsql.length()-3);//去掉最后面的“ OR”
    		
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
    			int id = rs.getInt(1);
    			if(0 != id)
    			{
    				al.add(id);
    			}
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return al;
    }
    
    //更新members表,返回新插入行的Id值
    public int UpdateMembersTable(String memberList)
    {
    	int ret=0;   
    	try{
        	String strsql = "insert into members(MemberList) values('"+memberList+"')";
        	strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
        	psmt = ct.prepareStatement(strsql);
        	int rows = psmt.executeUpdate();
        	if(rows>0)
        	{
        		strsql = "select LAST_INSERT_ID() as Id from members";
        		psmt = ct.prepareStatement(strsql);
        		ResultSet result = psmt.executeQuery();
        		while(result.next())
        		{
        			ret = result.getInt("Id");
        		}
        	}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    	    ex.printStackTrace();
    	}
    	return ret;
    }
    
    //通过房间号获取会议室表的Id
    public int GetMeetingRoomIdByName(String roomName)
    {
    	int ret=0;   
    	try{
        	String strsql = "select Id from meetingroom where RoomName='"+roomName+"'";
        	strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
        	psmt = ct.prepareStatement(strsql);
        	ResultSet rs = psmt.executeQuery();
        	while(rs.next())
        	{
        	    ret = rs.getInt(1);
        	}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    	    ex.printStackTrace();
    	}
    	return ret;
    }
    
    //通过Id号获取会议室名
    public String GetMeetingRoomNameById(int id)
    {
    	String ret="";   
    	try{
        	String strsql = "select RoomName from meetingroom where Id="+id;
        	strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
        	psmt = ct.prepareStatement(strsql);
        	ResultSet rs = psmt.executeQuery();
        	while(rs.next())
        	{
        	    ret = rs.getString(1);
        	}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    	    ex.printStackTrace();
    	}
    	return ret;
    }
    
    //获取所有会议室
    public ArrayList<String> GetAllMeetingRooms()
    {
    	ArrayList<String> al = new ArrayList<String>();
    	try{
    		String strsql = "select RoomName from meetingroom order by Id desc";
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
    			al.add(rs.getString(1));
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return al;
    }
    
    //获取所有人员
    public ArrayList<String> GetAllMembers()
    {
    	ArrayList<String> al = new ArrayList<String>();
    	try{
    		String strsql = "select UserName from userinfo";
    		psmt = ct.prepareStatement(strsql);
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
    			al.add(rs.getString(1));
    		}
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return al;
    }
    
    //删除某个人员的主题
    public Boolean DeleteMemberPerson(int membersId, String title)
    {
    	Boolean ret=false;
    	try{
    		String strsql = "update activitycontent set DeleteFlag=1 where MembersId="+membersId+" and Title='"+title+"'";
    		strsql = new String(strsql.getBytes("iso-8859-1"),"utf-8");
    		psmt = ct.prepareStatement(strsql);
    		int result = psmt.executeUpdate();
    		if(result>0)
    			ret=true;
    	}
    	catch(Exception ex)
    	{
    		System.out.println("DBConnect:");
    		ex.printStackTrace();
    	}
    	return ret;
    }
}
