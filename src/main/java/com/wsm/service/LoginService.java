package com.wsm.service;

import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.ietf.jgss.Oid;
import org.springframework.stereotype.Service;

import com.wsm.model.User;

@Transactional	
@Service("loginService")
public class LoginService {

	public int getLoginId(User user) throws HibernateException {
		String response = "";
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
}
