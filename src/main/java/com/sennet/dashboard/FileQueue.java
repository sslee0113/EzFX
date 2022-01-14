package com.sennet.dashboard;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FileQueue {
	
	String dir;
	int count;

	@Override
	public String toString() {
		return "FileQueue [dir=" + dir + ", count=" + count + "]";
	}

}
