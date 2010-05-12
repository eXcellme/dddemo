package com.redhat.demo.core;

import com.dayatang.i18n.impl.ResourceBundleI18nService;
import com.dayatang.i18n.support.I18nServiceAccessor;


public class DemoResourceBundleI18nService extends ResourceBundleI18nService {

	public DemoResourceBundleI18nService() {
		setBasename("com.redhat.demo.messages");
		
	}

	// ~ Methods
	// ========================================================================================================

	private static I18nServiceAccessor accessor;
	private static I18nServiceAccessor getAccessor() {
		if(accessor==null)
			accessor = new I18nServiceAccessor(new DemoResourceBundleI18nService());
		return accessor;
	}
	
	public static String getMessage(String code, String defaultMessage){
		String message = getAccessor().getMessage(code,defaultMessage);
//		try {
//			message = new String(message.getBytes("utf-8"));
//		} catch (Exception e) {}
		return message;
	}
}
