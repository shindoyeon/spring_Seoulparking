package com.seoulparking.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.seoulparking.dao.ParkingInfoDao;
import com.seoulparking.dto.ParkingInfoDto;

@SuppressWarnings("hiding")
@RestController
public class ParkingInfoController<ParkingInfoDto> {

	@Autowired
	private ParkingInfoDao infodao;

	@RequestMapping(value = "/pname")
	public List<ParkingInfoDto> findByPname(String pname ) throws Exception {
		return (List<ParkingInfoDto>) infodao.findByPname("리츠칼튼호텔");  
	}
	
	@RequestMapping(value = "/all")
	public List<ParkingInfoDto> findAll() throws Exception {
		List<ParkingInfoDto> result = new ArrayList<ParkingInfoDto>();
		result= (List<ParkingInfoDto>) infodao.findAll();
		
		for(ParkingInfoDto rs :result)
			System.out.println("출력:"+rs);
		return result;
	}
	
	@RequestMapping(value = "/{addr2}")
	public List<ParkingInfoDto> findByAddr2(@PathVariable String addr2) throws Exception {
		return (List<ParkingInfoDto>) infodao.findByAddr2(addr2); 
	}
}
