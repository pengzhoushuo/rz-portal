package com.xxx.portal.cache.impl;

import com.xxx.portal.cache.Cache;

public class SoftHashMapCacheImpl implements Cache{
	
	public static final int DEFAULT_HARD_SIZE = 1000;
	
	private static SoftHashMapCacheImpl instance;
	
	//static block
	static{
		init();
	}
	
	public static void init(){
		instance = new SoftHashMapCacheImpl();
	}
	
	public static SoftHashMapCacheImpl getInstance(){
		if(instance == null){
			init();
		}
		return instance;
	}
	
	//holder
	private SoftHashMap softHashMap;
	
	public SoftHashMapCacheImpl(){
		this(DEFAULT_HARD_SIZE);
	}
	
	public SoftHashMapCacheImpl(int hardSize){
		this.softHashMap = new SoftHashMap(hardSize);
	}
	
	public void clear() {
		softHashMap.clear();
	}

	public Object get(String key) {
		CacheValue value = (CacheValue)softHashMap.get(key);
		if(value != null){
			if(value.isExpire()){
				this.remove(key);
				return null;
			}else{
				return value.getData();
			}
		}else{
			return null;
		}
	}

	public <T extends Object> T get(String key, Class<T> c) {
		Object obj = this.get(key);
		if(obj != null){
			return (T)obj;
		}else{
			return null;
		}
	}

	public boolean isEmpty() {
		return softHashMap.isEmpty();
	}

	public void put(String key, Object value, long expireMillionSecond) {
		CacheValue cacheValue = new CacheValue();
		cacheValue.setCreateTime(System.currentTimeMillis());
		cacheValue.setExpireMillionSecond(expireMillionSecond);
		cacheValue.setData(value);
		softHashMap.put(key, cacheValue);
	}

	public int size() {
		return softHashMap.size();
	}

	public void remove(String key){
		softHashMap.remove(key);
	}
	
	public static class CacheValue{
		private long createTime;
		private long expireMillionSecond;
		private Object data;
		
		public long getCreateTime() {
			return createTime;
		}

		public void setCreateTime(long createTime) {
			this.createTime = createTime;
		}

		public long getExpireMillionSecond() {
			return expireMillionSecond;
		}

		public void setExpireMillionSecond(long expireMillionSecond) {
			this.expireMillionSecond = expireMillionSecond;
		}
		public Object getData() {
			return data;
		}

		public void setData(Object data) {
			this.data = data;
		}

		public boolean isExpire(){
			return (System.currentTimeMillis() > this.createTime + this.expireMillionSecond);
		}
	}
}
