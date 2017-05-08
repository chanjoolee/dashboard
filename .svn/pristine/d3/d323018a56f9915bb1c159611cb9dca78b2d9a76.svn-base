package dashboard.ssd.rest;

import java.io.InputStream;
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
import dashboard.ssd.bean.TestSystem;
import dashboard.ssd.service.SSDCusService;
import dashboard.ssd.service.SSDService;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@Component
@Path("/ssdinsert")
public class SSDInsert {
	@Autowired
    private SSDService service;
	
	@Autowired
    private SSDCusService cusService;
	
	@Autowired
    private CommonService commonService;
	
	@Path("/test")
	@GET
	@Produces("application/json")
	public Response ssdInsert() throws JSONException {
		 
		JSONObject jsonObject = new JSONObject();
		Double fahrenheit = 98.24;
		Double celsius;
		celsius = (fahrenheit - 32)*5/9; 
		jsonObject.put("F Value", fahrenheit); 
		jsonObject.put("C Value", celsius);
 
		String result = "@Produces(\"application/json\") Output: \n\nF to C Converter Output: \n\n" + jsonObject;
		return Response.status(200).entity(result).build();
	  } 
	
	@Path("/form")
	@POST
	@Produces("application/json")
	@Consumes("application/x-www-form-urlencoded")
	public Response ssdInsertFormParam(@PathParam("form") String form ,MultivaluedMap<String, String> formParams) throws JSONException {
		 
		JSONObject jsonObject = new JSONObject();
		Double fahrenheit = 98.24;
		Double celsius;
		celsius = (fahrenheit - 32)*5/9; 
		jsonObject.put("F Value", fahrenheit); 
		jsonObject.put("C Value", celsius);
 
		String result = "@Produces(\"application/json\") Output: \n\nF to C Converter Output: \n\n" + jsonObject;
		return Response.status(200).entity(result).build();
	  } 
	
