package com.xxx.portal.domain;

import java.io.Serializable;

import com.xxx.portal.util.Constants;

/**
 * 存于session中的用户相关信息
 * 
 * @author peng
 */
public class LoginUser implements Serializable {

	private static final long serialVersionUID = 846261705792643592L;

	// 默认值为default，不可修改
	private String userName = "default";
	private String memberCode = "default";
	private String memberId = "default";

	private String userCode = "default";
	private String orgPath = "default";
	private String orgCode = "default";

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	private int role;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public String getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}

	public boolean isAdmin() {
		return this.getRole() <= Constants.ROLE_MEMBER_ADMIN;
	}

	public String getOrgPath() {
		return orgPath;
	}

	public void setOrgPath(String orgPath) {
		this.orgPath = orgPath;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

}
