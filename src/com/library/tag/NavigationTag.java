
package com.library.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.library.cache.SystemCache;
import com.library.constants.SysConstants;
import com.library.entity.LoginUserInfo;
import com.library.entity.SysFunc;

public class NavigationTag extends SimpleTagSupport
{
    /**
     * css样式
     */
    private String cssClass;

    public String getCssClass()
    {
        return cssClass;
    }

    public void setCssClass(String cssClass)
    {
        this.cssClass = cssClass;
    }

    @Override
    public void doTag() throws JspException, IOException
    {
        StringBuilder navBuilder = new StringBuilder();
        boolean isLast=true;
        PageContext pageCtx = (PageContext) getJspContext();
        HttpServletRequest request = (HttpServletRequest) pageCtx.getRequest();
        LoginUserInfo loginUserInfo = (LoginUserInfo) request.getSession().getAttribute(
                SysConstants.SESSION_KEY_LOGIN_USER_INFO);
        SysFunc sysFunc = loginUserInfo.getUrlFunc().get(request.getAttribute(SysConstants.ACCESS_URL));
        if (sysFunc != null)
        {
        	if("Button".equals(sysFunc.getFuncType())){
        	    isLast=false;
        		navBuilder.append("<li class='active'>").append(sysFunc.getFuncName()).append("</li>");
        		List<SysFunc> sysFuncs=loginUserInfo.getSysFunc();
        		for(SysFunc tmp:sysFuncs){
        			if(tmp.getAiid()==sysFunc.getParentId()){
        				sysFunc=tmp;
        				break;
        			}
        		}
        	}
        	if(isLast){
        	    navBuilder.insert(0,"</li>").insert(0,sysFunc.getFuncName()).insert(0,"</a></li><li class='active'>");
        	}else{
        	    navBuilder.insert(0,"</a></li>").insert(0,sysFunc.getFuncName()).insert(0,"</a></li><li><a href='javascript:void(0)'>");
        	}
        	navBuilder.insert(0,SystemCache.getInstance().getSysFuncMap().get(sysFunc.getParentId()).getFuncName())
            .insert(0, "<li><a href='javascript:void(0)'>");
        }
        navBuilder.insert(0, "<ol class='"+cssClass+"'><span class='glyphicon glyphicon-home' aria-hidden='true'></span> ");
        navBuilder.append("</ol>");
        getJspContext().getOut().println(navBuilder);
        getJspContext().getOut().flush();
    }
}
