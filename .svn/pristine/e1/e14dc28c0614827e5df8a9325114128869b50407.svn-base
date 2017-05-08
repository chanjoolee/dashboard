package common.dao;

import java.util.*;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import dashboard.controller.ProjectListByJsonController;


@Repository
//@PropertySource("classpath:config.properties")
public class OperDao {
	private static final Logger logger = LoggerFactory.getLogger(OperDao.class);
	
	@Autowired
    private SqlSession sqlSessionOper;

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSessionOper = sqlSession;
    }

    @Value("${jdbc.username}")
    private String testName;
    
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)sqlSessionOper.selectOne(statement, parameter);
    }
    
    @SuppressWarnings("rawtypes")
    public List selectList(String statement,Object parameter) {
    	
    	//Object version = ((Map)parameter).get("version");
    	String sqlPackage = "";
    	//if(version != null && !version.toString().equals(""))
    	//	sqlPackage = version.toString() + ".";
    	
    	logger.info(sqlPackage+statement);
        return (List)sqlSessionOper.selectList(sqlPackage+statement, parameter);
    }
    
    @SuppressWarnings("rawtypes")
	public int update(String statement,Object parameter) {
    	
    	logger.info(statement);
        return sqlSessionOper.update(statement, parameter);
    }
    
//    @Bean
//	public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
//		return new PropertySourcesPlaceholderConfigurer();
//	}
}
