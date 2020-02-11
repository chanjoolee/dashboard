package dashboard.interceptor;

import java.util.Map;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import common.service.CommonService;
import dashboard.exception.DashAuthException;
import util.WebUtil;



/**
 * 
 * @author carlos
 *
 */
public class EfAuthCheckInterceptor extends HandlerInterceptorAdapter {
    
    private final Log log = LogFactory.getLog(this.getClass()); 
    
//    @Resource(name="ef.authService")
//    private EfAuthService authService;
     

    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
        
        String uri   = WebUtil.getCommand(req).toString();
        
        //임시 톰캣용
        if(1==1)
        	return true;
        
        // .html로 접근했을때에만 권한체크를 한다.
        // .html, .ajax 로 접근했을때에만 로긴체크를 한다.
        if( uri != null && (uri.indexOf(".html") < 0) ){      //   && uri.indexOf(".ajax") < 0) ) {
        	return true;  
        }
        //
        log.debug("AuthCheckFilter::::::: -  1:" );
        // 권한체크하지 않을 uri면 패스~
        if (checkFreePathUri(uri)){       
        	return true;
        }
        //
        log.debug("AuthCheckFilter::::::: -  2:" );
        
        if(req.getParameter("sender") != null){
    		String sender = req.getParameter("sender").toString();
    		if(!sender.equals("pms"))
    			return true;
    	}else
    		throw new DashAuthException("정당한 접근이 아닙니다.");
    	
    	if(req.getParameter("cookieName") != null){
    		String reqToken = req.getParameter("cookieToken").toString();
    		String cookieName = req.getParameter("cookieName").toString();
        	String cookieValue = CommonService.getCookie(req, cookieName);
        	 if(reqToken.equals(cookieValue)){
        		 return true;
        	 }else
        		 throw new DashAuthException("정당한 접근이 아닙니다.");
    	}else{
    		throw new DashAuthException("정당한 접근이 아닙니다.");
    	}
        
        //log.debug("AuthCheckFilter::::::: -  end:" );
        
        //return true;
    }
    
    
    /**
     * <PRE>
     * 권한 체크를 할 URI여부 체크 - index페이지와 공통모듈들.
     * <PRE>
     * @param sUrl
     * @return
     */
    private boolean checkFreePathUri(String sUri) {
    	
        String[] ableUri = {
        		"Json"
        		,"issue"
        		,"codesonar"
        		,"codeComplexity"
        		,"codeComplexHistory"
        		,"codeComplexStatus"
        		,"codeComplexTrends"
        		,"projectMultiByPCnt"
        }; 
        
        String[] wkArr  = sUri.split("[.]");    // .do 분리
        String[] uriArr = null; 
        String   wkUriLast = wkArr[0];
        
        if(wkArr.length > 1){
        	wkUriLast = wkArr[wkArr.length-2];
        } 
        
        //--log.debug("AuthCheckFilter::::::: -  wkUriLast:" + wkUriLast);
    	uriArr = wkUriLast.split("[/]");   
        
        for (int idx=0; idx < ableUri.length; idx++) { 
        	//--log.debug("AuthCheckFilter::::::: -  uriArr[uriArr.length-1]:" + uriArr[uriArr.length-1]);
        	//--log.debug("AuthCheckFilter::::::: -  ableUrl[idx]:" + ableUri[idx]); 
            if ( uriArr[uriArr.length-1].endsWith(ableUri[idx])) { 
                return true; 
            }
        }
        //
        return false;
        //return true;    // 임시 15.03.12
    }    
}
