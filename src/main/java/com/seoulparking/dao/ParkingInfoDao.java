package com.seoulparking.dao;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.seoulparking.dto.ParkingInfoDto;

public interface ParkingInfoDao extends MongoRepository<ParkingInfoDto, Long>{
	public List<ParkingInfoDto> findByPname(String pname);  //변수 지정 조회
	public List<ParkingInfoDto> findAll();  //모든 collection 조회
	public List<ParkingInfoDto> findByAddr2(String addr2);  //mapping value 변수로 지정 

}
