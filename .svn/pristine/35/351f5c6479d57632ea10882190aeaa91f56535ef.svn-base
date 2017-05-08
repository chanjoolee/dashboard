package dashboard.controller.codesonar;

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
public class projectMultiByPCntJsonController {

    private static final Logger logger = LoggerFactory.getLogger(projectMultiByPCntJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/projectMultiByPCntJson")
    public ModelAndView ProjectListByJson(HttpServletRequest request,@RequestParam Map<String,Object> parameter,Locale locale, Model model) {

    	ModelAndView mav = new ModelAndView();
    	parameter.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	parameter.put("pjtStatus",request.getParameterValues("pjtStatus"));
    	
    	//List<?> dataProject = service.selectProjectList(parameter);
    	List<?> dataProject = service.dashboardProjectList(parameter);
    	List<?> dataRaw = service.selectProjectMultiRaw(parameter);
    	List<?> dataCount = service.selectProjectMultiCount(parameter);
    	List<?> dataPhase = service.selectProjectMultiPhase(parameter);
    	
    	mav.addObject("dataProject", dataProject);
    	mav.addObject("dataPhase", dataPhase);
        mav.addObject("dataRaw", dataRaw);
        mav.addObject("dataCount", dataCount);
        mav.setViewName("jsonView");

        return mav;
    }
}
