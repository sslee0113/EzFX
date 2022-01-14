package com.sennet.dashboard;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.io.File;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.common.SennetProperty;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DashboardController {

//	@Autowired
//	private MsgsetService service;
//
//	@Autowired
//	private MsgsetRepository repository;
//	@Autowired
//	private DocsetRepository docSetRepository;
//
	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private SennetProperty prop;

	// READ ALL
	@RequestMapping(value = "/rest/filequeue/{queueName}", method = GET)
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	public List<FileQueue> readAll(@PathVariable String queueName) {

		String dirName="";
		File dir, dirs[];
		
		FileQueue fileQueue;
		List<FileQueue> fileQueueList = new ArrayList<FileQueue>();
		
		if(queueName.equalsIgnoreCase("KTNET")){
			dirName = prop.getDashboardktnet();
		}else
		if(queueName.equalsIgnoreCase("KFTC")){
			dirName = prop.getDashboardkftc();
		}

		try{
			dir = new File(dirName);
			
			dirs = dir.listFiles();
			for(int i=0; i<dirs.length; i++){
				if(!dirs[i].isDirectory()){
					continue;
				}
				if(dirs[i].listFiles().length==0){
					continue;
				}
				fileQueue = new FileQueue();
				fileQueue.setDir(dirs[i].getName());
				fileQueue.setCount(dirs[i].listFiles().length);
				fileQueueList.add(fileQueue); 
			}
			
			// 파일의 수대로 리스트를 정렬하려면 다음 주석을 해제하면됨.
//	        DescendingObj descending = new DescendingObj();
//	        Collections.sort(fileQueueList, descending);
	        
	        Iterator<FileQueue> itr = fileQueueList.iterator();
	        while(itr.hasNext()){
	        	fileQueue = itr.next();
	        	log.info(fileQueue.toString());
	        }

		}catch(Exception e){
            log.error(e.getMessage());
//			return new ResponseEntity<FileQueue>(fileQueueList, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		log.info("fileQueueList.size:"+fileQueueList.size());
		java.lang.reflect.Type targetListType = new TypeToken<List<FileQueue>>() {}.getType();
		List<FileQueue> content = modelMapper.map(fileQueueList, targetListType);
		return content;

	}
	
	// String 내림차순
	class DescendingObj implements Comparator<FileQueue> {
	 
	    @Override
	    public int compare(FileQueue o1, FileQueue o2) {
	    	if(o1.getCount()==o2.getCount()) return 0;
	    	if(o1.getCount()<o2.getCount()) return 1;
	    	if(o1.getCount()>o2.getCount()) return -1;
	    	
	    	return 0;
	    }
	 
	}
	 
	// Integer 오름차순
	class AscendingObj implements Comparator<FileQueue> {
	 
	    @Override
	    public int compare(FileQueue o1, FileQueue o2) {
	    	if(o1.getCount()==o2.getCount()) return 0;
	    	if(o1.getCount()>o2.getCount()) return 1;
	    	if(o1.getCount()<o2.getCount()) return -1;
	    	
	    	return 0;
	    }
	 
	}
}
