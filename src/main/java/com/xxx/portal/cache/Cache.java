package com.xxx.portal.cache;

/**
 * Cache接口
 * @author peng
 */
public interface Cache {

	public void put(String key, Object value, long expireMillionSecond);
	
	public Object get(String key);
	
	public <T extends Object> T get(String key, Class<T> c);
	
	public int size();
	
	public boolean isEmpty();
	
	public void clear();
	
	public void remove(String key);
}
