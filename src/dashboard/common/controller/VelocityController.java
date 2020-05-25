package dashboard.common.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;
import dashboard.service.ComplexService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

/**
 * 
 * @author grechan
 *
 */
@Controller
@RequestMapping("/vm")
public class VelocityController {

    private static final Logger logger = LoggerFactory.getLogger(VelocityController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

   
    
    
    @RequestMapping(value = "/template",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView  template(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> searchVO,Locale locale, Model model, HttpServletResponse response,HttpServletRequest request, ModelAndView mav) throws IOException {
    	commonService.requestToVo(request, searchVO);
    	mav.addObject("searchVO",searchVO);
        mav.setViewName(searchVO.get("viewName").toString());
        return mav;
        
    }
    
    
    
    
    
    
}
