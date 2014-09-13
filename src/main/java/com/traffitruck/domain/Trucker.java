package com.traffitruck.domain;

public class Trucker {

	private String id;
	private String name;
	private int loadSize;

	public void setName(String name) {
		this.name = name;
	}
	
	public void setLoadSize(int loadSize) {
		this.loadSize = loadSize;
	}
	
	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public int getLoadSize() {
		return loadSize;
	}

	@Override
	public String toString() {
		return "Trucker [id=" + id + ", name=" + name + ", loadSize=" + loadSize + "]";
	}
}