	@POST
	@Path("/upload")
	@Produces("application/json")
	@Consumes({MediaType.MULTIPART_FORM_DATA})
	public Response uploadFile(
		@FormDataParam("datafile") InputStream uploadedInputStream,
		@FormDataParam("datafile") FormDataContentDisposition fileDetail,
		@FormDataParam("emp") String emp,
		@FormDataParam("emp") MultivaluedMap<String, String> emp1,
		@FormDataParam("emp") JSONObject emp2,
		@FormDataParam("emp") FormDataBodyPart jsonPart) {
		JSONObject jsonObject = new JSONObject();
		String uploadedFileLocation = "d://uploaded/" + fileDetail.getFileName();

		// save it
		//writeToFile(uploadedInputStream, uploadedFileLocation);
		
		jsonObject.put("uploadedFileLocation", uploadedFileLocation);
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	@SuppressWarnings("unchecked")
	@POST
	@Produces("application/json")
	@Consumes({MediaType.MULTIPART_FORM_DATA})
	public Response uploadFile2(
			@Context ServletContext context,
			
			@FormDataParam("smart_before") InputStream smart_before ,
			@FormDataParam("smart_before") FormDataContentDisposition smart_before_detail,
			@FormDataParam("smart_after") InputStream smart_after ,
			@FormDataParam("smart_after") FormDataContentDisposition smart_after_detail,
			@FormDataParam("gbb_list_before") InputStream gbb_list_before ,
			@FormDataParam("gbb_list_before") FormDataContentDisposition gbb_list_before_detail,
			@FormDataParam("gbb_list_after") InputStream gbb_list_after ,
			@FormDataParam("gbb_list_after") FormDataContentDisposition gbb_list_after_detail,
			
			@FormDataParam("test_information") String test_information,
			@FormDataParam("test_system") String test_system,
			@FormDataParam("disk_info") String disk_info,
			@FormDataParam("target_ssd") String target_ssd,
			@FormDataParam("test_result") String test_result,
			@FormDataParam("test_log") FormDataBodyPart test_log ,
			FormDataMultiPart multiPart
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			// 새로운 ID
			String newId = service.getNewTestId();
			jsonObject.put("test_id", newId);
			//===== data make ----------//
			JSONObject jsonTestInformation = JSONObject.fromObject(test_information);
			//disk info
			JSONObject jsonDiskInfo = new JSONObject();
			JSONArray diskInfoList = net.sf.json.JSONArray.fromObject(disk_info);
			jsonDiskInfo.put("list", diskInfoList);
			// disk info end
			
			if(test_system != null && test_system.equals("")) 
				test_system = "{}";
			JSONObject jsonTestSystem = JSONObject.fromObject(test_system);
			
			if(target_ssd != null && target_ssd.equals("")) 
				target_ssd = "{}";
			JSONObject jsonTargetSsd = JSONObject.fromObject(target_ssd);
			// test result
			JSONObject jsonTestResult = new JSONObject();
			net.sf.json.JSONArray testResultList = net.sf.json.JSONArray.fromObject(test_result);
			jsonTestResult.put("list", testResultList);
			// test result end
			
			if(!jsonTestInformation.isNullObject()) 
				jsonTestInformation.put("test_id", newId);
			if(!jsonDiskInfo.isNullObject()) 
				jsonDiskInfo.put("test_id", newId);
			if(!jsonTestSystem.isNullObject()) 
				jsonTestSystem.put("test_id", newId);
			if(!jsonTargetSsd.isNullObject()) 
				jsonTargetSsd.put("test_id", newId);
			if(!jsonTestResult.isNullObject())  
				jsonTestResult.put("test_id", newId);
			
			//===== end data make ----------//
			
			
			//=====  data process ===========//
			// TestInformation Id insert
			service.ssdTestInformationNewIDInsert(jsonTestInformation);
			
			// TestInformation Insert
			if(!jsonTestInformation.isNullObject())  
				service.ssdTestInformationInsert(jsonTestInformation);
			if(!jsonTestSystem.isNullObject()) 
				service.ssdTestInformationInsert(jsonTestSystem);
			if(!jsonTargetSsd.isNullObject()) 
				service.ssdTestInformationInsert(jsonTargetSsd);
			
			// Disk Info Insert
			if(disk_info != null) 
				service.ssdTestDiskInfoInsert(jsonDiskInfo);
			
			// Test Result Insert
			if(test_result != null) 
				service.ssdTestResultInsert(jsonTestResult);
			
			//jsonObject.put("test_info", jsonTestInformation);
			//jsonObject.put("test_system_info", jsonTestSystem);
			//jsonObject.put("test_ssd_info", jsonTargetSsd);
			//jsonObject.put("disk_info", jsonDiskInfo);
			//jsonObject.put("test_result_info", jsonTestResult);
			
			//=====  End data process ===========//
			//----------- 파일처리 ---------------//
			JSONArray fileInfos = new JSONArray();
			JSONArray testLogFiles = new JSONArray();
			
			//파일업로드
			List<FormDataBodyPart> fields_smart_before = multiPart.getFields("smart_before");
			if(fields_smart_before != null){
				for(FormDataBodyPart field : fields_smart_before){
			    	Map<String,Object> m = commonService.writeToFile(context,field);
			    	fileInfos.add(m);
			    }
			}
		    
		    
		    List<FormDataBodyPart> fields_smart_after = multiPart.getFields("smart_after");
		    if(fields_smart_after != null){
	    	 for(FormDataBodyPart field : fields_smart_after){
			    	Map<String,Object> m = commonService.writeToFile(context,field);
			    	fileInfos.add(m);
			    }
		    }
		    
		    List<FormDataBodyPart> fields_gbb_list_before = multiPart.getFields("gbb_list_before");
		    if(fields_gbb_list_before != null){
		    	for(FormDataBodyPart field : fields_gbb_list_before){
			    	Map<String,Object> m = commonService.writeToFile(context,field);
			    	fileInfos.add(m);
			    }
		    }
		    
		    List<FormDataBodyPart> fields_gbb_list_after = multiPart.getFields("gbb_list_after");
		    if(fields_gbb_list_after != null){
		    	for(FormDataBodyPart field : fields_gbb_list_after){
			    	Map<String,Object> m = commonService.writeToFile(context,field);
			    	fileInfos.add(m);
			    }
		    }
		    
		    List<FormDataBodyPart> fields_test_log = multiPart.getFields("test_log");
		    if(fields_test_log != null){
		    	for(FormDataBodyPart field : fields_test_log){
			    	Map<String,Object> m = commonService.writeToFile(context,field);
			    	//testLogFiles.add(m);
			    	fileInfos.add(m);
			    }
		    }
		    jsonObject.put("files", fileInfos);
		    //jsonObject.put("fiilesLog", testLogFiles);
		    //end 파일업로드
		    
		    // start 파일업로드 정보 update
		    service.ssdTestFileInfoInsert(jsonObject);
		    // end 파일업로드 정보 update
		    //service.ssdTestFileLogInfoUdate(jsonObject);
		    
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			service.ssdTestInformationCancel(jsonObject);
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/result/edit")
	@Produces("application/json")
	@Consumes({MediaType.MULTIPART_FORM_DATA})
	public Response resultEdit(
			@Context ServletContext context,
			@FormDataParam("origindata") String origindata,		
			@FormDataParam("TEST_LOG") FormDataBodyPart test_log ,
			FormDataMultiPart multiPart
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			JSONObject origin = JSONObject.fromObject(origindata);
			JSONObject postdata =  new JSONObject();
			
			Map<String, List<FormDataBodyPart>> formParts = multiPart.getFields();	
			Iterator<Entry<String,List<FormDataBodyPart>>> iterator = formParts.entrySet().iterator();
			for (Object key : formParts.keySet()) {
				List<FormDataBodyPart> felds = multiPart.getFields(key.toString());
				for(FormDataBodyPart field : felds){
					if(field.getFormDataContentDisposition().getFileName() == null && !field.getName().equals("origindata") )
						postdata.put(field.getName(), field.getValue());
			    }
			}	
			
			jsonObject.put("test_id", postdata.get("TEST_ID"));
			
			
			//----------- 파일처리 ---------------//
			JSONArray fileInfos = new JSONArray();
		    if(!test_log.getContentDisposition().getFileName().equals("")){
		    	Map<String,Object> fileInfo = commonService.writeToFile(context,test_log);
				fileInfos.add(fileInfo);
				jsonObject.put("files", fileInfos);
				postdata.put("TEST_LOG", fileInfo.get("orgFileName"));	
		    }
			
		   
		    //jsonObject.put("fiilesLog", testLogFiles);
		    //end 파일업로드
		    
		    //=====  data process ===========//
			// Test Result Insert
			
		    jsonObject.put("origindata", origin);
			jsonObject.put("postdata", postdata);
			
			cusService.updateResultData(jsonObject);			
			
			//=====  End data process ===========//
		    
		    
		    // start 파일업로드 정보 update
		    service.ssdTestFileInfoUdate(jsonObject);
		    // end 파일업로드 정보 update
		    //service.ssdTestFileLogInfoUdate(jsonObject);
		    
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			//service.ssdTestInformationCancel(jsonObject);
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/result/add")
	@Produces("application/json")
	@Consumes({MediaType.MULTIPART_FORM_DATA})
	public Response resultAdd(
			@Context ServletContext context,
			@FormDataParam("TEST_LOG") FormDataBodyPart test_log ,
			FormDataMultiPart multiPart
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			JSONObject postdata =  new JSONObject();
			
			Map<String, List<FormDataBodyPart>> formParts = multiPart.getFields();	
			Iterator<Entry<String,List<FormDataBodyPart>>> iterator = formParts.entrySet().iterator();
			for (Object key : formParts.keySet()) {
				List<FormDataBodyPart> felds = multiPart.getFields(key.toString());
				for(FormDataBodyPart field : felds){
					if(field.getFormDataContentDisposition().getFileName() == null && !field.getName().equals("origindata") )
						postdata.put(field.getName(), field.getValue());
			    }
			}	
			
			jsonObject.put("test_id", postdata.get("TEST_ID"));
			
			
			//----------- 파일처리 ---------------//
			JSONArray fileInfos = new JSONArray();
		    if(!test_log.getContentDisposition().getFileName().equals("")){
		    	Map<String,Object> fileInfo = commonService.writeToFile(context,test_log);
				fileInfos.add(fileInfo);
				jsonObject.put("files", fileInfos);
				postdata.put("TEST_LOG", fileInfo.get("orgFileName"));	
		    }
			
		   
		    //jsonObject.put("fiilesLog", testLogFiles);
		    //end 파일업로드
		    
		    //=====  data process ===========//
			// Test Result Insert
			
			jsonObject.put("postdata", postdata);
			
			cusService.insertResultData(jsonObject);			
			
			//=====  End data process ===========//
		    
		    
		    // start 파일업로드 정보 update
		    service.ssdTestFileInfoUdate(jsonObject);
		    // end 파일업로드 정보 update
		    //service.ssdTestFileLogInfoUdate(jsonObject);
		    
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			//service.ssdTestInformationCancel(jsonObject);
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/result/delete")
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response resultDelete(
			@Context ServletContext context,
			String jsonRequest
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			JSONObject data = JSONObject.fromObject(jsonRequest);
			jsonObject.put("inputData", data);
			
		    
		    //-- start 파일업로드 정보 update
		    cusService.deleteResultData(data);
		    //-- end 파일업로드 정보 update
		    //service.ssdTestFileLogInfoUdate(jsonObject);
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			//service.ssdTestInformationCancel(jsonObject);
			
		}
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/custom")
	@Produces("application/json")
	@Consumes({MediaType.MULTIPART_FORM_DATA})
	public Response uploadFileCustom(
			@Context ServletContext context,
			@FormDataParam("TEST_ID") String test_id,
			@FormDataParam("FIELD_NAME") String field_name,
			FormDataMultiPart multiPart
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			// 새로운 ID
			String newId = service.getNewTestId();
			jsonObject.put("test_id", test_id);
			
			
			
			//----------- 파일처리 ---------------//
			JSONArray fileInfos = new JSONArray();
			JSONArray testLogFiles = new JSONArray();
			
			//파일업로드
			List<FormDataBodyPart> fields_smart_before = multiPart.getFields("FILE_NAME");
			if(fields_smart_before != null){
				for(FormDataBodyPart field : fields_smart_before){
					field.setName(field_name);
			    	Map<String,Object> m = commonService.writeToFile(context,field);
			    	fileInfos.add(m);
			    }
			}
		    jsonObject.put("files", fileInfos);
		    //jsonObject.put("fiilesLog", testLogFiles);
		    //end 파일업로드
		    
		    //-- start 파일업로드 정보 update
		    service.ssdTestFileInfoUdate(jsonObject);
		    //-- end 파일업로드 정보 update
		    //service.ssdTestFileLogInfoUdate(jsonObject);
		    
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			//service.ssdTestInformationCancel(jsonObject);
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/file/delete")
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response deleteFile(
			@Context ServletContext context,
			String jsonRequest
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			JSONObject data = JSONObject.fromObject(jsonRequest);
			jsonObject.put("inputData", data);
			
		    
		    //-- start 파일업로드 정보 update
		    cusService.ssdTestFileInfoDelete(data);
		    //-- end 파일업로드 정보 update
		    //service.ssdTestFileLogInfoUdate(jsonObject);
		    
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			//service.ssdTestInformationCancel(jsonObject);
			
		}
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/comment/edit")
	@Produces("application/json")
	@Consumes({MediaType.MULTIPART_FORM_DATA})
	public Response commentEdit(
			@Context ServletContext context,
			@FormDataParam("origindata") String origindata,		
			FormDataMultiPart multiPart
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			JSONObject origin = JSONObject.fromObject(origindata);
			JSONObject postdata =  new JSONObject();
			
			Map<String, List<FormDataBodyPart>> formParts = multiPart.getFields();	
			Iterator<Entry<String,List<FormDataBodyPart>>> iterator = formParts.entrySet().iterator();
			for (Object key : formParts.keySet()) {
				List<FormDataBodyPart> felds = multiPart.getFields(key.toString());
				for(FormDataBodyPart field : felds){
					if(field.getFormDataContentDisposition().getFileName() == null && !field.getName().equals("origindata") )
						postdata.put(field.getName(), field.getValue());
			    }
			}	
			
			jsonObject.put("test_id", postdata.get("TEST_ID"));
			
		    
		    //=====  data process ===========//
			// Test Result Insert
			
		    jsonObject.put("origindata", origin);
			jsonObject.put("postdata", postdata);
			
			cusService.updateCommentData(jsonObject);			
			
			//=====  End data process ===========//
		    
		    
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			//service.ssdTestInformationCancel(jsonObject);
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/comment/add")
	@Produces("application/json")
	@Consumes({MediaType.MULTIPART_FORM_DATA})
	public Response commentAdd(
			@Context ServletContext context,
			FormDataMultiPart multiPart
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			JSONObject postdata =  new JSONObject();
			
			Map<String, List<FormDataBodyPart>> formParts = multiPart.getFields();	
			Iterator<Entry<String,List<FormDataBodyPart>>> iterator = formParts.entrySet().iterator();
			for (Object key : formParts.keySet()) {
				List<FormDataBodyPart> felds = multiPart.getFields(key.toString());
				for(FormDataBodyPart field : felds){
					if(field.getFormDataContentDisposition().getFileName() == null && !field.getName().equals("origindata") )
						postdata.put(field.getName(), field.getValue());
			    }
			}	
			
			jsonObject.put("test_id", postdata.get("TEST_ID"));
			
			
			//----------- 파일처리 ---------------//
			
		    //end 파일업로드
		    
		    //=====  data process ===========//
			// Test Result Insert
			
			jsonObject.put("postdata", postdata);
			
			cusService.insertCommentData(jsonObject);			
			
			//=====  End data process ===========//
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			//service.ssdTestInformationCancel(jsonObject);
			
		}
		
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	@SuppressWarnings("unchecked")
	@POST
	@Path("/comment/delete")
	@Produces("application/json")
	@Consumes({MediaType.APPLICATION_JSON})
	public Response commentDelete(
			@Context ServletContext context,
			String jsonRequest
		){
		JSONObject jsonObject = new JSONObject();
		
		try{
			WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
			
			JSONObject data = JSONObject.fromObject(jsonRequest);
			jsonObject.put("inputData", data);
			
		    
		    //-- start 파일업로드 정보 update
		    cusService.deleteCommentData(data);
		    //-- end 파일업로드 정보 update
		    //service.ssdTestFileLogInfoUdate(jsonObject);
	
			jsonObject.put("result", "success");
		}catch(Exception ex){
			jsonObject.put("result", "fail: " + ex.getMessage());
			//service.ssdTestInformationCancel(jsonObject);
			
		}
		
		String output = "" + jsonObject;
		
		return Response.status(200).entity(output).build();

	}
	
	
	
}
