package com.xxx.portal.util;

import java.io.Serializable;

public class BaseResponse<T> implements Serializable{

	private static final long serialVersionUID = 8060326913066636058L;

	public static final int CODE_SUCCESS = 1;
	public static final int CODE_FAILURE = -1;
	
	private int code = CODE_FAILURE;
	
	private String message;
	
	private T obj;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getObj() {
		return obj;
	}

	public void setObj(T obj) {
		this.obj = obj;
	}
}
