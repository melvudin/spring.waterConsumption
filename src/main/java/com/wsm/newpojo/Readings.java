package com.wsm.newpojo;

import java.math.BigDecimal;
import java.util.Date;


public class Readings {
	private Date readingTimeStamp;
	private BigDecimal totalConsumption;
	public Date getReadingTimeStamp() {
		return readingTimeStamp;
	}
	public void setReadingTimeStamp(Date readingTimeStamp) {
		this.readingTimeStamp = readingTimeStamp;
	}
	public BigDecimal getTotalConsumption() {
		return totalConsumption;
	}
	public void setTotalConsumption(BigDecimal totalConsumption) {
		this.totalConsumption = totalConsumption;
	}
}
