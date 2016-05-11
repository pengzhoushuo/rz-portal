package com.xxx.portal.cache.impl;

import java.util.*;
import java.lang.ref.*;

public class SoftHashMap extends AbstractMap {
	
	/** The internal HashMap that will hold the SoftReference. */
	private final Map hash = new HashMap();
	
	/** The number of "hard" references to hold internally. */
	private final int HARD_SIZE;

	/** The FIFO list of hard references, order of last access. */
	private final LinkedList hardCache = new LinkedList();
	
	/** Reference queue for cleared SoftReference objects. */
	private ReferenceQueue queue = new ReferenceQueue();

	// Strong Reference number
	public SoftHashMap() {
		this(100);
	}

	public SoftHashMap(int hardSize) {
		HARD_SIZE = hardSize;
	}

	public Object get(Object key) {
		Object result = null;
		// We get the SoftReference represented by that key
		SoftReference soft_ref = (SoftReference) hash.get(key);
		if (soft_ref != null) {
			result = soft_ref.get();
			if (result == null) {
				hash.remove(key);
			} else {
				hardCache.addFirst(result);
				if (hardCache.size() > HARD_SIZE) {
					hardCache.removeLast();
				}
			}
		}
		return result;
	}

	/**
	 * We define our own subclass of SoftReference which contains not only the
	 * value but also the key to make it easier to find the entry in the HashMap
	 * after it's been garbage collected.
	 */
	private static class SoftValue extends SoftReference {
		private final Object key; // always make data member final

		/**
		 * Did you know that an outer class can access private data members and
		 * methods of an inner class? I didn't know that! I thought it was only
		 * the inner class who could access the outer class's private
		 * information. An outer class can also access private members of an
		 * inner class inside its inner class.
		 */
		private SoftValue(Object k, Object key, ReferenceQueue q) {
			super(k, q);
			this.key = key;
		}
	}

	/**
	 * Here we go through the ReferenceQueue and remove garbage collected
	 * SoftValue objects from the HashMap by looking them up using the
	 * SoftValue.key data member.
	 */
	public void processQueue() {
		SoftValue sv;
		while ((sv = (SoftValue) queue.poll()) != null) {
			hash.remove(sv.key); // we can access private data!		}
	}
	/**
	 * Here we put the key, value pair into the HashMap using a SoftValue
	 * object.
	 */
	public Object put(Object key, Object value) {
		processQueue();
		return hash.put(key, new SoftValue(value, key, queue));
	}

	public Object remove(Object key) {
		processQueue();
		return hash.remove(key);
	}

	public void clear() {
		hardCache.clear();
		processQueue();
		hash.clear();
	}

	public int size() {
		processQueue();
		return hash.size();
	}

	@SuppressWarnings("unchecked")
	public Set entrySet() {
		throw new UnsupportedOperationException();
	}
}
