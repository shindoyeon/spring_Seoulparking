package com.seoulparking.dto;

import org.springframework.data.mongodb.core.mapping.Document;
import lombok.Data;

@Data
@Document(collection="parking")  
public class ParkingInfoDto {

	private String pname;
	//private String addr1;  
	private String addr2;
	private String total;
	//private String avail;
	//private List<String> rate;
	//private List<String> time;
}

