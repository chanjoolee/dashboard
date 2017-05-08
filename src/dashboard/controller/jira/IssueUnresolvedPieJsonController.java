package dashboard.controller.jira;

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
public class IssueUnresolvedPieJsonController {

    private static final Logger logger = LoggerFactory.getLogger(IssueUnresolvedPieJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService complexService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/issueUnresolvedPieJson")
    public ModelAndView issueUnresolvedPieJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	logger.info("{}","issueUnresolvedPieJson");
    	ModelAndView mav = new ModelAndView(); 
    	
    	//검색조건추가 2015-09-25
    	Map<?,?> savedSearch = complexService.getSavedSearchCondiion(searchVO);
    	JSONObject searchCondition = null;
    	if(savedSearch !=null && savedSearch.get("SEARCH") != null)
    		searchCondition = (JSONObject) JSONSerializer.toJSON( savedSearch.get("SEARCH") );
    	
    	//List<?> data = service.selectIssueUnresolvedPie(searchVO);
    	searchCondition.put("PRIORITY",searchVO.get("PRIORITY"));
    	List<?> data = service.selectIssueUnresolvedPie(searchCondition);
    	
        mav.addObject("data", data);
      
        mav.setViewName("jsonView");
        

        return mav;
    }
}
