package dashboard.controller.codesonar;

import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import common.service.CommonService;
import dashboard.service.ComplexService;

@Controller
public class CodesonarProjectDetailController {

    private static final Logger logger = LoggerFactory.getLogger(CodesonarProjectDetailController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/codesonarProjectDetail")
    public String codesonarProjectDetail(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        //model.addAttribute("series", service.selectSeries(parameter) );
    	
    	HttpHeaders headers = new HttpHeaders();
    	headers.add("Access-Control-Allow-Origin", "*");
    	headers.add("Access-Control-Allow-Methods", "GET, OPTIONS, POST");
    	headers.add("Access-Control-Allow-Headers", "Content-Type");
    	model.addAttribute(headers);
        return "codesonarProjectDetail";
    }
}
