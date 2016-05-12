package com.trainingshare.model;

public class ActivityContentBean {
    private int id;
    private String memberName;
    private String title;
    private String filePath;
    private String uploadFlag;
    private String recordTime;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getUploadFlag() {
		return uploadFlag;
	}
	public void setUploadFlag(String uploadFlag) {
		this.uploadFlag = uploadFlag;
	}
	public String getRecordTime() {
		return recordTime;
	}
	public void setRecordTime(String recordTime) {
		this.recordTime = recordTime;
	}
}
