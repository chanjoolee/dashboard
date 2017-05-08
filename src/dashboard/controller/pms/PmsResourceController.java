package dashboard.controller.pms;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

@Controller
public class PmsResourceController {

    private static final Logger logger = LoggerFactory.getLogger(PmsResourceController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;
    
    @Autowired
    private PmsService pmsService;

    @RequestMapping(value = "/pmsResource", method = { RequestMethod.GET, RequestMethod.POST })
    public String pmsResource(@SuppressWarnings("rawtypes") @RequestParam Map parameter,Locale locale, Model model, HttpServletRequest req) {
       return "pmsResource";
    }
    
    
    @RequestMapping(value = "/pmsResourceJson")
    public ModelAndView pmsResourceJson(HttpServletRequest request,@RequestParam Map<Object,Object> parameter,Locale locale, Model model) throws IOException {

    	ModelAndView mav = new ModelAndView();
    	List<?> data = pmsService.pmsResource(parameter);
    	List<?> searchs = pmsService.selectRscSearch(parameter);
    	mav.addObject("data", data);
    	mav.addObject("searchs", searchs);
    	mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/pmsResourceSubfuncJson")
    public ModelAndView pmsResourceSubfuncJson(HttpServletRequest request,@RequestParam Map<Object,Object> parameter,Locale locale, Model model) throws IOException {

    	ModelAndView mav = new ModelAndView();
    	List<?> data = pmsService.pmsResourceSubfunc(parameter);
    	mav.addObject("data", data);
    	mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/pmsResourceProject", method = { RequestMethod.GET, RequestMethod.POST })
    public String pmsResourceProject(@SuppressWarnings("rawtypes") @RequestParam Map parameter,Locale locale, Model model, HttpServletRequest req) {

       return "pmsResourceProject";
    }
    
    @RequestMapping(value = "/pmsResourceProjectJson")
    public ModelAndView pmsResourceProjectJson(HttpServletRequest request,@RequestParam Map<Object,Object> parameter,Locale locale, Model model) throws IOException {

    	ModelAndView mav = new ModelAndView();
    	List<?> data = pmsService.pmsResourceProject(parameter);
    	List<?> plan = pmsService.pmsResourcePlan(parameter);
    	List<?> modelList = pmsService.pmsResourceModel(parameter);
    	List<?> dataPhase = pmsService.getPhaseList(parameter);
    	
    	mav.addObject("data", data);
    	mav.addObject("plan", plan);
    	mav.addObject("model", modelList);
    	mav.addObject("dataPhase", dataPhase);
    	mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/pmsResourceSiteAllJson")
    public ModelAndView pmsResourceSiteAllJson(HttpServletRequest request,@RequestParam Map<Object,Object> parameter,Locale locale, Model model) throws IOException {

    	ModelAndView mav = new ModelAndView();
    	List<?> data = pmsService.pmsResourceSiteAll(parameter);
    	List<?> searchs = pmsService.selectRscSearch(parameter);
    	mav.addObject("data", data);
    	mav.addObject("searchs", searchs);
    	mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/pmsResourceFcst", method = { RequestMethod.GET, RequestMethod.POST })
    public String pmsResourceFcst(@SuppressWarnings("rawtypes") @RequestParam Map parameter,Locale locale, Model model, HttpServletRequest req) {
       return "pmsResourceFcst";
    }
    
    @RequestMapping(value = "/pmsResourceFcstJson")
    public ModelAndView pmsResourceFcstJson(HttpServletRequest request,@RequestParam Map<Object,Object> parameter,Locale locale, Model model) throws IOException, ParseException {

    	ModelAndView mav = new ModelAndView();
    	commonService.requestToVo(request, parameter);
    	
    	//endDate.01. 
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    	String enddateInString = parameter.get("estEndDate").toString();
    	Date enddateIn = formatter.parse(enddateInString);
    	
    	//endDate.02. 
        Calendar cal = Calendar.getInstance();
        cal.setTime(enddateIn);
        cal.add(Calendar.MONTH, -1);
        String endDate = formatter.format(cal.getTime());
    	
    	//plan.01. plan next month
    	String dateInString = parameter.get("estEndDate").toString();
    	Date date = formatter.parse(dateInString);
    	
    	parameter.put("estEndDate", endDate);
    	List<?> data = pmsService.pmsResource(parameter);
    	//List<?> searchs = pmsService.selectRscSearch(parameter);
    	
    	//plan.02. 날짜 더하기 
        cal.setTime(date);
        //cal.add(Calendar.MONTH, 1);
        cal.add(Calendar.MONTH, 0);
        String planDate = formatter.format(cal.getTime());
        
        
        
        parameter.put("estStartDate", planDate);
        parameter.put("estEndDate", planDate);
        List<?> plan = pmsService.pmsResourcePlanFcst(parameter);
        //plan.end
    	
        
    	
    	mav.addObject("data", data);
    	mav.addObject("plan", plan);
    	//mav.addObject("searchs", searchs);
    	mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/pmsResourceFcstPlanJson")
    public ModelAndView pmsResourceFcstPlanJson(HttpServletRequest request,@RequestParam Map<Object,Object> parameter,Locale locale, Model model) throws IOException {

    	ModelAndView mav = new ModelAndView();
    	List<?> plan = pmsService.pmsResourcePlanFcst(parameter);
    	mav.addObject("plan", plan);
    	mav.setViewName("jsonView");

        return mav;
    }
    
    @RequestMapping(value = "/pmsResourceFcstProject", method = { RequestMethod.GET, RequestMethod.POST })
    public String pmsResourceFcstProject(@SuppressWarnings("rawtypes") @RequestParam Map parameter,Locale locale, Model model, HttpServletRequest req) {
       return "pmsResourceFcstProject";
    }
    
    @RequestMapping(value = "/pmsResourceFcstProjectJson")
    public ModelAndView pmsResourceFcstProjectJson(HttpServletRequest request,@RequestParam Map<Object,Object> parameter,Locale locale, Model model) throws IOException, ParseException {

    	ModelAndView mav = new ModelAndView();
    	commonService.requestToVo(request, parameter);
    	List<?> data = pmsService.pmsResource(parameter);
    	
    	mav.addObject("data", data);
    	mav.setViewName("jsonView");

        return mav;
    }
    
    
    
    
}
