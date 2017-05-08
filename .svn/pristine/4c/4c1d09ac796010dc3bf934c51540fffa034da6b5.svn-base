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
public class DashboardProjectListJsonController {

    private static final Logger logger = LoggerFactory.getLogger(DashboardProjectListJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/dashboardProjectListJson")
    public ModelAndView dashboardProjectListJson(HttpServletRequest request,@RequestParam Map<String,Object> searchVO ,Locale locale, Model model) {
    	logger.info("dashboardProjectListJson");
    	ModelAndView mav = new ModelAndView();
    	
    	List<?> projectList = service.dashboardProjectList(searchVO);
    	model.addAttribute("projectList", projectList );
    	
    	mav.setViewName("jsonView");

        return mav;
    }
}
