package com.library.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.library.cache.SystemCache;
import com.library.criteria.ManagerQueryCriteria;
import com.library.domain.MailPojo;
import com.library.domain.Manager;
import com.library.entity.LoginUserInfo;
import com.library.service.MailService;
import com.library.service.ManagerService;
import com.library.util.DateUtil;
import com.library.util.LogUtil;
import com.library.vo.Pagination;

@Controller
@RequestMapping(value = "/manager")
public class ManagerController {

	@Resource
	private ManagerService<Manager> managerService;
	
	@Resource
	private MailService<MailPojo> mailService;

	@RequestMapping(value = "/head.html")
	public String getHeadJsp() {
		return "common/head";
	}

	@RequestMapping(value = "/main.html")
	public String getMainJsp() {
		return "common/main";
	}

	@RequestMapping(value = "/menu.html")
	public String getMenuJsp() {
		return "common/menu";
	}

	@RequestMapping(value = "/managerinfo.html")
	public String getMgrInfoJsp() {
		return "manager/managerinfo";
	}

	@RequestMapping(value = "/updatemgrinfo.html")
	public String getUpdateMgrInfoJsp() {
		return "manager/updatemgrinfo";
	}

	@RequestMapping(value = "/updateMgrCmt.html")
	public String updateMgrInfo(Manager manager, HttpServletRequest request) {
		// 如果更新信息成功，则将缓存中的manager信息更新
		if (managerService.update(manager) == 1) {
			LoginUserInfo loginUserInfo = SystemCache.getInstance()
					.getLoginUserWithSessionId(request.getSession().getId());
			Manager tmp = (Manager) loginUserInfo.getModel();
			manager.setRoleId(tmp.getRoleId());
			manager.setStatus(tmp.getStatus());
			// 更新缓存中的manager信息
			loginUserInfo.setModel(manager);
		}
		return "manager/managerinfo";
	}

	@RequestMapping(value = "/addmanager.html")
	public String getAddMgrJsp() {
		return "manager/addmanager";
	}

	@RequestMapping(value = "/addMgrCmt.html")
	public String addMgrCmt(Manager manager, HttpServletRequest request) {
		String managerID = manager.getManagerID();
		try {
			// 管理员的初始化密码为身份证的后六位
			manager.setPassword(DigestUtils.md5DigestAsHex(managerID.substring(
					managerID.length() - 6).getBytes()));
			managerService.insert(manager);
			// 通过查询验证新增管理员是否成功
			manager = managerService.query(manager);
			if (null != manager) {
				request.setAttribute("addUser", manager);
				return "manager/addmanagercmt";
			}
		} catch (Exception e) {
			request.setAttribute("addMgrError", "新增管理员失败!");
		}
		return "manager/addmanager";
	}

	@RequestMapping(value = "/delmanager.html")
	public ModelAndView getDelMgrJsp(ManagerQueryCriteria criteria) {
		ModelAndView mv = new ModelAndView("manager/delmanager");
		Pagination<Manager> pagination = managerService.queryByPage(criteria);
		mv.addObject("bean", criteria);
		mv.addObject("mgrList", pagination);
		return mv;
	}

	@RequestMapping(value = "/delMgrCmt.html")
	public ModelAndView delMgrCmt(HttpServletRequest request,ManagerQueryCriteria criteria) {
		ModelAndView mv=new ModelAndView("manager/delmanager");
		String[] ids = request.getParameterValues("ids");
		if (ids != null) {
			try{
				managerService.batchDelete(ids);
			}catch(Exception e){
				LogUtil.getLogger(this).warn("批量删除管理员失败", e);
			}
			
		}
		Pagination<Manager> pagination = managerService.queryByPage(criteria);
		mv.addObject("bean", criteria);
		mv.addObject("mgrList", pagination);
		return mv;
	}

	@RequestMapping(value = "/querymanager.html")
	public ModelAndView getMgrListJsp(ManagerQueryCriteria criteria) {
		ModelAndView mv = new ModelAndView("manager/managerlist");
		Pagination<Manager> pagination = managerService.queryByPage(criteria);
		mv.addObject("bean", criteria);
		mv.addObject("mgrList", pagination);
		return mv;
	}

	@RequestMapping(value = "/upload.html")
	public String getUploadJsp() {
		return "manager/uploadphoto";
	}

	@RequestMapping(value = "/uploadCmt.html")
	public String uploadCmt(@RequestParam("photo") MultipartFile photo,
			HttpServletRequest request) {
		if (!photo.isEmpty()) {
			try {
				LoginUserInfo loginUserInfo = SystemCache
						.getInstance()
						.getLoginUserWithSessionId(request.getSession().getId());
				Manager manager = (Manager) loginUserInfo.getModel();
				byte[] bytes = photo.getBytes();
				manager.setPhoto(bytes);
				managerService.updatePhoto(manager);
				return "manager/managerinfo";
			} catch (IOException e) {
				LogUtil.getLogger(this).warn("上传头像失败!", e);
			}
		}
		return "manager/upload";
	}

	@RequestMapping(value = "/showPhoto.do")
	public void showPhoto(@RequestParam("managerID") String managerID,
			HttpServletResponse response) {
		Manager manager = managerService.getPhoto(managerID);
		OutputStream out = null;
		InputStream fis = null;
		try {
			out = response.getOutputStream();
			if (null != manager) {
				byte[] photoBytes = manager.getPhoto();
				if (null != photoBytes && photoBytes.length > 0) {
					response.setHeader("Cache-Control", "no-store");
					response.setHeader("Pragma", "no-cache");
					response.setDateHeader("Expires", 0);
					out.write(photoBytes);
					out.flush();
				}
			} else {
				// 显示一张默认头像
				File file = new File(this.getClass().getClassLoader()
						.getResource("/").getPath()
						+ "default.jpg");
				fis = new FileInputStream(file);
				byte[] data = new byte[1024];
				int len;
				while ((len = fis.read(data)) != -1) {
					out.write(data, 0, len);
				}
				out.flush();

			}
		} catch (IOException e) {
			LogUtil.getLogger(this).warn("显示头像失败!", e);
		} finally {
			try {
				if (null != fis) {
					fis.close();
					fis = null;
				}
				if (null != out) {
					out.close();
					out = null;
				}
			} catch (Exception ex) {
				LogUtil.getLogger(this).warn("关闭ServletOutputStream异常：", ex);
			}
		}
	}

	@RequestMapping(value = "/updateMgrPswd.html")
	public String getUpdateMgrPswdJsp() {
		return "manager/updatepswd";
	}
	
	@RequestMapping(value="/updateMgrPswdCmt.html")
	public String updateMgrPswdCmt(HttpServletRequest request){
		String oldPswd=request.getParameter("oldPswd");
		String newPswd=request.getParameter("newPswd");
		LoginUserInfo loginUserInfo=SystemCache.getInstance().getLoginUserWithSessionId(request.getSession().getId());
		Manager manager=(Manager) loginUserInfo.getModel();
		if(managerService.updatePswd(manager, oldPswd, newPswd)){
			request.setAttribute("password_update_result", "更改密码成功!");
			/**
			 * 发送邮件进行通知
			 */
			if(manager.getEmail()!=null){
				String subject="更改密码成功";
				String content="您于"+DateUtil.getStringDate()+"更新了密码，请确认是否是本人的操作。若非本人操作，请及时与系统管理员联系。";
				mailService.sendMailForUpdatePswd(manager.getEmail(), subject, content);
			}
		}else{
			request.setAttribute("password_update_result", "更改密码失败!");
		}
		return "manager/updatepswdcmt";
	}
	
}
