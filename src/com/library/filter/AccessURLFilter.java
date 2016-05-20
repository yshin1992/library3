
package com.library.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import com.library.constants.SysConstants;
import com.library.constants.UrlConstants;
import com.library.entity.LoginUserInfo;
import com.library.util.LogUtil;

@WebFilter(filterName = "accessURLFilter", urlPatterns = "*.html")
public class AccessURLFilter implements Filter
{

    @Override
    public void destroy()
    {

    }

    /**
     * 监视用户访问的URL
     * 并传递用户当前访问的位置
     */
    @Override
    public void doFilter(ServletRequest request , ServletResponse response , FilterChain chain) throws IOException,
            ServletException
    {
        HttpServletRequest req = (HttpServletRequest) request;
        LoginUserInfo loginUserInfo = (LoginUserInfo) req.getSession().getAttribute(
                SysConstants.SESSION_KEY_LOGIN_USER_INFO);
        String accessUrl=req.getRequestURI();
        //对访问的地址出现jsessionid进行处理
        if(accessUrl.indexOf(";jsessionid")!=-1){
            accessUrl=accessUrl.substring(0, accessUrl.indexOf(";jsessionid"));
        }
        //对于登录页面进行放行
        if(accessUrl.endsWith(req.getServletContext().getContextPath()+UrlConstants.LOGIN_HTML) && loginUserInfo == null){
            chain.doFilter(request, response);
            return;
        }
        //其他页面进行鉴权
        if (loginUserInfo != null)
        {
            accessUrl=req.getRequestURI().replace(req.getServletContext().getContextPath()+SysConstants.PATH_SEPARATOR, "");
            //进行鉴权
            if (null != loginUserInfo.getUrlFunc().get(accessUrl))
            {
                req.setAttribute(SysConstants.ACCESS_URL, accessUrl);
                chain.doFilter(request, response);
                return;
            }
        }
        LogUtil.getLogger(this).warn(req.getRequestURI()+"请求被拒绝!");
        request.getRequestDispatcher(UrlConstants.ROOT_PATH).forward(request, response);
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException
    {

    }

}
