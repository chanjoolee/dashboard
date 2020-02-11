package dashboard.batch.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;
import dashboard.batch.service.BatchCommonService;
import dashboard.batch.service.BatchFileFvtService;
import dashboard.batch.service.BatchFwqService;
import dashboard.batch.service.BatchRmsService;
import dashboard.batch.service.CodesonarMappingUpdateService;
import dashboard.batch.service.JiraMappingUpdateService;
import dashboard.batch.service.MigrationService;
import dashboard.batch.service.PjtnameUpdateService;
import dashboard.batch.service.ScheduleUpdateService;
import dashboard.socdesign.service.SocDesignService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class BatchController {

    private static final Logger logger = LoggerFactory.getLogger(BatchController.class);
    
    @Autowired
    private PjtnameUpdateService pjtnameUpdateService;
    
    @Autowired
    private JiraMappingUpdateService jiraService;
    
    @Autowired
    private CodesonarMappingUpdateService codesonarService;
    
    @Autowired
    private ScheduleUpdateService schedulService;
    
    @Autowired
    private BatchFileFvtService fvtService;
    
    @Autowired
    private BatchCommonService batchCommonService;
    
    @Autowired
    private CommonService commonService;
    
    @Autowired
    private BatchFwqService fwqService;
    
    @Autowired
    private BatchRmsService rmsService;
    
    @Autowired
    private SocDesignService dvService;
    
    @Autowired
    private MigrationService migrationService;
    
    @RequestMapping(value = "/batchMappingSchedulePmsWithDashboard",method = { RequestMethod.GET, RequestMethod.POST })
    public String batchMappingSchedulePmsWithDashboard(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "batchMappingSchedulePmsWithDashboard";
    }

    @RequestMapping(value = "/batchMappingSchedulePmsWithDashboardJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchMappingSchedulePmsWithDashboardJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception  {
    	
    	ModelAndView mav = new ModelAndView(); 
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","mappingSchedulePms");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	try{
    		schedulService.batchMappingSchedulePmsWithDashboard(searchVO);  
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		batchCommonService.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/batchFileFvt",method = { RequestMethod.GET, RequestMethod.POST })
    public String batchFileFvt(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "batchFileFvt";
    }
    
    @RequestMapping(value = "/batchFileFvtUrlListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchFileFvtUrlListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = fvtService.getFileUrlList(searchVO);
//    	List<?> dataList = fvtService.getFileUrlListTest(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/batchFileFvtUpdateJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchFileFvtUpdateJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView();
    	
    	String response = "";
    	
    	
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","FVT");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	try{
    		List<?> dataList = fvtService.getFileUrlList(searchVO);
    		searchVO.put("urlList",dataList);
    		
    		fvtService.parseXlsx(searchVO);
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		batchCommonService.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
        
        
        mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/fvtPassByDt",method = { RequestMethod.GET, RequestMethod.POST })
    public String fvtPassByDt(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "fvtPassByDt";
    }
    
    @RequestMapping(value = "/fvtPassByDtJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView fvtPassByDtJson(HttpServletRequest request,Map<Object,Object> parameter,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView();     	
    	parameter.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	List<?> dataList = fvtService.getFvtPassByDt(parameter);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/fvtPhaseCount",method = { RequestMethod.GET, RequestMethod.POST })
    public String fvtPhaseCount(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "fvtPhaseCount";
    }
    
    @RequestMapping(value = "/fvtPhaseCountJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView fvtPhaseCountJson(HttpServletRequest request,Map<Object,Object> parameter,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView();     	
    	parameter.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	List<?> dataList = fvtService.getFvtPhaseCount(parameter);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    /**
     * pms�쓽 pjt_info.pjt_name怨� dashboard�쓽 pjt_list.pjt_name�쓣 �씪移섏떆�궓�떎.
     * @param request
     * @param searchVO
     * @param locale
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/batchPjtnameMappingJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchPjtnameMappingJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception  {
    	
    	ModelAndView mav = new ModelAndView(); 
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","mappingPjtname");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	try{
    		pjtnameUpdateService.batchJob(searchVO);  
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		batchCommonService.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/batchJiraProjectMappingJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchJiraProjectMappingJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception  {
    	
    	ModelAndView mav = new ModelAndView(); 
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","mappingJiraProject");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	try{
    		jiraService.batchJob(searchVO);  
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		batchCommonService.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/batchCodesonarProjectMappingJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchCodesonarProjectMappingJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception  {
    	
    	ModelAndView mav = new ModelAndView(); 
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","mappingPjtname");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	try{
    		codesonarService.batchJob(searchVO);  
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		batchCommonService.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/batchFwqJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchFwqJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView();
    	
    	String response = "";
    	
    	
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","FWQuality");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	try{
    		//List<?> dataList = fwqService.getFileUrlList(searchVO);
    		//searchVO.put("urlList",dataList);
    		//fwqService.parseXlsx(searchVO);
    		fwqService.updateHistory();
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		batchCommonService.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
        
        
        mav.setViewName("jsonView");

        return mav;
    }
    
	/*
	 * @SuppressWarnings("rawtypes")
	 * 
	 * @RequestMapping(value = "/batchFwqLinkCheckJson",method = {
	 * RequestMethod.GET, RequestMethod.POST }) public ModelAndView
	 * batchFwqLinkCheckJson(HttpServletRequest request,@RequestParam
	 * Map<Object,Object> searchVO,Locale locale, Model model) throws Exception {
	 * 
	 * ModelAndView mav = new ModelAndView();
	 * 
	 * String newId = batchCommonService.getNewBatchId();
	 * searchVO.put("batchCategory","FWQualityUrlCheck");
	 * searchVO.put("batchId",newId); batchCommonService.insertNewBatchId(searchVO);
	 * try{ //List<?> dataList = fwqService.getFileUrlList(searchVO);
	 * //searchVO.put("urlList",dataList); //fwqService.parseXlsx(searchVO); List
	 * projects = commonService.pmsProjectList(searchVO);
	 * searchVO.put("pjtCodeList", projects);
	 * 
	 * @SuppressWarnings("unchecked") List<Map<String,Object>> linkList =
	 * fwqService.getLinkUrlList(searchVO);
	 * 
	 * fwqService.checkUrl(linkList,searchVO);
	 * 
	 * searchVO.put("batchResult","SUCCESS"); searchVO.put("message","");
	 * batchCommonService.updateBatchResult(searchVO);
	 * mav.addObject("result","success"); }catch(Exception ex){
	 * 
	 * searchVO.put("batchResult","FAIL"); searchVO.put("message",ex.getMessage());
	 * batchCommonService.updateBatchResult(searchVO);
	 * 
	 * mav.addObject("result","fail: " + ex.getMessage()); }
	 * 
	 * 
	 * mav.setViewName("jsonView");
	 * 
	 * return mav; }
	 */
    
    
    @RequestMapping(value = "/batchSsdCustomMigrationJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchSsdCustomMigrationJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView();
    	
    	String response = "";
    	
    	
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","SsdMigration");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	try{
    		//List<?> dataList = fwqService.getFileUrlList(searchVO);
    		//searchVO.put("urlList",dataList);
    		//fwqService.parseXlsx(searchVO);
    		migrationService.ssdCustomMigration(null);
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		batchCommonService.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
        
        
        mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/batchRMSJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchRMSJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView(); 
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","RMS");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	
    	try {
    		rmsService.insertRms(request);
    		
    		searchVO.put("batchResult", "SUCCESS");
    		searchVO.put("message", "");
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result", "success");
    		
    	} catch(Exception ex) {
    		
    		searchVO.put("batchResult", "FAIL");
    		searchVO.put("message", ex.getMessage());
    		batchCommonService.updateBatchResult(searchVO);
    		
    		mav.addObject("result", "fail: " + ex.getMessage());
    	}
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/batchSocDesignJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView batchSocDesignJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO,Locale locale, Model model) throws Exception {

    	ModelAndView mav = new ModelAndView();
    	
    	String response = "";
    	
    	
    	String newId = batchCommonService.getNewBatchId();
    	searchVO.put("batchCategory","socDesignCheck1");
    	searchVO.put("batchId",newId);
    	batchCommonService.insertNewBatchId(searchVO);
    	try{
    		
    		List<?> dataList = dvService.getCsvUrlList(searchVO);
    		
            searchVO.put("urlList",dataList);
            dvService.parseXlsxNew(searchVO);
    		searchVO.put("batchResult","SUCCESS");
    		searchVO.put("message","");
    		dvService.updateBatchResult(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		
    		searchVO.put("batchResult","FAIL");
    		searchVO.put("message",ex.getMessage());
    		dvService.updateBatchResult(searchVO);
    		
    		mav.addObject("result","fail: " + ex.getMessage());
    	}
        
        
        mav.setViewName("jsonView");

        return mav;
    }
}
