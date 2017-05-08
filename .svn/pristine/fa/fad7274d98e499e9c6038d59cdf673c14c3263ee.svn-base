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
public class RnddasDao {
	private static final Logger logger = LoggerFactory.getLogger(RnddasDao.class);
	
	@Autowired
    private SqlSession sqlSessionRnddas;

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSessionRnddas = sqlSession;
    }

    @Value("${jdbc.username}")
    private String userName;
    
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)sqlSessionRnddas.selectOne(statement, parameter);
    }
    
    @SuppressWarnings("rawtypes")
    public List selectList(String statement,Object parameter) {
    	
    	Object version = ((Map)parameter).get("version");
    	String sqlPackage = "";
    	if(version != null && !version.toString().equals(""))
    		sqlPackage = version.toString() + ".";
    	
    	logger.info(sqlPackage+statement);
        return (List)sqlSessionRnddas.selectList(sqlPackage+statement, parameter);
    }
    
    @SuppressWarnings("rawtypes")
	public int update(String statement,Object parameter) {
    	
    	logger.info(statement);
        return sqlSessionRnddas.update(statement, parameter);
    }
    
//    @Bean
//	public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
//		return new PropertySourcesPlaceholderConfigurer();
//	}
}
