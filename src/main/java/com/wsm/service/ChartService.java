package com.wsm.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.springframework.stereotype.Service;

import com.wsm.model.MeterReading;
import com.wsm.model.User;
import com.wsm.newpojo.Readings;

@Transactional
@Service("chartservice")
public class ChartService {

	public List<Readings> getReadingData(User user) throws HibernateException {
		
		List<Readings> readingList = new ArrayList();
		
		try{
		SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query houseHoldquery = session.createQuery("select household.oid from NeutralUser where userOid=:oid");
		houseHoldquery.setParameter("oid", user.getOid());
		List result1 = houseHoldquery.list();
		int householdID = 0;
		System.out.println(user.getOid());
		for (Object object : result1) {
			householdID = (int) object;
			System.out.print("Result objects: " + object);
		}
		
		Query smartMeterquery = session.createQuery("select smartMeter.oid from Household where oid=:householdID");
		smartMeterquery.setParameter("householdID", householdID);
		List result2 = smartMeterquery.list();
		int smartMeterID = 0;
		for (Object object : result2) {
			smartMeterID = (int) object;
			System.out.print("Result objects: " + object);
		}
		Query readingDataquery = session.createQuery("from MeterReading where smartMeter.oid=:smartMeterID order by readingDateTime");

		readingDataquery.setParameter("smartMeterID", smartMeterID);
		List result3 = readingDataquery.list();

		
		for (Object object : result3) {
			MeterReading readingFromDB = (MeterReading) object;// casting to
																// type of
																// MeterReading=bigdecimal,
																// date

			Readings reading = new Readings();

			reading.setReadingTimeStamp(readingFromDB.getReadingDateTime());
			reading.setTotalConsumption(readingFromDB.getTotalConsumptionAdjusted());

			readingList.add(reading);
		}
		session.getTransaction().commit();
		session.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return readingList;
	}
}