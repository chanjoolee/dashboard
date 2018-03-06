package bigdata.websearch.controller;

import java.util.concurrent.Callable;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.net.ssl.X509TrustManager;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import bigdata.websearch.service.WebSearchService;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;


import common.service.CommonService;
import dashboard.bean.SearchVO;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class WebSearchController {

    private static final Logger logger = LoggerFactory.getLogger(WebSearchController.class);

    @Autowired
    private WebSearchService searchService;
    
    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    
    @RequestMapping(value = "/webSearchJson" ,method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView webSearchJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
		ModelAndView mav = new ModelAndView();
		commonService.requestToVo(request, searchVO);
		String USER_AGENT = "Mozilla/5.0";
		try {
			searchService.httpUrlConnection(searchVO, mav, USER_AGENT);
			searchVO.put("result", "success");
		} catch (Exception e) {
			//e.printStackTrace();
			searchVO.put("result", "fail");
			searchVO.put("message", e.getMessage());
		}
		mav.addObject("result", searchVO);
		mav.setViewName("jsonView");
		return mav;
    }


    private static class DefaultTrustManager implements X509TrustManager {

        @Override
        public void checkClientTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {}

        @Override
        public void checkServerTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {}

        @Override
        public X509Certificate[] getAcceptedIssuers() {
            return null;
        }
    }
    
    
    
    
    
}


