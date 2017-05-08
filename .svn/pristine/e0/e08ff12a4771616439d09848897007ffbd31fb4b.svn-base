package dashboard.controller.codesonar;

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
public class projectOneStackByPCntJsonController {

    private static final Logger logger = LoggerFactory.getLogger(projectOneStackByPCntJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/projectOneStackByPCntJson")
    public ModelAndView ProjectListByJson(@RequestParam Map<String,String> parameter,Locale locale, Model model) {

    	ModelAndView mav = new ModelAndView();
    	List<?> data = service.selectProjectPCountData(parameter);
    	List<?> phase = service.selectProjectPhase(parameter);
        mav.addObject("data", data);
        mav.addObject("phase", phase);
        mav.setViewName("jsonView");

        return mav;
    }
}
