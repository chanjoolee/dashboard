package dashboard.jira.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;
import dashboard.bean.SearchVO;
import dashboard.jira.service.JiraService;
import dashboard.regression.service.RegressionTestService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class JiraController {

    private static final Logger logger = LoggerFactory.getLogger(JiraController.class);

    @Autowired
    private JiraService service;
    
    @Autowired
    private CommonService commonService;
    
    @RequestMapping(value = "/jiraIssueFromResolution",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraIssueFromResolution(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("jiraIssueFromResolution");
        return mav;
    }
    
    
    @RequestMapping(value = "/jiraIssueFromResolutionJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraIssueFromResolutionJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	//List<?> dataList = service.selectRawList(searchVO);
    	List<?> dataListGroup = service.selectIssueFromResolution(searchVO);
        //mav.addObject("dataList", dataList);
        mav.addObject("dataListGroup", dataListGroup);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/jiraDiscoveredResolution",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraDiscoveredResolution(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	
    	mav.setViewName("jiraDiscoveredResolution");
        return mav;
    }
    
    
    @RequestMapping(value = "/jiraDiscoveredResolutionJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraDiscoveredResolutionJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	//List<?> dataList = service.selectRawList(searchVO);
    	List<?> dataListGroup = service.selectDiscoveredResolution(searchVO);
        //mav.addObject("dataList", dataList);
        mav.addObject("dataListGroup", dataListGroup);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    /**
     * 추정원인 대비 확정원인
     * @param parameter
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/jiraPresumedCause",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraPresumedCause(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("jiraPresumedCause");
        return mav;
    }
    
    /**
     * 추정원인 대비 확정원인
     * 데이타로드
     * @param request
     * @param searchVO
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/jiraPresumedCauseJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraPresumedCauseJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	//List<?> dataList = service.selectRawList(searchVO);
    	List<?> dataListGroup = service.selectRootCauseGroup(searchVO);
        //mav.addObject("dataList", dataList);
        mav.addObject("dataListGroup", dataListGroup);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/jiraProjectListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraProjectListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.selectJiraProjectList(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
   
    /**
     * 추정원인 대비 확정원인
     * @param parameter
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/jiraAnalysisByDateIssueType",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraAnalysisByDateIssueType(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	mav.setViewName("jiraAnalysisByDateIssueType");
        return mav;
    }
    
    /**
     * 추정원인 대비 확정원인
     * 데이타로드
     * @param request
     * @param searchVO
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/jiraAnalysisByDateIssueTypeJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraAnalysisByDateIssueTypeJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	searchVO.put("priority",request.getParameterValues("priority"));
    	searchVO.put("issuetype",request.getParameterValues("issuetype"));    
    	searchVO.put("subProjects",request.getParameterValues("subProjects"));
    	
    	List<?> dataList = service.jiraAnalysisByDateIssueType(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/jiraConfUsage",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraUsage(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("jiraConfUsage");
        return mav;
    }
    
    /**
     * 
     * @param request
     * @param searchVO
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/jiraUsageJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jiraUsageJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	commonService.requestToVo(request, searchVO);
    	Object filterStr = searchVO.get("filters");
    	if(filterStr != null){
    		JSONObject filters = JSONObject.fromObject(filterStr.toString());
        	searchVO.put("filtersOrigin", filterStr.toString());
        	searchVO.put("filters", filters);
    	}
    	
    	List<?> dataList = service.usageList(searchVO);
    	mav.addObject("rows", dataList);
    	
    	Map<String,Object> paging = service.usageListPage(searchVO);
    	mav.addObject("total", paging.get("TOTAL"));
    	mav.addObject("page", paging.get("PAGE"));
    	mav.addObject("records", paging.get("RECORDS"));
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/confluenceUsageJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView confluenceUsageJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	commonService.requestToVo(request, searchVO);
    	Object filterStr = searchVO.get("filters");
    	if(filterStr != null){
    		JSONObject filters = JSONObject.fromObject(filterStr.toString());
        	searchVO.put("filtersOrigin", filterStr.toString());
        	searchVO.put("filters", filters);
    	}
    	
    	List<?> dataList = service.confUsageList(searchVO);
    	mav.addObject("rows", dataList);
    	
    	Map<String,Object> paging = service.confUsageListPage(searchVO);
    	mav.addObject("total", paging.get("TOTAL"));
    	mav.addObject("page", paging.get("PAGE"));
    	mav.addObject("records", paging.get("RECORDS"));
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
}
