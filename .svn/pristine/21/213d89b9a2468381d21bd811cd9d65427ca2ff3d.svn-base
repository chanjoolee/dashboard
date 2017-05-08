package dashboard.controller.codesonar;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

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
public class CodesonarProjectDetailProjectListJsonController {

    private static final Logger logger = LoggerFactory.getLogger(CodesonarProjectDetailProjectListJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/codesonarProjectDetailProjectListJson")
    public ModelAndView CodesonarProjectDetailProjectListJson(@RequestParam Map<String,String> parameter,Locale locale, Model model) throws IOException {

    	ModelAndView mav = new ModelAndView();
    	
    	String response = "";
    	String response1 = "";
    	
    	//** 01. server1 **//
    	//String httpsURL = "http://codesonar1.skhynix.com:7340/index.csv";
    	String httpsURL = "http://166.125.19.70:7340/index.csv";
        URL myurl = new URL(httpsURL);
        //sun.net.www.protocol.http.HttpURLConnection  java.net.URLConnection
        //HttpsURLConnection con = (HttpsURLConnection)myurl.openConnection();
        //sun.net.www.protocol.http.HttpURLConnection con = (sun.net.www.protocol.http.HttpURLConnection)myurl.openConnection();
        java.net.HttpURLConnection con = (HttpURLConnection) myurl.openConnection();
        InputStream ins = con.getInputStream();
        InputStreamReader isr = new InputStreamReader(ins);
        BufferedReader in = new BufferedReader(isr);
     
        String inputLine;
     
        while ((inputLine = in.readLine()) != null)
        {
        	logger.debug(inputLine);
        	response += inputLine + "\r\n";
        }
     
        in.close();
        
        mav.addObject("server1", "http://166.125.19.70:7340");
        mav.addObject("projectList1", response);
        
        //** 02. server2 **//
        //httpsURL = "http://codesonar2.skhynix.com:7340/index.csv";
    	httpsURL = "http://166.125.19.71:7340/index.csv";
        myurl = new URL(httpsURL);
        //sun.net.www.protocol.http.HttpURLConnection  java.net.URLConnection
        //HttpsURLConnection con = (HttpsURLConnection)myurl.openConnection();
        con =  (HttpURLConnection)myurl.openConnection();
        ins = con.getInputStream();
        isr = new InputStreamReader(ins);
        in = new BufferedReader(isr);
     
        while ((inputLine = in.readLine()) != null)
        {
        	logger.debug(inputLine);
        	response1 += inputLine + "\r\n";
        }
     
        in.close();
        
        mav.addObject("server2", "http://166.125.19.71:7340");
        mav.addObject("projectList2", response1);
        
        //** 03. ProjectList **//
        List<?> projectList = service.selectProjectList(parameter); 
        mav.addObject("projectList", projectList);
        
        
        //** 04. ProjectMap **//
        List<?> projectMap = service.selectProjectMappingList(parameter); 
        mav.addObject("projectMap", projectMap);
        
        mav.setViewName("jsonView");

        return mav;
    }
}
