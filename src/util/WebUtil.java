/*
 * @(#) WebUtil.java
 */
package util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.util.WebUtils;

/**
 * 
 *<pre>
 * 
 * Web Util 클래스
 * 
 * History 
 * 
 * 2011. 6. 28. 오후 2:30:11 / carlos
 * -> Spring의 StringUtils를 상속받아 확장함
 * 
 *</pre>
 * 
 * @version 0.1
 * @author carlos / carlos@envalue.biz / 작성일 : 2011. 6. 28. 오후 3:03:29 <br>
 *
 */
public final class WebUtil extends WebUtils {

    /**
     * static 접근만 허용
     */
    private WebUtil() {
    }

   

    public static synchronized String getRandomColor() {
        String s = Integer.toHexString((int)(Math.random() * 256D));
        String s1 = Integer.toHexString((int)(Math.random() * 256D));
        String s2 = Integer.toHexString((int)(Math.random() * 256D));
        return "#" + s + s1 + s2;
    }

   
    
    /**
     * 
     * @param str
     * @return
     */
    public static String escape(String str) {
        
        if (str == null) return str;
            
        StringBuffer sb = new StringBuffer();
        char ac[] = str.toCharArray();
        int nLen = ac.length;
        for (int jj=0; jj<nLen; jj++)
            if (ac[jj] == '&') {
                sb.append("&amp;");
            } else if (ac[jj] == '<') {
                sb.append("&lt;");
            } else if (ac[jj] == '>') {
                sb.append("&gt;");
            } else if (ac[jj] == '"') {
                sb.append("&quot;");
            } else if (ac[jj] == '\'') {
                sb.append("&#039;");
            } else {
                sb.append(ac[jj]);
            }

        return sb.toString();
    }

    /**
     * 
     * @param str
     * @return
     */
    public static String unEscape(String str) {
        if (str == null) return str;
        
        str = str.replaceAll("&amp;", "&");
        str = str.replaceAll("&lt;", "<");
        str = str.replaceAll("&gt;", ">");
        str = str.replaceAll("&quot;", "\"");
        str = str.replaceAll("&#039;", "'");
        str = str.replaceAll("&apos;", "'");
        
        return str;
        
    }

    /**
     * 
     * @param req
     * @return
     */
    public static boolean isMultipart(HttpServletRequest req) {
        
        String s1 = "multipart/form-data";
        String str = req.getContentType();
        
        return str != null && str.length() > 19 && s1.equals(str.substring(0, 19));
        
    }
    
    
    /**
     * 
     * @param res
     */
    public static void setNoCache(HttpServletResponse res) {
        res.setHeader("Cache-Control", "no-cache");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0L);
    }
    
    /**
     *
     * @param res
     */
    public static void setNoCacheP3P(HttpServletResponse res) {
        res.setHeader("Cache-Control", "no-cache");
        res.setHeader("Pragma", "no-cache");
        res.setHeader("P3P", "CP='CAO PSA CONi OTR OUR DEM ONL'");
        res.setDateHeader("Expires", 0L);
        
    }
    
    /**
     * 
     * http 요청 URI중 확장자 포함한 요청URI만 잘라내어 반환한다.
     * 
     * @param req
     * @return
     */
    public static String getCommand(HttpServletRequest req) {
        String cmd = req.getRequestURI();
        if (cmd.indexOf(req.getContextPath())==0) {
            cmd = cmd.substring(req.getContextPath().length()); 
        }
        return cmd;
    }
    
    //--- 2014.10.06 y.j.heon
    /**
     * 
     * http 요청 URI중 확장자 포함한 요청URI만 잘라내어 반환한다.
     * 
     * @param req
     * @return
     */
    public static String getCommand(HttpServletRequest req, String  httpUrl) {   // httpUrl 예 = http://napto.na.go.kr:8080/common/sample/RequestInfo.jsp
        String requri  = req.getRequestURI().trim();
        String reqUrl  = req.getRequestURL().toString().trim();
        int    httpIdx = reqUrl.indexOf(requri);
        String httpStr = reqUrl.substring(0, httpIdx);
        
        String cmd = httpUrl.trim();
        
        int uriIdx = cmd.indexOf(httpStr);
        if (uriIdx == 0){
        	cmd = cmd.substring(httpStr.length());
        }
        if (cmd.indexOf(req.getContextPath())==0) {
            cmd = cmd.substring(req.getContextPath().length()); 
        }
        return cmd;
    }

}
