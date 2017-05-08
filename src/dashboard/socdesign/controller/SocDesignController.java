package dashboard.socdesign.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;
import dashboard.bean.SearchVO;
import dashboard.bean.paramListVO;
import dashboard.bean.paramVO;
import dashboard.regression.service.RegressionTestService;
import dashboard.service.ComplexService;
import dashboard.socdesign.service.SocDesignService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class SocDesignController {

    private static final Logger logger = LoggerFactory.getLogger(SocDesignController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private SocDesignService service;
    
    
    @RequestMapping(value = "/socDesignCsv")
    public String socDesignCsv(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "socDesignCsv";
    }

    @RequestMapping(value = "/pmsSocDesignCsvUrlListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView pmsSocDesignCsvUrlListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.getCsvUrlList(searchVO);
//    	List<?> dataList = service.getCsvUrlListTest(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/pmsSocDesignCsvDataJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView pmsSocDesignCsvDataJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView();
    	
    	String response = "";
    	
    	
    	String newId = service.getNewBatchId();
    	searchVO.put("batchCategory","socDesignCheck");
    	searchVO.put("batchId",newId);
    	service.insertNewBatchId(searchVO);
    	try{
    		
    		List<?> dataList = service.getCsvUrlList(searchVO);
    		
            searchVO.put("urlList",dataList);
    		service.parseXlsx(searchVO);
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		service.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		service.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
        
        
        mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/socDesignChart")
    public String socDesignChart(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "socDesignChart";
    }
    
    @RequestMapping(value = "/getSummaryForChartJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView getSummaryForChartJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.getSummaryForChart(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/socDesignChartPop")
    public String socDesignChartPop(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "socDesignChartPop";
    }
    
    @RequestMapping(value = "/socDesignChartPopJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView socDesignChartPopJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.socDesignChartPopJson(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/socDesinTestCaseChart")
    public String socDesinTestCaseChart(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "socDesinTestCaseChart";
    }
    
    @RequestMapping(value = "/socDesinTestCaseChartJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView socDesinTestCaseChartJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	List<?> dataList = service.testCaseByProject(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/socDesignGeneral")
    public String socDesignGeneral(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "socDesignGeneral";
    }
    
    @RequestMapping(value = "/socDesignGeneralJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView socDesignGeneralJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	List<?> dataList = service.socDesignGeneralList(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/socDesignProject")
    public String socDesignProject(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "socDesignProject";
    }
    
    @RequestMapping(value = "/socDesignProjectJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView socDesignProjectJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	List<?> historyList = service.socDesignProjectlHistory(searchVO);
    	List<?> detailList = service.socDesignProjectlDetail(searchVO);
        mav.addObject("historyList", historyList);
        mav.addObject("detailList", detailList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    
    
    
}
