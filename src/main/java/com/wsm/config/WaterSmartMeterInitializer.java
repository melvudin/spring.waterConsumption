package com.wsm.config;

import javax.servlet.Filter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WaterSmartMeterInitializer extends AbstractAnnotationConfigDispatcherServletInitializer  {  

	/*@Override  
	public void onStartup(ServletContext servletContext) throws ServletException {  

		AnnotationConfigWebApplicationContext ctx = new AnnotationConfigWebApplicationContext();  
		ctx.register(WaterSmartMeterConfiguration.class);  

		ctx.setServletContext(servletContext);    

		Dynamic servlet = servletContext.addServlet("dispatcher", new DispatcherServlet(ctx));  
		servlet.addMapping("/");  
		servlet.setLoadOnStartup(1);  

	}  */


	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] { WaterSmartMeterConfiguration.class };
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}



}