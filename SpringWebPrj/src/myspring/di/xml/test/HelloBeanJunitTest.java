package myspring.di.xml.test;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.GenericXmlApplicationContext;

import junit.framework.Assert;
import myspring.di.xml.Hello;
import myspring.di.xml.Printer;
import static org.junit.Assert.*;

public class HelloBeanJunitTest {
	
	ApplicationContext context;
	
	@Before
	public void init() {
		//IoC 컨테이너 생성
		//1.ApplicationContext 객체 생
		context = new GenericXmlApplicationContext("config/beans.xml");
	}
	
	@Test 
	public void test1() {		
		//2. Hello Bean 가져오기
		Hello hello =(Hello)context.getBean("hello");
		assertEquals("Hello Spring", hello.sayHello());
		hello.print();
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
