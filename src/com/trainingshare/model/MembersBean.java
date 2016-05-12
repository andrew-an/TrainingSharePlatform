package com.trainingshare.model;

public class MembersBean {
    private int id;
    private String memberList;
    private String remark;
    private String recordTime;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMemberList() {
		return memberList;
	}
	public void setMemberList(String memberList) {
		this.memberList = memberList;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getRecordTime() {
		return recordTime;
	}
	public void setRecordTime(String recordTime) {
		this.recordTime = recordTime;
	}
}
