package com.wsm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.springframework.stereotype.Service;

import com.wsm.model.User;

@Transactional	
@Service("loginService")
public class LoginService {

	public int getLoginId(User user) throws HibernateException {
		
		SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
	    Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session.createQuery(
				"select oid from User where password=:password and username=:username");
		query.setParameter("username", user.getUsername());
		query.setParameter("password", user.getPassword());
		List result = query.list();
		int oid=0;
		for (Object object : result) {
			oid=(int)object;
			System.out.print("Result objects: " + object);
		}
		
		session.getTransaction().commit();
		session.close();
		
		return oid;
	}

	public Map<String, Object> getUserData(User user) {
		Map<String, Object> result = new HashMap<String, Object>();
		SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();

		Session session = sessionFactory.openSession();

		int houseid = 0;
		int smartid = 0;
		Long consumptionTypecount = null;
		int buildingid = 0;
		try {

			session.beginTransaction();

			String houseidCheck = "select household.oid from NeutralUser where user_oid=:id";

			Query houseidCheckQuery = session.createQuery(houseidCheck);

			houseidCheckQuery.setParameter("id", user.getOid());

			List houseidResult = houseidCheckQuery.list();

			for (Object id : houseidResult) {
				if (id != null) {
					houseid = (int) id;
				}
			}

			result.put("houseid", Integer.toString(houseid));
			

			String smartMeterid = "select smartMeter.oid from Household where oid=:houseid";

			Query smartidQuery = session.createQuery(smartMeterid);

			smartidQuery.setParameter("houseid", houseid);

			List smartidQueryResult = smartidQuery.list();

			for (Object id : smartidQueryResult) {
				if (id != null) {
					smartid = (int) id;
				}
			}

			// setSmartMeterId
			result.put("smartid", Integer.toString(smartid));

			String consumptionType = "select count(*) from Household where smart_meter_oid=:smartid";

			Query consumptionTypeQuery = session.createQuery(consumptionType);

			consumptionTypeQuery.setParameter("smartid", smartid);

			List consumptionTypeQueryResult = consumptionTypeQuery.list();

			for (Object id : consumptionTypeQueryResult) {
				if (id != null) {
					consumptionTypecount = (Long) id;
				}
			}

			if (consumptionTypecount > 1) {
				result.put("consumption", "common");
			} else {
				result.put("consumption", "individual");
			}

			String building = "select building.oid from Household where oid=:houseid";

			Query buildingQuery = session.createQuery(building);

			buildingQuery.setParameter("houseid", houseid);

			List buildingQueryResult = buildingQuery.list();

			for (Object id : buildingQueryResult) {
				if (id != null) {
					buildingid = (int) id;
				}
			}

			result.put("buildingid", Integer.toString(buildingid));
			
			String zipCountry = "select district.zipcode,district.country from District district where oid=(select district.oid from Building where oid=:buildingid)";

			Query zipCountryQuery = session.createQuery(zipCountry);

			zipCountryQuery.setParameter("buildingid", buildingid);

			List<Object[]> zipCountryQueryResult = zipCountryQuery.list();

			for (Object[] object : zipCountryQueryResult) {

				result.put("zipcode", (String) object[0]);
				result.put("country", (String) object[1]);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			session.close();
		}	
		
		return result;
	}
}
