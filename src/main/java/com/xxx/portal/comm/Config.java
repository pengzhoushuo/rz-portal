package com.xxx.portal.comm;

import org.apache.commons.lang3.BooleanUtils;

public class Config {

	/** 图片存储路径配置 **/
	private String imgPath;

	/** 批量EXCEL文件存储路径配置 **/
	private String batchFilePath;

	/** 文件中心相关配置 **/
	private String fileCenterUploadUrl;

	private String fileCenterUploadToken;

	private String fileCenterDownloadUrl;

	/** JPush相关配置 **/
	private String jpush_appKey;
	private String jpush_masterSecret;
	private String jpush_baseDeviceURL;
	private boolean jpush_isApnsProd;

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getBatchFilePath() {
		return batchFilePath;
	}

	public void setBatchFilePath(String batchFilePath) {
		this.batchFilePath = batchFilePath;
	}

	public String getJpush_appKey() {
		return jpush_appKey;
	}

	public void setJpush_appKey(String jpush_appKey) {
		this.jpush_appKey = jpush_appKey;
	}

	public String getJpush_masterSecret() {
		return jpush_masterSecret;
	}

	public void setJpush_masterSecret(String jpush_masterSecret) {
		this.jpush_masterSecret = jpush_masterSecret;
	}

	public String getJpush_baseDeviceURL() {
		return jpush_baseDeviceURL;
	}

	public void setJpush_baseDeviceURL(String jpush_baseDeviceURL) {
		this.jpush_baseDeviceURL = jpush_baseDeviceURL;
	}

	public String getFileCenterDownloadUrl() {
		return fileCenterDownloadUrl;
	}

	public void setFileCenterDownloadUrl(String fileCenterDownloadUrl) {
		this.fileCenterDownloadUrl = fileCenterDownloadUrl;
	}

	public String getFileCenterUploadUrl() {
		return fileCenterUploadUrl;
	}

	public void setFileCenterUploadUrl(String fileCenterUploadUrl) {
		this.fileCenterUploadUrl = fileCenterUploadUrl;
	}

	public String getFileCenterUploadToken() {
		return fileCenterUploadToken;
	}

	public void setFileCenterUploadToken(String fileCenterUploadToken) {
		this.fileCenterUploadToken = fileCenterUploadToken;
	}

	public boolean getJpush_isApnsProd() {
		return jpush_isApnsProd;
	}

	public void setJpush_isApnsProd(String jpush_isApnsProd) {
		this.jpush_isApnsProd = BooleanUtils.toBoolean(jpush_isApnsProd);
	}

}
