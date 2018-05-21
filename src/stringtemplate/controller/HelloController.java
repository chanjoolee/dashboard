package stringtemplate.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import org.stringtemplate.v4.*;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class HelloController {

    private static final Logger logger = LoggerFactory.getLogger(HelloController.class);

    


    @RequestMapping(value = "/st/helloJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView deliverableGeneralJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	 ST hello = new ST("Hello, <name>");
         hello.add("name", "World");
         mav.addObject("source", hello);
         mav.addObject("result", hello.render());
         mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/st/groupStringsJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView groupStringsJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	String g =
    		    "a(x) ::= <<foo>>\n"+
    		    "b() ::= <<bar>>\n";
		STGroup group = new STGroupString(g);
		ST st = group.getInstanceOf("b");
		String expected = "foo";
		String result = st.render();
		
        mav.addObject("source", group);
        mav.addObject("result", result);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/st/groupStrings_1Json",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView groupStrings_1Json(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	String g  ="decl(type, name, value) ::= <<<type> <name><init(value)>;>>";
    	g  +=  "init(v) ::= << <if(v)> = <v><endif> >>";
    	
    	STGroup group = new STGroupString(g);
    	ST st = group.getInstanceOf("decl");
    	st.add("type", "int");
    	st.add("name", "x");
    	st.add("value", 0);
    	String result = st.render(); // yields "int x = 0;"
		
        mav.addObject("source", group);
        mav.addObject("result", result);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/st/groupStrings_file_Json",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView groupStrings_file_Json(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	String path = request.getSession().getServletContext().getRealPath("/stg");
    	ModelAndView mav = new ModelAndView(); 
    	
    	STGroup group = new STGroupDir(path);
    	ST st = group.getInstanceOf("decl");
    	st.add("type", "int");
    	st.add("name", "x");
    	st.add("value", 0);
    	String result = st.render(); // yields "int x = 0;"
		
        mav.addObject("source", group);
        mav.addObject("result", result);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
}
