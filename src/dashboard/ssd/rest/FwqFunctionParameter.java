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
import dashboard.fwq.service.FwqFunctionParameterService;
import dashboard.fwq.service.FwqTestCoverageService;
import dashboard.ssd.bean.TestSystem;
import dashboard.ssd.service.SSDCusService;
import dashboard.ssd.service.SSDService;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@Component
@Path("/fwq/functionParameter/")
public class FwqFunctionParameter {
	
	@Autowired
    private FwqFunctionParameterService service;
	
	@Autowired
    private CommonService commonService;
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/insert")
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response insert(
			@Context ServletContext context,
			String jsonRequest
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			//===== data make ----------//
			JSONObject data = JSONObject.fromObject(jsonRequest);
			//===== end data make ----------//
			
			
			//=====  Start data process ===========//
			service.insertRawData(data);
			
			//=====  End data process ===========//
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/insertList")
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response insertList(
			@Context ServletContext context,
			String jsonRequest
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			//===== data make ----------//
			net.sf.json.JSONArray testResultList = net.sf.json.JSONArray.fromObject(jsonRequest);
			//===== end data make ----------//
			
			
			//=====  Start data process ===========//
			service.insertlist(testResultList,jsonObject);
			
			//=====  End data process ===========//
	
			
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/list") 
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response list(
			@Context ServletContext context,
			String jsonRequest
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			//===== data make ----------//
			if(jsonRequest.equals("")){
				jsonRequest = "{}";
			}
			JSONObject data = JSONObject.fromObject(jsonRequest);
			//===== end data make ----------//
			
			
			//=====  Start data process ===========//
			List list = service.selectList(data);
			
			//=====  End data process ===========//
			jsonObject.put("list", list);
			jsonObject.put("result", "sucees");
			
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	@SuppressWarnings("unchecked")
	@GET
	@Path("/list/{project}{measureDt : (/\\w+)?}") 
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response getList(
			@Context ServletContext context,
			@PathParam("project") String project,
			@PathParam("measureDt") String measureDt,
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
			data.put("project", project);
			data.put("measureDt", measureDt.substring(1));
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
