package com.xxx.portal.webframework.domain;

import java.io.Serializable;
import java.util.List;

public class PageResponse<T> implements Serializable {
	
	private static final long serialVersionUID = 371793833489520776L;
	
	public int current=0;
	public int rowCount=10;
	public int total=-1;
	public List<T> rows;
	
	

	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
	public int getCurrent() {
		return current;
	}
	public void setCurrent(int current) {
		this.current = current;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
}
