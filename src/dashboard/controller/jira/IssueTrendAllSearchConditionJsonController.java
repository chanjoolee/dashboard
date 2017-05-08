package dashboard.controller.jira;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

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
public class IssueTrendAllSearchConditionJsonController {

    private static final Logger logger = LoggerFactory.getLogger(IssueTrendAllSearchConditionJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/issueTrendAllSearchConditionJson")
    public ModelAndView issueTrendAllSearchConditionJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {

    	
    	ModelAndView mav = new ModelAndView(); 
    	List<?> priority = service.selectDefectsTrendsPriority(searchVO);
    	List<?>	issuetype = service.selectDefectsTrendsIssueType(searchVO);    	
    	
        mav.addObject("priority", priority);
        mav.addObject("issuetype", issuetype);
        
        mav.setViewName("jsonView");        

        return mav;
    }
}
