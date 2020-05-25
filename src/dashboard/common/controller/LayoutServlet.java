package dashboard.common.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
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
import org.apache.velocity.context.Context;
import org.apache.velocity.tools.view.VelocityLayoutServlet;


public class LayoutServlet extends VelocityLayoutServlet {

    private static final Logger logger = LoggerFactory.getLogger(LayoutServlet.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;
    
    @Override
    public Template handleRequest( HttpServletRequest request, HttpServletResponse response, Context context) {

    	Map<Object, Object> searchVO = new HashMap<Object,Object>();
    	commonService.requestToVo(request, searchVO);    	
    	context.put("searchVO", searchVO);

        Template template = null;

        try {
            Template t = getTemplate(searchVO.get("viewName").toString());
            response.setHeader("Template Returned", "Success");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return template;
    }
    
    
    
    
    
    
}
