package dashboard.controller.jira;

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
public class JiraPkeyLinkJsonController {

    private static final Logger logger = LoggerFactory.getLogger(JiraPkeyLinkJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/jiraPkeyLinkJson")
    public ModelAndView jiraPkeyLinkJson(HttpServletRequest request,@RequestParam Map<String,Object> parameter,Locale locale, Model model) {

    	ModelAndView mav = new ModelAndView();
    	parameter.put("subProjects",request.getParameterValues("subProjects[]"));
    	
    	List<?> data = service.jiraPkeyLink(parameter);
        mav.addObject("data", data);
        mav.setViewName("jsonView");

        return mav;
    }
}
