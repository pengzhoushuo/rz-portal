package com.xxx.portal.domain;

public class BatchImportResult {

	private int total;
	private int success;
	private int failure;
	private String wrongMessage;
	private String message;
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getSuccess() {
		return success;
	}
	public void setSuccess(int success) {
		this.success = success;
	}
	public int getFailure() {
		return failure;
	}
	public void setFailure(int failure) {
		this.failure = failure;
	}
	public String getWrongMessage() {
		return wrongMessage;
	}
	public void setWrongMessage(String wrongMessage) {
		this.wrongMessage = wrongMessage;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
