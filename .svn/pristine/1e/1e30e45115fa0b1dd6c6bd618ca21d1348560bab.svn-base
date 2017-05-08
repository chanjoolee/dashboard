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
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
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
import dashboard.backbone.service.BacboneService;
import dashboard.fwq.service.FwqFunctionParameterService;
import dashboard.fwq.service.FwqTestCoverageService;
import dashboard.ssd.bean.TestSystem;
import dashboard.ssd.service.SSDCusService;
import dashboard.ssd.service.SSDService;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@Component
@Path("/backbone/")
public class Backbone {
	
	@Autowired
    private BacboneService service;
	
	@Autowired
    private CommonService commonService;
	
	
	@SuppressWarnings("unchecked")
	@GET
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
			JSONObject data ;
			try{
				data = JSONObject.fromObject(jsonRequest);
			}catch(Exception ex){
				data = JSONObject.fromObject("{}");
			}
			//===== end data make ----------//
			
			
			//=====  Start data process ===========//
			List<?> list = service.dashboardProjectList(data);
			jsonObject.put("list", list);
			
			//=====  End data process ===========//
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			
		}		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	@SuppressWarnings("unchecked")
	@Path("{pjt_code}")
	@PUT
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response put(
			@Context ServletContext context,
			@PathParam("pjt_code") String pjt_code,
			String jsonRequest
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			//===== data make ----------//
			JSONObject data ;
			try{
				data = JSONObject.fromObject(jsonRequest);
			}catch(Exception ex){
				data = JSONObject.fromObject("{}");
			}
			//===== end data make ----------//
			
			
			//=====  Start data process ===========//
			service.dashboardProjectUpdate(data);
			
			//=====  End data process ===========//
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			
		}		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	@SuppressWarnings("unchecked")
	@Path("{pjt_code}")
	@POST
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response create(
			@Context ServletContext context,
			@PathParam("pjt_code") String pjt_code,
			String jsonRequest
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			//===== data make ----------//
			JSONObject data ;
			try{
				data = JSONObject.fromObject(jsonRequest);
			}catch(Exception ex){
				data = JSONObject.fromObject("{}");
			}
			//===== end data make ----------//
			
			
			//=====  Start data process ===========//
			service.dashboardProjectUpdate(data);
			
			//=====  End data process ===========//
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			
		}		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	
	
	
	
	
}
