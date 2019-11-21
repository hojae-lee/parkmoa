package springboard.util;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.io.support.ResourcePropertySource;

public class EnvFileReader {

	public static String getValue(String envFile, String keyName) {
		
		/*
	      1. 스프링 컨텍스트 생성(Ctrl+t로 상속관계를 확인할 수 있음)
	       */
	      ConfigurableApplicationContext ctx = new GenericApplicationContext();
	      
	      /*
	      2. Environment 객체를 생성
	       */
	      ConfigurableEnvironment env = ctx.getEnvironment();
	      
	      /*
	      3. getPropertySources() 메소드를 통해 
	       */
	      MutablePropertySources propertySources = env.getPropertySources();
	      
	      String envStr = "";

	      try {
	    	  	         /*
	         4. 외부파일의 경로를 지정한 후 addLast() 메소드를 통해 프로퍼티소스에 추가한다.
	          */
	         String envPath = "classpath:"+envFile;
	         propertySources.addLast(new ResourcePropertySource(envPath));
	         /*
	         5. 파일의 내용을 읽어 변수에 저장
	          */
	         envStr = env.getProperty(keyName);
	      } 
	      catch (Exception e) {
	         e.printStackTrace();
	      }
	      
		return envStr;
	}
}
