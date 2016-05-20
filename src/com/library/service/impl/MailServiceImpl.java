package com.library.service.impl;

import javax.annotation.Resource;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.library.dao.MailDao;
import com.library.domain.MailPojo;
import com.library.service.MailService;
import com.library.util.LogUtil;

@Service("mailService")
public class MailServiceImpl implements MailService<MailPojo> {

	@Resource
	private MailDao<MailPojo> mailDao;
	
	@Resource
	private JavaMailSenderImpl mailSender;
	
	@Override
	public Integer insert(MailPojo t) {
		return null;
	}

	@Override
	public Integer delete(MailPojo t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MailPojo query(MailPojo t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer update(MailPojo t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void sendMailForUpdatePswd(String mailTo,String subject,String content) {
		// TODO Auto-generated method stub
		try{
			SimpleMailMessage smm=new SimpleMailMessage();
			smm.setFrom(mailSender.getUsername());
			smm.setTo(mailTo);
			smm.setSubject(subject);
			smm.setText(content);
			mailSender.send(smm);
			
			MailPojo mailPojo=new MailPojo();
			mailPojo.setMailFrom(mailSender.getUsername());
			mailPojo.setMailTo(mailTo);
			mailPojo.setSubject(subject);
			mailPojo.setContent(content);
			mailDao.insert(mailPojo);
		}catch(Exception e){
			LogUtil.getLogger(this).warn("发送邮件失败！",e);
		}
		
	}

}
