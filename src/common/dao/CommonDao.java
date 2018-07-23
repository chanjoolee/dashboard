package common.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;


@Repository
//@PropertySource("classpath:config.properties")
public class CommonDao {
	private static final Logger logger = LoggerFactory.getLogger(CommonDao.class);
	
	@Autowired
    private SqlSession sqlSession;

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Value("${jdbc.username}")
    private String testName;
    
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)sqlSession.selectOne(statement, parameter);
    }
    
    @SuppressWarnings("rawtypes")
    public List selectList(String statement,Object parameter) {
    	
    	Object version = ((Map)parameter).get("version");
    	String sqlPackage = "";
    	if(version != null && !version.toString().equals(""))
    		sqlPackage = version.toString() + ".";
    	
    	logger.info(sqlPackage+statement);
        return (List)sqlSession.selectList(sqlPackage+statement, parameter);
    }
    
    @SuppressWarnings("rawtypes")
	public int update(String statement,Object parameter) {
    	
    	logger.info(statement);
        return sqlSession.update(statement, parameter);
    }
    
    @SuppressWarnings("rawtypes")
	public int insert(String statement,Object parameter) {
    	
    	logger.info(statement);
        return sqlSession.insert(statement, parameter);
    }
    
    public int delete(String statement,Object parameter) {
    	logger.info(statement);
        return sqlSession.delete(statement, parameter);
    }
    
//    @Bean
//	public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
//		return new PropertySourcesPlaceholderConfigurer();
//	}
}
