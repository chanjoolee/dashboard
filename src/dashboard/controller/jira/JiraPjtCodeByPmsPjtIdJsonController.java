package dashboard.controller.jira;

import java.util.HashMap;
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
import dashboard.service.PmsService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class JiraPjtCodeByPmsPjtIdJsonController {

    private static final Logger logger = LoggerFactory.getLogger(JiraPjtCodeByPmsPjtIdJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;
    
    @Autowired
    private PmsService pmsservice;

    @SuppressWarnings({ "unused", "rawtypes" })
	@RequestMapping(value = "/jiraPjtCodeByPmsPjtIdJson")
    public ModelAndView jiraPjtCodeByPmsPjtIdJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {

    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	Map pmsInterface = pmsservice.getPjtInterfaceJiraFromPmsPjtId(searchVO);
    	Map pjtInfo = null;
    	if(pmsInterface !=null)
    		pjtInfo = service.getJiraPjtCodeByPmsInterface(pmsInterface);
    	
        mav.addObject("pmsInterface", pmsInterface);
        mav.addObject("pjtInfo", pjtInfo);
        mav.addObject("searchVO", searchVO);
        
        mav.setViewName("jsonView");

        return mav;
    }
}
