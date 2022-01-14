package com.sennet.bizcommon.customer;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.bizcommon.currency.CurrencyVo;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateVo;
import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;
import com.sennet.util.CustomerInfoProtect;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class CustomerService {
	
	@Autowired
	private CustomerDao customerDao;

	@Autowired
	private ModelMapper modelMapper;

	// insert Customer
		public int insertCustomer(CustomerVo paramVo) {
			CustomerVo customerVo = modelMapper.map(paramVo, CustomerVo.class);
			
			CustomerVo customerTempVo = customerDao.findOneCustomer(paramVo.getCifNo());
			if (customerTempVo != null) {
				throw new DuplicatedException(paramVo.getCifNo());
			}
			CustomerInfoProtect customerInfoProtect = new CustomerInfoProtect();
			customerVo.setCifNo(paramVo.getCifNo());
			customerVo.setBrnNo(paramVo.getBrnNo());
			customerVo.setResidentCd(paramVo.getResidentCd());
			customerVo.setResidentNo(customerInfoProtect.encryptInfo(paramVo.getResidentNo()));
			customerVo.setEngFirstName(paramVo.getEngFirstName());
			customerVo.setEngLastName(paramVo.getEngLastName());
			customerVo.setKorFirstName(paramVo.getKorFirstName());
			customerVo.setKorLastName(paramVo.getKorLastName());
			customerVo.setHabitationCd(paramVo.getHabitationCd());
			customerVo.setNationalCode(paramVo.getNationalCode());
			customerVo.setTelNo(paramVo.getTelNo());
			customerVo.setCellNo(paramVo.getCellNo());
			customerVo.setZipCode(paramVo.getZipCode());
			customerVo.setAddr1(paramVo.getAddr1());
			customerVo.setAddr2(paramVo.getAddr2());
			customerVo.setOrCifFlag(paramVo.getOrCifFlag());
			customerVo.setOrEngAddr1(paramVo.getOrEngAddr1());
			customerVo.setOrEngAddr2(paramVo.getOrEngAddr2());
			customerVo.setOrEngAddr3(paramVo.getOrEngAddr3());
			customerVo.setOrEngAddr4(paramVo.getOrEngAddr4());
			customerVo.setStaCd(paramVo.getStaCd());
			customerVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
			customerVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
			customerVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			customerVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			return customerDao.saveCustomer(customerVo);
		}
		// update Customer
		public int updateCustomer(CustomerVo paramVo) {
			CustomerVo customerVo = customerDao.findOneCustomer(paramVo.getCifNo());
			if (customerVo == null) {
				throw new NotFoundException(paramVo.getCifNo());
			}
			CustomerInfoProtect customerInfoProtect = new CustomerInfoProtect();
			customerVo.setBrnNo(paramVo.getBrnNo());
			customerVo.setResidentCd(paramVo.getResidentCd());
			customerVo.setResidentNo(customerInfoProtect.encryptInfo(paramVo.getResidentNo()));
			customerVo.setEngFirstName(paramVo.getEngFirstName());
			customerVo.setEngLastName(paramVo.getEngLastName());
			customerVo.setKorFirstName(paramVo.getKorFirstName());
			customerVo.setKorLastName(paramVo.getKorLastName());
			customerVo.setHabitationCd(paramVo.getHabitationCd());
			customerVo.setNationalCode(paramVo.getNationalCode());
			customerVo.setTelNo(paramVo.getTelNo());
			customerVo.setCellNo(paramVo.getCellNo());
			customerVo.setZipCode(paramVo.getZipCode());
			customerVo.setAddr1(paramVo.getAddr1());
			customerVo.setAddr2(paramVo.getAddr2());
			customerVo.setOrCifFlag(paramVo.getOrCifFlag());
			customerVo.setOrEngAddr1(paramVo.getOrEngAddr1());
			customerVo.setOrEngAddr2(paramVo.getOrEngAddr2());
			customerVo.setOrEngAddr3(paramVo.getOrEngAddr3());
			customerVo.setOrEngAddr4(paramVo.getOrEngAddr4());
			customerVo.setStaCd(paramVo.getStaCd());

			customerVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			customerVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			
			return customerDao.saveCustomer(customerVo);
		}

		// delete Customer
		public int delete(String cifNo) {
			CustomerVo customerVo = customerDao.findOneCustomer(cifNo);
			if (customerVo == null) {
				throw new NotFoundException(cifNo);
			}
			// 삭제는 상태코드를 '9' 로 
			customerVo.setStaCd("9");

			customerVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			customerVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			return customerDao.saveCustomer(customerVo);
		}
		
		// 리스트 조회
		public List<CustomerVo> searchListCustomer(String cifNo, String brnNo, String engFirstName) {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("cifNo", cifNo);
			condition.put("brnNo", brnNo);
			condition.put("engFirstName", engFirstName);
			
			List<CustomerVo> allCustomer = customerDao.searchListCustomer(condition);
			
	        String info;
	        String decInfo;
	        CustomerInfoProtect customerInfoProtect = new CustomerInfoProtect();
	        
	        Iterator<CustomerVo> itr = allCustomer.iterator();
	        CustomerVo response = null;
	        while(itr.hasNext()){
	        	response = itr.next();
	        	
	        	response.getResidentNo();
	        	
				info = response.getResidentNo();
				decInfo = customerInfoProtect.decryptInfo(info);
				
				response.setResidentNo(decInfo);
	        }
	        
	        return customerDao.searchListCustomer(condition);
		}
	
}
