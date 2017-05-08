package dashboard.controller.pms;

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

import common.service.CommonService;
import dashboard.service.ComplexService;

@Controller
public class PmsTatByModelController {

    private static final Logger logger = LoggerFactory.getLogger(PmsTatByModelController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/pmsTatByModel", method = { RequestMethod.GET, RequestMethod.POST })
    public String pmsTatByModel(@SuppressWarnings("rawtypes") @RequestParam Map parameter,Locale locale, Model model, HttpServletRequest req) {

        return "pmsTatByModel";
    }
}
