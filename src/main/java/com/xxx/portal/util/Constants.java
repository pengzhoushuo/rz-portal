package com.xxx.portal.util;

public class Constants {
 
	public static final int ROLE_CENTER_ADMIN = 1; // 中心管理员
	
	public static final int ROLE_MEMBER_SUPER_ADMIN = 2; // 会员超级管理员
	
	public static final int ROLE_MEMBER_ADMIN = 3; // 节点管理员
	
	public static final int ROLE_MEMBER_MANAGER = 4;  // 客户经理
	
	public static final int ROLE_MEMBER_CUSTOMER_SERVICE = 5; // 客服
	
	/**中心组织构架根节点编码**/
	public static final String ORG_CODE_ROOT = "1";
	
	public static final String STATUS_BANNER_UNACTIVE = "0";
	
	public static final String STATUS_BANNER_ACTIVE = "1";
	
	public static final int MAX_BANNER_COUNT_ACTIVEE = 3;
	
	/**Banner页图片最大限制 4M**/
	public static final int MAXSIZE_BANNER_IMG = 4*1024*1024;
	
	/**LOGO页图片最大限制 4M**/
	public static final int MAXSIZE_LOGO_IMG = 4*1024*1024;
	
	public static final String FLOW_TO_M2U = "M2U";
	
	public static final String SEND_STATUS_SUCCESS = "SEND_SUCC";
	
	public static final String SEND_STATUS_FAIL = "SEND_FAIL";
	
	/**组织机构树cache**/
	public static final String CACHE_KEY_ORG_TREE = "ORG_INFO_TREE";
	
	public static final String ORG_INFO_ISADMIN_YES = "YES"; // 是独立的子管理节点
	public static final String ORG_INFO_ISAMIN_NO = "NO"; // 普通子节点
}
