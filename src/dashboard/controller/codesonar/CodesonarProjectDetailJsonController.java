package dashboard.controller.codesonar;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class CodesonarProjectDetailJsonController {

    private static final Logger logger = LoggerFactory.getLogger(CodesonarProjectDetailJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/codesonarProjectDetailJson")
    public ModelAndView ProjectListByJson(HttpServletRequest request,@RequestParam Map<String,String> parameter,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView();
    	
    	String response = "";
    	
    	// start session check
    	HttpSession session = request.getSession();
    	String pjtcode = parameter.get("PJT_CODE");
    	String sessionAttrId = "codesonarProjectDetailJson"+pjtcode;
    	String sessionRefresh = parameter.get("sessionRefresh"); 
    	Boolean isSessionRefresh = true;
    	if(sessionRefresh == null)
    		isSessionRefresh = false;
    	else if(sessionRefresh.equals("true"))
    		isSessionRefresh = true;
    	else
    		isSessionRefresh = false;
    	// end session check
    	
    	// decide if use session infomation 
    	if(!isSessionRefresh &&  session.getAttribute(sessionAttrId) != null){
    		mav.addObject("data", session.getAttribute(sessionAttrId));
    		mav.setViewName("jsonView");
            return mav;
    	}
    	
    	String[] servers = request.getParameterValues("server[]");
    	String[] urls = request.getParameterValues("url[]");
    	String[] projects = request.getParameterValues("project[]");
    	request.getRequestURI();
    	for(int i=0;i<servers.length;i++){
    		//String httpsURL = "http://codesonar1.skhynix.com:7340"+parameter.get("url");
        	//String httpsURL = "http://166.125.19.70:7340"+parameter.get("url");
        	String httpsURL = servers[i] +urls[i];
            URL myurl = new URL(httpsURL);
            //sun.net.www.protocol.http.HttpURLConnection  java.net.URLConnection
            //HttpsURLConnection con = (HttpsURLConnection)myurl.openConnection();
            //sun.net.www.protocol.http.HttpURLConnection con = (sun.net.www.protocol.http.HttpURLConnection)myurl.openConnection();
            java.net.HttpURLConnection con = (HttpURLConnection) myurl.openConnection();
            InputStream ins = con.getInputStream();
            InputStreamReader isr = new InputStreamReader(ins);
            BufferedReader in = new BufferedReader(isr);
            
            String inputLine;
         
            int j = 0;
            while ((inputLine = in.readLine()) != null)
            {
            	if(i>0 && j==0){
            		j++;
            		continue;
            	}
            		
            	//logger.debug(inputLine);
            	//header column 추가
            	if(i==0 && j==0){ 
            		// 첫번째 행이 면 컬럼추가
            		inputLine += ",project";
            	}else{
            		// 두번째 행이면 프로젝트 추가함. csv에는 project가 없기 때문임. 
            		// htmlexpand시 숫가계산을 할때 필터링을 하기 위함.
            		inputLine += "," + projects[i];
            	}
            	response += inputLine + "\r\n";
            	
            	j++;
            }
         
            in.close();
    	}
    	
        
        mav.addObject("data", response);
        session.setAttribute(sessionAttrId, response);
        
        mav.setViewName("jsonView");

        return mav;
    }
}
