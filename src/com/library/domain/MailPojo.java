package com.library.domain;

public class MailPojo implements AbstractModel {

	private static final long serialVersionUID = -6042275818764642589L;

	private Long aiid;

	private String mailFrom;

	private String mailTo;

	private String subject;

	private String content;

	public Long getAiid() {
		return aiid;
	}

	public void setAiid(Long aiid) {
		this.aiid = aiid;
	}

	public String getMailFrom() {
		return mailFrom;
	}

	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}

	public String getMailTo() {
		return mailTo;
	}

	public void setMailTo(String mailTo) {
		this.mailTo = mailTo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "MailPojo [aiid=" + aiid + ", mailFrom=" + mailFrom
				+ ", mailTo=" + mailTo + ", subject=" + subject + ", content="
				+ content + "]";
	}

}
