package dashboard.pms.rest;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dashboard.pms.service.DvtRestService;

@Component
@Path("/dvtRest")
public class DvtRest {
	
	@Autowired
    private DvtRestService service;
	
	@POST
	@Path("/retrieveFwVersion")
	@Produces("application/json")
	@Consumes("application/json")
    public Response userLogin(InputStream ins) throws Exception {
		
    	JSONObject jsonObj = new JSONObject();
    	
    	try {
    		
    		BufferedReader br = new BufferedReader(new InputStreamReader(ins));
			String line = null;
			
			StringBuilder sb = new StringBuilder(); 
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			
			br.close();
    		
    		JSONObject inJsonObj = (JSONObject)JSONSerializer.toJSON(sb.toString());
    		
    		String modelName = inJsonObj.get("modelName").toString();
    		
    		Map<Object,Object> searchVO = new HashMap<Object,Object>();
    		searchVO.put("modelName", modelName);
    		
    		List<?> dataList = service.selectFwVersionList(searchVO);
    		int dataCnt = dataList.size();
    		
    		JSONArray jsonArray = new JSONArray();
            for(int i=0; i<dataCnt; i++) {			
    			jsonArray.add(dataList.get(i));
    		}
    		
            jsonObj.put("result", "SUCCESS");
    		jsonObj.put("modelName", modelName);
    		jsonObj.put("count", dataCnt);
    		jsonObj.put("data", jsonArray);
	        
    	} catch(Exception e) {
    		e.printStackTrace();
    		
    		jsonObj.put("result", "FAIL");
    		jsonObj.put("message", e.getMessage());
    	}
    	
    	return Response.status(200).entity(jsonObj.toString()).build();
    }
}