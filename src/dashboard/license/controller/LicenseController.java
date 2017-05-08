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

import dashboard.license.service.LicenseService;
import dashboard.service.ComplexService;

@Controller
public class LicenseController {

    private static final Logger logger = LoggerFactory.getLogger(LicenseController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService complexService;
    
    @Autowired
    private LicenseService service;
    
    @RequestMapping(value = "/iarLicenseUse",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView iarLicenseUse(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
        mav.addObject("searchVO", searchVO);
       
        mav.setViewName("iarLicenseUse");        

        return mav;
    }

    @RequestMapping(value = "/iarLicenseUseJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView iarLicenseUseJson(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.selectIarLicenseUseList(searchVO);
    	
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
}
