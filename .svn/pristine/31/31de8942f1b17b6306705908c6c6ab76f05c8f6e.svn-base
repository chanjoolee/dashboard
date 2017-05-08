package dashboard.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

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

@Controller
public class ProjectListByJsonController {

    private static final Logger logger = LoggerFactory.getLogger(ProjectListByJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/projectListByJson")
    public ModelAndView ProjectListByJson(@RequestParam Map<String,Object> parameter,Locale locale, Model model) {
    	logger.info("projectList");
    	ModelAndView mav = new ModelAndView();
    	List<?> projectList = service.selectProjectList(parameter); 
    	List<?> projectNameList = service.dashboardProjectList(parameter);
    	
        mav.addObject("projectList", projectList);
        mav.addObject("projectNameList", projectNameList);
        mav.setViewName("jsonView");

        return mav;
    }
}
