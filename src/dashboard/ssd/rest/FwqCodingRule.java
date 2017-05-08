package dashboard.ssd.rest;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.jersey.core.header.ContentDisposition;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.BodyPart;
import com.sun.jersey.multipart.FormDataBodyPart;
import com.sun.jersey.multipart.FormDataMultiPart;
import com.sun.jersey.multipart.FormDataParam;

import common.service.CommonService;
import dashboard.fwq.service.FwqCodingRuleService;
import dashboard.fwq.service.FwqFunctionParameterService;
import dashboard.fwq.service.FwqTestCoverageService;
import dashboard.ssd.bean.TestSystem;
import dashboard.ssd.service.SSDCusService;
import dashboard.ssd.service.SSDService;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@Component
@Path("/fwq/codingRule/")
public class FwqCodingRule {
	
	@Autowired
    private FwqCodingRuleService service;
	
	@Autowired
    private CommonService commonService;
	
	@SuppressWarnings("unchecked")
	@GET
	@Path("/list/{pjt_code}{project: /(\\w+)?}/{measureDt1}/{measureDt2}") 
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response getList(
			@Context ServletContext context,
			@PathParam("pjt_code") String pjt_code,
			@PathParam("project") String project,
			@PathParam("measureDt1") String measureDt1,
			@PathParam("measureDt2") String measureDt2,
			String jsonRequest
			//,@PathParam("func_name") String func_name
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			//===== data make ----------//
			if(jsonRequest.equals("")){
				jsonRequest = "{}";
			}
			JSONObject data = JSONObject.fromObject(jsonRequest);
			data.put("pjt_code", pjt_code);
			data.put("project", project.substring(1));
			data.put("measureDt1", measureDt1);
			data.put("measureDt2", measureDt2);
			//data.put("func_name", func_name);
			//===== end data make ----------//
			
			
			//=====  Start data process ===========//
			List list = service.selectList(data);
			
			//=====  End data process ===========//
			jsonObject.put("rows", list);
			jsonObject.put("total", data.size());
			jsonObject.put("page", 1);
			//jsonObject.put("records", data.size());
			jsonObject.put("result", "sucees");
			
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	
	
	
	
}
