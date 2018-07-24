package dashboard.systemUsage.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dashboard.systemUsage.service.SystemUsageService;

@Controller
public class SystemUsageController {

//    private static final Logger logger = LoggerFactory.getLogger(SystemUsageController.class);

    @Autowired
    private SystemUsageService service;
    
    @RequestMapping(value = "/systemUsageSummary",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView systemUsageSummary(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
        mav.addObject("searchVO", searchVO);
       
        mav.setViewName("systemUsageSummary");        

        return mav;
    }

    @RequestMapping(value = "/systemUsageSummaryJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView systemUsageSummaryJson(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<Map<String, Object>> dataList = service.selectSystemUsageSummaryList(searchVO);
    	
    	List<Map<String, Object>> resutlList = new ArrayList<Map<String, Object>>();
    	for(Map<String, Object> dataMap : dataList){
    		resutlList.add(dataMap);
    	}
    	Map<String, Object> map = null;
    	for(Map<String, Object> dataMap : dataList){
    		map = new LinkedHashMap<String, Object>();
    		map.putAll(dataMap);
    		map.put("SERIES_TYPE", "02");
    		map.put("COUNT_VAL", map.get("USE_COUNT_VAL"));
    		resutlList.add(map);
    	}
    	
        mav.addObject("dataList", resutlList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/systemUsage",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView systemUsage(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
        mav.addObject("searchVO", searchVO);
       
        mav.setViewName("systemUsage");        

        return mav;
    }

    @RequestMapping(value = "/systemUsageJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView systemUsageJson(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<Map<String, Object>> dataList = service.selectSystemUsageList(searchVO);
    	
    	List<Map<String, Object>> resutlList = new ArrayList<Map<String, Object>>();
    	for(Map<String, Object> dataMap : dataList){
    		resutlList.add(dataMap);
    	}
    	Map<String, Object> map = null;
    	for(Map<String, Object> dataMap : dataList){
    		map = new LinkedHashMap<String, Object>();
    		map.putAll(dataMap);
    		map.put("SERIES_TYPE", "02");
    		map.put("COUNT_VAL", map.get("USE_COUNT_VAL"));
    		resutlList.add(map);
    	}
    	
        mav.addObject("dataList", resutlList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
}
