package dashboard.controller.jira;

import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import common.service.CommonService;
import dashboard.service.ComplexService;

@Controller
public class IssueUnresolvedController {

    private static final Logger logger = LoggerFactory.getLogger(IssueUnresolvedController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/issueUnresolved")
    public String issueUnresolved(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        //model.addAttribute("series", service.selectSeries(parameter) );

        return "issueUnresolved";
    }
}
