package jointjs.controller;

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
import dashboard.batch.service.BatchCommonService;
import dashboard.batch.service.BatchFileFvtService;
import dashboard.batch.service.ScheduleUpdateService;
import dashboard.bean.SearchVO;
import dashboard.regression.service.RegressionTestService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class JointjsController {

    private static final Logger logger = LoggerFactory.getLogger(JointjsController.class);
    
    @Autowired
    private ScheduleUpdateService schedulService;
    
    @Autowired
    private BatchFileFvtService fvtService;
    
    @Autowired
    private BatchCommonService batchCommonService;
    
    @RequestMapping(value = "/jointjs",method = { RequestMethod.GET, RequestMethod.POST })
    public String jointjs(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "jointjs";
    }
    
    @RequestMapping(value = "/googleSearch",method = { RequestMethod.GET, RequestMethod.POST })
    public String googleSearch(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "googleSearch";
    }
    
    @RequestMapping(value = "/backboneEx",method = { RequestMethod.GET, RequestMethod.POST })
    public String backboneEx(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "backboneEx";
    }
    
    @RequestMapping(value = "/diagramGeneral",method = { RequestMethod.GET, RequestMethod.POST })
    public String diagramGeneral(@SuppressWarnings("rawtypes") @RequestParam Map parameter,Locale locale, Model model) {
        return parameter.get("viewname").toString();
    }
    
    @RequestMapping(value = "/diagram01_blog",method = { RequestMethod.GET, RequestMethod.POST })
    public String diagram01_blog(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "diagram01_blog";
    }
    
    @RequestMapping(value = "/diagram01_1_blogMy",method = { RequestMethod.GET, RequestMethod.POST })
    public String diagram01_1_blogMy(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "diagram01_1_blogMy";
    }
    
    @RequestMapping(value = "/diagram02_webpage",method = { RequestMethod.GET, RequestMethod.POST })
    public String diagram02_webpage(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "diagram02_webpage";
    }
    
    @RequestMapping(value = "/diagram02_1_webpageMy",method = { RequestMethod.GET, RequestMethod.POST })
    public String diagram02_1_webpageMy(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "diagram02_1_webpageMy";
    }
    
    @RequestMapping(value = "/diagram02_2_dragAndDrop",method = { RequestMethod.GET, RequestMethod.POST })
    public String diagram02_2_dragAndDrop(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "diagram02_2_dragAndDrop";
    }
    
    @RequestMapping(value = "/diagram02_3_joint",method = { RequestMethod.GET, RequestMethod.POST })
    public String diagram02_3_joint(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "diagram02_3_joint";
    }
    
    @RequestMapping(value = "/diagram02_4_joint",method = { RequestMethod.GET, RequestMethod.POST })
    public String diagram02_4_joint(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {
        return "diagram02_4_joint";
    }
    
    
}
