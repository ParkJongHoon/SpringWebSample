package myspring.di.xml.test;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import myspring.di.xml.Hello;
import myspring.di.xml.Printer;
import static org.junit.Assert.*;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:config/beans.xml")
public class HelloBeanJunitSpringTest {
	@Autowired
	ApplicationContext context;
	
	@Test 
	public void test1() {		
		//2. Hello Bean 가져오기
		Hello hello =(Hello)context.getBean("hello");
		assertEquals("Hello Spring", hello.sayHello());
		hello.print();
		
		assertEquals(3, hello.getNames().size());
		List<String> list = hello.getNames();
		for(String value: list) {
			System.out.println(value);
		}
		
		
		//3. StringPrinter Bean 가져오기
		Printer printer = context.getBean("printer", Printer.class);
		assertEquals("Hello Spring", printer.toString());
		
	}
	
	@Test
	public void test2() {
		Hello hello = context.getBean("hello", Hello.class);
		Hello hello2 = context.getBean("hello", Hello.class);
		assertSame(hello, hello2);
		
	}
	
}
