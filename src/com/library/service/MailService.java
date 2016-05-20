package com.library.service;

public interface MailService<T> extends BaseService<T> {
	
	public void sendMailForUpdatePswd(String mailTo,String subject,String content);
	
}
