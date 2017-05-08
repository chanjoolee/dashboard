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
import dashboard.fwq.service.FwqTestCoverageService;
import dashboard.ssd.bean.TestSystem;
import dashboard.ssd.service.SSDCusService;
import dashboard.ssd.service.SSDService;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@Component
@Path("/fwq/testCoverage/")
public class FwqTestCoverage {
	@Autowired
    private SSDService service;
	
	@Autowired
    private SSDCusService cusService;
	
	@Autowired
    private FwqTestCoverageService fwqService;
	
	@Autowired
    private CommonService commonService;
	
	
	/**
	 * 간단한 입력을 가정함. 복잡한 json을 이용할 경우 dashboard.ssd.rest.SSDInsert.uploadFile2 를 참조하세요.
	 * @param context
	 * @param measure_dt
	 * @param project
	 * @param item1
	 * @param item2
	 * @param item3
	 * @param point
	 * @param multiPart
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@POST
	@Path("/insert/raw")
	@Produces("application/json")
	@Consumes({MediaType.MULTIPART_FORM_DATA})
	public Response insertRaw(
			@Context ServletContext context,
			
			@FormDataParam("measure_dt") String measure_dt,
			@FormDataParam("project") String project,
			@FormDataParam("item1") String item1,
			@FormDataParam("item2") String item2,
			@FormDataParam("item3") String item3,
			@FormDataParam("point") String point,
			FormDataMultiPart multiPart
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			//===== data make ----------//
			Map<String,Object> input = new HashMap<String, Object>();
			input.put("measure_dt", measure_dt);
			input.put("project", project);
			input.put("item1", item1);
			input.put("item2", item2);
			input.put("item3", item3);
			input.put("point", point);
			//===== end data make ----------//
			
			
			//=====  Start data process ===========//
			fwqService.insertRawData(input);
			
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
	@Path("/insert/raw/json")
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response insertRawJson(
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
			fwqService.insertRawData(data);
			
			//=====  End data process ===========//
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	
}
