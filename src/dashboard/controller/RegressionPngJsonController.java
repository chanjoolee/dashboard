package dashboard.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import java.io.IOException;
import java.nio.file.*;
import java.nio.file.attribute.*;

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
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class RegressionPngJsonController {

    private static final Logger logger = LoggerFactory.getLogger(RegressionPngJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/regressionPngJson")
    public ModelAndView regressionPngJson(HttpServletRequest request,@RequestParam Map<String,String> parameter,Locale locale, Model model) throws IOException {

    	ModelAndView mav = new ModelAndView();
    	
    	
    	javax.servlet.ServletContext context = request.getSession().getServletContext();
    	String curDirStr = context.getRealPath("");
    	java.io.File curDir = new java.io.File(curDirStr);
    	java.io.File parentDir = new java.io.File(curDir.getParent());
    	
    	java.io.File regressionDir = new java.io.File(curDir.getParentFile().toURI().getPath()+"/regressionTest");
    	//java.io.File regressionDir = curDir;
    	//pngDir.getAbsolutePath();
    	
    	try{
    		//01. 최신디렉토리 구하기
        	java.io.File lastDir = null;
        	BasicFileAttributes lastDirView= null;
        	java.io.File[] dirs = regressionDir.listFiles();
        	for(int i = 0 ;i < dirs.length ; i++){
        		java.io.File dir = dirs[i];
        		String dirname = dir.getName();
        		if(dirname.equals("WEB-INF"))
        			continue;
        		if(dirname.equals("META-INF"))
        			continue;
        		if(dir.isDirectory()){
        			Path p = Paths.get(dir.getAbsolutePath());
            		BasicFileAttributes view= Files.getFileAttributeView(p, BasicFileAttributeView.class).readAttributes();
            		
            		if(lastDir == null){
            			lastDir = dir;
            			lastDirView = view;
            		}else{
            			
            			if(view.creationTime().compareTo(lastDirView.creationTime())>0){
            				lastDirView = view;
            				lastDir = dir;
            			}
            		}
        		}    		
        	}
        	
        	//02. 비슷한 파일이름 찾기
        	java.io.File seletedFile = null;
        	java.io.File[] files = lastDir.listFiles();
        	for(int i = 0 ;i < files.length ; i++){
        		java.io.File file = files[i];
        		String filename = file.getName();
        		if(file.isFile()){
        			Path p = Paths.get(file.getAbsolutePath());
            		BasicFileAttributes view= Files.getFileAttributeView(p, BasicFileAttributeView.class).readAttributes();
            		if( filename.replace(".png","").equalsIgnoreCase(parameter.get("PJT_CODE").toString()) ){
            			seletedFile = file;
            		}
            		
        		}    		
        	}
        	String pngPath =  "";
        	if(seletedFile != null)
        		pngPath = "http://"+request.getServerName()+":"+ request.getServerPort()+ "/regressionTest/"+lastDir.getName()+ "/" + seletedFile.getName();
        	else
        		pngPath =  "http://"+request.getServerName()+":"+ request.getServerPort()+ "/regressionTest/noImage.jpg";
            mav.addObject("pngPath",pngPath );
            
    	}catch(Exception e){
    		 mav.addObject("errMessage",e.getMessage() );
    		 mav.addObject("curDir",curDir.getAbsolutePath());
    		 mav.addObject("regressionDir",regressionDir.getAbsolutePath());
    	}
    	
        mav.setViewName("jsonView");

        return mav;
    }
}
