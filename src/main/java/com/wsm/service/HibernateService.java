package com.wsm.service;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateService {
	private static SessionFactory sessionFactory;

	public static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			Configuration configuration = new Configuration().configure();
			sessionFactory = configuration.buildSessionFactory();
		}
		return sessionFactory;
	}
}