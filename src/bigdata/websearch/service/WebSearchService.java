package bigdata.websearch.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sun.jersey.core.header.ContentDisposition;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataBodyPart;

import common.dao.CommonDao;
import common.dao.PmsDao;

import net.sf.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;


import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;


import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.KeyManager;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

@Service
public class WebSearchService {
	private static final Logger logger = LoggerFactory.getLogger(WebSearchService.class);

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsDao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
	@SuppressWarnings("rawtypes")
    public List selectList(String statement,Object parameter) {
        return (List)dao.selectList(statement, parameter);
    }
	
	@SuppressWarnings("rawtypes")
    public void update(String statement,Object parameter) {
        dao.update(statement, parameter);
    }
	
	public void httpUrlConnection(Map<Object, Object> searchVO, ModelAndView mav, String USER_AGENT)
			throws MalformedURLException, IOException, ProtocolException {
		JSONObject searchJson = (JSONObject)searchVO.get("searchJson");
		net.sf.json.JSONArray sites = (net.sf.json.JSONArray)searchJson.get("sites");
		for(int i = 0 ; i < sites.size() ; i++){
			JSONObject site = (JSONObject)sites.get(i);
			String sitename = (String)site.get("site");
			String url = (String)site.get("url");
			URL obj = new URL(url);
			//HttpURLConnection.setFollowRedirects(false);
			
			//HttpsURLConnection  con = (HttpsURLConnection ) new URL(url.replace(" ","%20")).openConnection();
			HttpURLConnection  con = (HttpURLConnection ) new URL(url.replace(" ","%20")).openConnection();
//			con.setHostnameVerifier(new HostnameVerifier() {
//	            @Override
//	            public boolean verify(String arg0, SSLSession arg1) {
//	                return true;
//	            }
//	        });
			
			con.setRequestMethod("GET");
			con.setRequestProperty("User-Agent", USER_AGENT);
			
			
			//con.setRequestProperty("Accept", "*/*"); 
			//con.setRequestProperty("Accept-Encoding", "gzip, deflate, br"); 
			//con.setRequestProperty("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.6,en;q=0.4"); 
			
			con.setRequestProperty("Authorization", "Basic "); 
			con.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
			
			int responseCode = con.getResponseCode();
			
			String headerType = con.getContentType();
			
			BufferedReader in = null ;
			if (headerType.toUpperCase().indexOf("EUC-KR") != -1){
				in = new BufferedReader(  new InputStreamReader(con.getInputStream(), "EUC-KR") );
			} else if (headerType.toUpperCase().indexOf("UTF-8") != -1){
				in = new BufferedReader(  new InputStreamReader(con.getInputStream(), "UTF-8") );
			}
			new BufferedReader(  new InputStreamReader(con.getInputStream()) );
			
			String inputLine;
			StringBuffer response = new StringBuffer();				
			while ((inputLine = in.readLine()) != null) {
				
				response.append(inputLine);
				response.append("\r\n");
			}
			in.close();
			//site.put("response", net.sf.json.JSONObject.fromObject(response.toString()));
			site.put("response", response.toString());
			
		}
		//mav.addObject("searchResult", searchJson);
	}
	
	public void HttpClientConnection(Map<Object, Object> searchVO, ModelAndView mav, String USER_AGENT)
			throws MalformedURLException, IOException, ProtocolException {
		JSONObject searchJson = (JSONObject)searchVO.get("searchJson");
		net.sf.json.JSONArray sites = (net.sf.json.JSONArray)searchJson.get("sites");
		for(int i = 0 ; i < sites.size() ; i++){
			JSONObject site = (JSONObject)sites.get(i);
			String sitename = (String)site.get("site");
			String url = (String)site.get("url");
			
			HttpClient client = new DefaultHttpClient();
			HttpGet request = new HttpGet(url);
			
			request.setHeader("Accept", "*/*"); 
			request.setHeader("Accept-Encoding", "gzip, deflate, br"); 
			request.setHeader("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.6,en;q=0.4"); 
			
			// add request header
			request.addHeader("User-Agent", USER_AGENT);
			HttpResponse response = client.execute(request);
			
			
			BufferedReader rd = new BufferedReader( new InputStreamReader(response.getEntity().getContent()) );
			
			String inputLine;
			StringBuffer result  = new StringBuffer();				
			String line = "";
			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
			site.put("response", result.toString());
			
		}
		mav.addObject("searchResult", searchJson);
	}
	

	
}
