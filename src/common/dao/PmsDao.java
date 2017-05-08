package common.dao;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dashboard.controller.ProjectListByJsonController;


@Repository
public class PmsDao {
	private static final Logger logger = LoggerFactory.getLogger(PmsDao.class);
	
	@Autowired
    private SqlSession sqlSessionPms;

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSessionPms = sqlSession;
    }

    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)sqlSessionPms.selectOne(statement, parameter);
    }
    
    @SuppressWarnings("rawtypes")
    public List selectList(String statement,Object parameter) {
    	
    	Object version = ((Map)parameter).get("version");
    	String sqlPackage = "";
    	if(version != null && !version.toString().equals(""))
    		sqlPackage = version.toString() + ".";
    	
    	logger.info(sqlPackage+statement);
        return (List)sqlSessionPms.selectList(sqlPackage+statement, parameter);
    }
    
}
