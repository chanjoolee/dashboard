package dashboard.controller.pms;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.io.IOException;
import java.nio.file.*;
import java.nio.file.attribute.*;

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
import dashboard.service.PmsService;

/**
 * 
 * @author grechan
 * 
 */
@Controller
public class PmsTestJsonController {

    private static final Logger logger = LoggerFactory.getLogger(PmsTestJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;
    
    @Autowired
    private PmsService pmsService;

    /**
     * 
     * @param request
     * @param parameter
     * @param locale
     * @param model
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/pmsTestJson")
    public ModelAndView codeComplexStatusJson(HttpServletRequest request,@RequestParam Map<String,Object> parameter,Locale locale, Model model) throws IOException {

    	ModelAndView mav = new ModelAndView();
    	List<?> data = pmsService.pmstest(parameter);
    	mav.addObject("data", data);
    	mav.setViewName("jsonView");

        return mav;
    }
}
