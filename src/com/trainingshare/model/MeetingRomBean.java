package com.trainingshare.model;

public class MeetingRomBean {
    private int id;
    private String roomName;
    private String location;
    private String remark;
    private String recordTime;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRomName() {
		return roomName;
	}
	public void setRomName(String romName) {
		this.roomName = romName;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
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
