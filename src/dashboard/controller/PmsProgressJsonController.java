package dashboard.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class PmsProgressJsonController {

    private static final Logger logger = LoggerFactory.getLogger(PmsProgressJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/pmsProgressJson")
    public ModelAndView pmsProgressJson(HttpServletRequest request,@RequestParam Map<String,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> pmsModel = service.selectPmsModel(searchVO);
    	List<?> pmsProject = service.selectPmsProject(searchVO);
    	
        mav.addObject("pmsModel", pmsModel);      
        mav.addObject("pmsProject", pmsProject); 
        mav.setViewName("jsonView");
        

        return mav;
    }
}
