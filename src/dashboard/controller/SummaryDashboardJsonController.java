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

/**
 * 
 * @author grechan
 *
 */
@Controller
public class SummaryDashboardJsonController {

    private static final Logger logger = LoggerFactory.getLogger(SummaryDashboardJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/summaryDashboardJson")
    public ModelAndView ProjectListByJson(@RequestParam Map<String,String> parameter,Locale locale, Model model) {

    	ModelAndView mav = new ModelAndView();
    	List<?> data = service.selectSummaryDashboard(parameter);
        mav.addObject("data", data);
        mav.setViewName("jsonView");

        return mav;
    }
}
