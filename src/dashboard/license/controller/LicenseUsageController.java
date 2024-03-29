package dashboard.license.controller;

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
import dashboard.license.service.LicenseUsageService;
import dashboard.service.ComplexService;

@Controller
public class LicenseUsageController {

    private static final Logger logger = LoggerFactory.getLogger(LicenseUsageController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private dashboard.license.service.LicenseUsageService service;
    
    
    @RequestMapping(value = "/licenseUsage",method = { RequestMethod.GET, RequestMethod.POST })
    public String licenseUsage(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "licenseUsage";
    }
    
    @RequestMapping(value = "/licenseUsageJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView licenseUsageJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {

    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	
    	
    	List<?> dataList  = service.licenseUsage(searchVO);
    	List<?> monthList = service.licenseUseMonthTable(searchVO);
        mav.addObject("dataList", dataList);
        mav.addObject("monthList", monthList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/licenseUsagePop",method = { RequestMethod.GET, RequestMethod.POST })
    public String licenseUsagePop(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "licenseUsagePop";
    }
    
    @RequestMapping(value = "/licenseUsagePopJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView licenseUsagePopJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {

    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.licenseUsagePop(searchVO);
    	List<?> dateList = service.licenseUseDateList(searchVO);
    	List<?> dateTable = service.licenseUseDateTable(searchVO);
        mav.addObject("dataList", dataList);
        
        System.out.println("dateList"+dateList.size());
        mav.addObject("dateList", dateList);
        mav.addObject("dateTable", dateTable);
       
        mav.setViewName("jsonView");        

        return mav;
    }

}
