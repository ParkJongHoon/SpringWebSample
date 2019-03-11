package myspring.user;

import static org.junit.Assert.assertEquals;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import myspring.user.service.UserService;
import myspring.user.vo.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:config/beans.xml")
public class UserClient {
	@Autowired
	ApplicationContext context;
	
	@Autowired
	UserService service;
	
	@Test @Ignore
	public void dataSourceTest() {
		DataSource ds = (DataSource) context.getBean("dataSource");
		try {
			System.out.println(ds.getConnection());
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Test @Ignore
	public void getUserTest() {
		UserVO user = service.getUser("gildong");
		System.out.println(user);
		assertEquals("홍길동", user.getName());
	}
	@Test 
	public void getUsersTest() {
		for (UserVO user : service.getUserList()) {
			System.out.println(user);
		}
	}
	
	@Test @Ignore
	public void insertUserTest() {
		service.insertUser(new UserVO("AOA","설현", "여", "부산"));
		
		for (UserVO user : service.getUserList()) {
			System.out.println(user);
		}
	}
	
	@Test @Ignore
	public void updateUserTest() {
		service.updateUser(new UserVO("m05214", "박종훈", "남", "한국"));
		UserVO user = service.getUser("m05214");
		System.out.println(user);
	}
	
	@Test @Ignore
	public void deleteUserTest() {
		service.deleteUser("m05214");
		
		for (UserVO user : service.getUserList()) {
			System.out.println(user);
		}
	}
}
