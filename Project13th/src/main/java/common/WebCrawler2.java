package common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.HttpClientBuilder;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.web.bind.annotation.ResponseBody;

public class WebCrawler2 {

   // 크롤링 메소드
   @ResponseBody
   public Object getInfo2() throws Exception {

      System.out.println("크롤링 시스템 진입");
      // Jsoup를 이용해서 네이버 검색 결과 크롤링
      URL url = new URL("https://search.naver.com/search.naver?sm=tab_hty.top&where=news&query=테마파크");

      // 입력스트림 생성
      InputStreamReader reader = new InputStreamReader(url.openStream());

      BufferedReader br = new BufferedReader(reader);
      String inLine = null;
      StringBuffer contents = new StringBuffer();

      // URL을 통해 가져온 HTML 소스를 라인단위로 읽어서 변수에 저장함
      while ((inLine = br.readLine()) != null) {
         contents.append(inLine); 
      }
      
      
      // 스트림 소멸
      br.close();
      System.out.println("컨텐츠:"+contents); 

      Document doc = Jsoup.parse(contents.toString());
      Elements el = doc.select("#main_pack");
      System.out.println(el);
      Elements elements = el.select("ul.type01");
      System.out.println(elements);
      

      ArrayList temp = new ArrayList();
      for (Element imsi : elements) {

         System.out.println("text:"+imsi.text());
         System.out.println("imsi:"+imsi.getElementsByAttribute("href").attr("href"));      
         temp.add(imsi);
         System.out.println("임시"+imsi);     
      }
      
           
      return temp;
      


   }

}