package com.kosmo.project3rd;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonArrayFormatVisitor;
import com.github.scribejava.core.model.OAuth2AccessToken;

import common.WebCrawler2;
import javafx.scene.web.WebView;
import parkmoa.model.ParkinginfoDTO;
import parkmoa.model.ParkmoaBoardDTO;
import parkmoa.model.ParkmoaImpl;
import parkmoa.model.ParkmoaMemberDTO;
import parkmoa.model.ParkmoamainImpl;
import parkmoa.model.PaymentDTO;
import parkmoa.model.ReservationDTO;
import parkmoa.model.ThemeParkDTO;
import parkmoa.model.TicketsDTO;
import springboard.util.MailUtil;
import springboard.util.PagingUtil;

@Controller
public class ParkmoaController {

   private NaverLoginBO naverLoginBO;
   private String apiResult = null;

   // 구글 로그인 Api사용
   @Autowired
   private GoogleConnectionFactory googleConnectionFactory;
   @Autowired
   private OAuth2Parameters googleOAuth2Parameters;

   @Autowired
   private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
      this.naverLoginBO = naverLoginBO;
   }

   @Autowired
   private KakaoAPI kakao;

   @Autowired
   private SqlSession sqlSession;

   @RequestMapping("/parkmoa/member/layout.do")
   public String layout() {
      return "/parkmoa/member/layout";
   }

   // 메인화면
   @RequestMapping("/parkmoa/index.do")
   public ModelAndView index(HttpServletRequest req) throws Exception {

      String authority = req.getParameter("authority");

      System.out.println("넘어오는 authority값:" + authority);
      int reviewcount = 0;

      reviewcount = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).reviewcount();

      ParkmoaBoardDTO parkmoaBoardDTO = new ParkmoaBoardDTO();

      ArrayList<ParkmoaBoardDTO> reviewlists = null;
      int start = 1;
      int end = 5;
      reviewlists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).reviewlists(start, end);

      ModelAndView mv = new ModelAndView();

      mv.setViewName("parkmoa/index");
      mv.addObject("authority", authority);
      mv.addObject("reviewcount", reviewcount);
      mv.addObject("reviewlists", reviewlists);
      
      WebCrawler2 crawler2 = new WebCrawler2();
      mv.addObject("currentInfo", crawler2.getInfo2());
      
      return mv;
   }

   // 메인에서 리뷰=>리스트상세보기
   @RequestMapping("/parkmoa/board/listActionView.do")
   public ModelAndView listActionView(HttpServletRequest req) {

      int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
      String authority = req.getParameter("authority");
      System.out.println(tp_idx);
      System.out.println(authority);

      String tp_category = "";
      int visitcount = 0;

      tp_category = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selecttp_category(tp_idx);
      if (tp_category != null) {
         visitcount = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).updatevisitcount(tp_idx);
         System.out.println("visitcount=" + visitcount);
      }

      System.out.println(tp_category);
      ModelAndView mv = new ModelAndView(); 

      mv.addObject("tp_category", tp_category);
      mv.addObject("authority", authority);
      mv.addObject("tp_idx", tp_idx);
      mv.setViewName("redirect:../board/listView.do");

      return mv;
   }

   // 로그인페이지
   @RequestMapping("/parkmoa/member/login.do")
   public String login(Model model, HttpSession session) {

      /* 구글code 발행 */
      OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();

      /* 구글로그인 url생성 */
      String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
      model.addAttribute("google_url", url);

      String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
      model.addAttribute("url", naverAuthUrl);

      return "parkmoa/member/login";
   }

   // 구글 Callback호출 메소드
   @RequestMapping(value = "/parkmoa/member/googlecallback", method = { RequestMethod.GET, RequestMethod.POST })
   public String googleCallback(HttpServletRequest req, HttpSession session, Model model, @RequestParam String code,
         @RequestParam String scope) throws IOException {

      System.out.println("Google login success");
      System.out.println(code);
      System.out.println(scope);

      OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
      AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(),
            null);
      String accessToken = accessGrant.getAccessToken();
      Long expireTime = accessGrant.getExpireTime();
      if (expireTime != null && expireTime < System.currentTimeMillis()) {
         accessToken = accessGrant.getRefreshToken();
      }
      Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
      Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
      PlusOperations plusOperations = google.plusOperations();
      Person person = plusOperations.getGoogleProfile();
      System.out.println("아이디:" + person.getId());// 고유한 숫자
      System.out.println("이메일:" + person.getEmailAddresses());// [*****@gmail.com]

      String m_email2 = person.getEmailAddresses().toString();
      String m_email = m_email2.substring(1, m_email2.length() - 1);
      System.out.println("m_email2" + m_email2);

      int affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectMember(m_email);

      // 일치하는 아이디 있는 경우 (기존회원)
      if (affected == 1) {
         ParkmoaMemberDTO dto;
         dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectMember1(m_email);

         String authority = dto.getAuthority();
         String m_id = dto.getM_id();
         session.setAttribute("m_id", m_id);
         model.addAttribute("authority", authority);
         return "redirect:../index.do";

      } else {
         // 아이디와 이메일정보 회원약관페이지로(회원가입시키기)
         String m_id = m_email.split("@")[0] + "gm";
         System.out.println("구글아이디:" + m_id);
         session.setAttribute("m_id", m_id);
         session.setAttribute("m_email", m_email);
         return "redirect:./policy.do";
      }

   }

   // 로그인페이지
   @RequestMapping("/parkmoa/member/LoginAction.do")
   public ModelAndView login(HttpServletRequest req, HttpServletResponse resp) {

      ModelAndView mv = new ModelAndView();
      HttpSession session = req.getSession();

      ParkmoaMemberDTO dto = new ParkmoaMemberDTO();

      String id = req.getParameter("id");
      String pw = req.getParameter("pw");
      String m_pw = "";
      int enabled = 0;
      String authority = "";

      System.out.println("id=" + id);
      System.out.println("pw=" + pw);

      m_pw = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).login(id);

      System.out.println("sqsqsqsq" + m_pw);
      System.out.println("ewefewfwe" + enabled);

      if (pw.equalsIgnoreCase(m_pw)) {
         enabled = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectenabled(id);
         if (enabled == 1) {
            System.out.println("로그인성공");
            System.out.println("활성화 된 사용자 입니다.");
            authority = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectauthority(id);
            session.setAttribute("m_id", id);
            mv.addObject("authority", authority);
            mv.setViewName("redirect:/parkmoa/index.do");

         } else {
            System.out.println("로그인실패");
            System.out.println("비활성화 된 사용자 입니다.");
            mv.setViewName("redirect:/parkmoa/member/login.do");
         }
      } else {
         System.out.println("로그인실패!");
         System.out.println("아이디가 없습니다.");
         System.out.println("비밀번호가일치하지않습니다.");
         mv.setViewName("redirect:/parkmoa/member/login.do");
      }

      return mv;
   }

   @RequestMapping("parkmoa/member/logout.do")
   public ModelAndView logout(HttpServletRequest req) {
      ModelAndView mv = new ModelAndView();
      HttpSession session = req.getSession();
      session.invalidate();
      mv.setViewName("redirect:/parkmoa/member/login.do");

      return mv;
   }

   // 내 정보페이지
   @RequestMapping("/parkmoa/member/myPage.do")
   public ModelAndView myPage(HttpServletRequest req) {

      String authority = req.getParameter("authority");
      HttpSession session = req.getSession();
      String id = session.getAttribute("m_id").toString();
      session.setAttribute("authority", authority);

      System.out.println("authority=" + authority);
      System.out.println("id=" + id);

      ParkmoaMemberDTO parkmoaMemberDTO = new ParkmoaMemberDTO();

      parkmoaMemberDTO = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).myPageselect(authority, id);

      ModelAndView mv = new ModelAndView();

      mv.addObject("authority", authority);
      mv.addObject("dto", parkmoaMemberDTO);
      mv.setViewName("parkmoa/member/myPage");

      return mv;
   }

   // 내가 남린 리뷰 보기
   @RequestMapping("/parkmoa/member/myPageReview.do")
   public ModelAndView myPageReview(HttpServletRequest req) {

      String authority = req.getParameter("authority");
      HttpSession session = req.getSession();
      String m_id = session.getAttribute("m_id").toString();

      System.out.println("authority=" + authority);
      System.out.println("m_id=" + m_id);

      int totalRecordCount = 0;

      totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).reviewselectCnt(m_id);
      System.out.println("마잎이지리뷰토탈:" + totalRecordCount);

      int pageSize = 5;
      int blockPage = 5;

      int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);

      int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
      int start = (nowPage - 1) * pageSize + 1;
      int end = nowPage * pageSize;

      String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
            req.getContextPath() + "/parkmoa/member/myPageReview.do?");

      ArrayList<ParkmoaBoardDTO> lists = null;
      lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).reviewSelectList(m_id, start, end);

      ModelAndView mv = new ModelAndView();

      mv.addObject("pagingImg", pagingImg);
      mv.addObject("lists", lists);
      mv.addObject("authority", authority);
      mv.setViewName("parkmoa/member/myPageReview");

      return mv;
   }

   // 내정보수정하기
   @RequestMapping("/parkmoa/member/myPageaction.do")
   public ModelAndView myPageaction(HttpServletRequest req, ParkmoaMemberDTO parkmoaMemberDTO) {

      String authority = req.getParameter("authority");
      int myupdate = 0;
      myupdate = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).mypageUpdate(parkmoaMemberDTO);

      System.out.println("myupdate=" + myupdate);

      ModelAndView mv = new ModelAndView();
      mv.addObject("authority", authority);
      mv.setViewName("redirect:/parkmoa/member/myPage.do");

      return mv;
   }

   // 테마파크 등록신청 페이지로 이동
   @RequestMapping("/parkmoa/member/themeRegist.do")
   public ModelAndView themeRegist(HttpServletRequest req, HttpServletResponse response) throws IOException {

      ModelAndView mv = new ModelAndView();
      HttpSession session = req.getSession();

      String m_id = session.getAttribute("m_id").toString();

      String authority = req.getParameter("authority") == null ? "" : req.getParameter("authority");

      // 테마파크 등록시 authority 값으로 판단하여 페이지 이동.company 멤버인 경우에만 페이지 이동.
      if (authority.equalsIgnoreCase("company")) {

         mv.setViewName("parkmoa/member/themeRegist");
         mv.addObject("authority", authority);
         // mv.addObject("m_id", m_id);
      }
      if (authority.equalsIgnoreCase("member")) {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         out.println("<script>alert('기업회원만 접근가능합니다.'); "
               + "location.href='/project3rd/parkmoa/index.do?authority=member';</script>");
         out.flush();
      }
      if (authority.equalsIgnoreCase("") || authority == null) {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         out.println("<script>alert('기업회원만 접근가능합니다.'); "
               + "location.href='/project3rd/parkmoa/index.do?authority=';</script>");
         out.flush();
      }

      return mv;
   }

   // 테마파크 등록신청
   @RequestMapping(value = "/parkmoa/member/tp_apply.do", method = RequestMethod.POST)
   @ResponseBody
   public String ApplyAction(Model model, HttpServletRequest req, ParkmoaBoardDTO parkmoaBoardDTO,
         MultipartHttpServletRequest mhsr) throws IllegalStateException, IOException {

      String authority = req.getParameter("authority");
      MultipartFile files = mhsr.getFile("fileNm");
      // 넘어오는 폼값(이용권)
      String[] t_name = req.getParameterValues("t_name");

      for (int i = 0; i < t_name.length; i++) {
         System.out.println("이용권이름:" + t_name[i]);
      }

      String[] t_price1 = req.getParameterValues("t_price");
      int[] t_price = new int[t_price1.length];

      for (int i = 0; i < t_price1.length; i++) {
         t_price[i] = Integer.parseInt(t_price1[i]);
      }

      for (int i = 0; i < t_price.length; i++) {
         System.out.println("이용권가격:" + t_price[i]);
      }

      String path = req.getSession().getServletContext().getRealPath("/resources/upload");
      System.out.println("path:" + path);

      Map returnObj = new HashMap();

      Iterator itr = mhsr.getFileNames();
      MultipartFile mfile = null;
      String fileName = "";
      List resultList = new ArrayList();

      // 파일 외 나머지 폼값받기
      String m_id = mhsr.getParameter("m_id");
      String tp_category = mhsr.getParameter("tp_category");
      System.out.println("테파마크유형:" + tp_category);
      String tp_parkregi = mhsr.getParameter("tp_parkregi");
      String tp_name = mhsr.getParameter("tp_name");
      String tp_phone = mhsr.getParameter("tp_phone");
      String tp_addr1 = mhsr.getParameter("tp_addr1");
      String tp_content = mhsr.getParameter("tp_content");
      int p_num = Integer.parseInt(mhsr.getParameter("p_num"));

      File directory = new File(path);
      if (!directory.isDirectory()) {
         directory.mkdirs();
      }

      int affected = 0;

      while (itr.hasNext()) {

         fileName = (String) itr.next();
         // 서버로 업로드된 임시파일명 가져오기
         mfile = mhsr.getFile(fileName);

         // 한글깨짐방지 처리 후 업로드된 파일명을 가져옴
         String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");

         if ("".equals(originalName)) {
            continue;
         }

         if (mfile.isEmpty() == false) {
            // 파일의 확장자 가져오기
            String ext = originalName.substring(originalName.lastIndexOf('.'));
            String saveFileName = getUuid() + ext;

            // 설정한 경로에 파일저장
            File serverFullName = new File(path + File.separator + saveFileName);

            mfile.transferTo(serverFullName);
            System.out.println("serverFullName");

            Map file = new HashMap();
            file.put("originalName", originalName);// 원본파일명
            file.put("saveFileName", saveFileName);// 저장된파일명
            file.put("serverFullName", serverFullName);// 서버에 저장된 전체경로 및 파일명

            resultList.add(file);

            ThemeParkDTO dto = new ThemeParkDTO();

            affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).applyTp(m_id, tp_name, tp_phone,
                  originalName, saveFileName, tp_addr1, tp_content, tp_category, tp_parkregi, p_num);

            int ticketaffected = 0;
            if (affected == 1) {

               dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectTp_idx(tp_name);
               System.out.println("18181881818" + dto.getTp_idx());

               if (dto.getTp_idx() != 0) {

                  for (int i = 0; i < t_price.length; i++) {
                     ticketaffected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
                           .ticketaffected(dto.getTp_idx(), t_name[i], t_price[i]);
                  }
               }

            }

            System.out.println("fileName=" + fileName);
            System.out.println("originalName=" + originalName);
            System.out.println("serverFullName=" + serverFullName);
            System.out.println("affected문의=" + affected);
            returnObj.put("files", resultList);
         }

      }
      model.addAttribute("returnObj", returnObj);

      return "redirect:/parkmoa/index.do?authority=" + authority;
   }

   public static String getUuid() {
      String uuid = UUID.randomUUID().toString();
      uuid = uuid.replaceAll("-", "");
      System.out.println("생성된 UUID:" + uuid);
      return uuid;
   }

   // 회원가입정책
   @RequestMapping("/parkmoa/member/policy.do")
   public ModelAndView policy(Model model, HttpServletRequest req) {

      ModelAndView mv = new ModelAndView();

      mv.setViewName("parkmoa/member/policy");
      return mv;
   }

   // 아이디/비밀번호찾기 화면
   @RequestMapping("/parkmoa/member/findId.do")
   public ModelAndView findId() {

      ModelAndView mv = new ModelAndView();

      mv.setViewName("parkmoa/member/findId");

      return mv;
   }

   // 아이디 찾기 실행
   @RequestMapping("/parkmoa/member/findIdAction.do")
   @ResponseBody
   public Map<String, Object> findIdAction(ParkmoaMemberDTO parkmoaMemberDTO, HttpServletRequest req) {

      String m_id = "";

      System.out.println(parkmoaMemberDTO.getM_name() + "  " + parkmoaMemberDTO.getM_mobile());

      Map<String, Object> map = new HashMap<String, Object>();

      m_id = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).findIdAction(parkmoaMemberDTO);

      System.out.println("불러온 id값:" + m_id);

      if (m_id != null) {
         System.out.println("아이디 찾기 진입");
         map.put("result", "1");
         map.put("m_id", "찾으시는 아이디는 <Strong>" + m_id + "</Strong> 입니다.");

      } else {
         System.out.println("아이디 못찾음");
         map.put("result", "0");
         map.put("m_id", "찾으시는 아이디가 존재하지 않습니다.");

      }

      return map;
   }

   // 임시패스워드 발송
   @RequestMapping("/parkmoa/member/findPwAction.do")
   @ResponseBody
   public Map<String, Object> findPwAction(ParkmoaMemberDTO parkmoaMemberDTO, HttpServletRequest req) {

      System.out.println(parkmoaMemberDTO.getM_id() + "  " + parkmoaMemberDTO.getM_email());
      String e_mail = "";

      Map<String, Object> map = new HashMap<String, Object>();
      // 아이디 이메일 일치여부 확인
      e_mail = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).findPwAction(parkmoaMemberDTO);

      // 일치되는 아이디 있으면 UUID 랜덤 인증코드 생성.
      if (e_mail != null) {

         /* int ran =new Random().nextInt(100000) +10000; */

         String password = UUID.randomUUID().toString();

         /* String password = String.valueOf(ran); */
         System.out.println("생성된 임시 비번:" + password);
         // 생성된 인증코드를 mapper에 집어넣어 DB데이터상의 PW변경.
         parkmoaMemberDTO.setM_pw(password);
         sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).findPwAction2(parkmoaMemberDTO);

         // 임의 발급된 임시비밀번호 이메일 발송
         try {

            String subject = "[PARKMOA!] 비밀번호 찾기 인증코드 안내";
            String msg = "";
            msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
            msg += "<h3 style='color: blue;'>비밀번호 찾기 인증코드입니다.</h3>";
            msg += "<div style='font-size: 130%'>";
            msg += "임시코드로 로그인페이지에서 <strong>";
            msg += password
                  + "</strong>로 <strong><a href='http://localhost:8080/project3rd/parkmoa/member/login.do'>로그인</a></strong>하여 비밀번호를 변경해주시기 바랍니다.</div><br/>";
            MailUtil.sendMail(e_mail, subject, msg);
         } catch (Exception e) {
            e.printStackTrace();
         }
         System.out.println("임시코드 생성후 발송");
         map.put("result", "1");
         map.put("msg", "가입하신 이메일로 <strong style='font-size: 130%'>임시 비밀번호</strong>를 전송하였습니다.");

      }

      else {
         System.out.println("찾는 이메일 주소 없음");
         map.put("result", "0");
         map.put("msg", "아이디와 이메일번호가 일치하지 않습니다.");
      }

      return map;
   }

   // 아이디 중복체크
   @RequestMapping("/parkmoa/member/checkId.do")
   @ResponseBody
   public Map<String, Object> checkId(HttpServletRequest req) {

      String id = req.getParameter("id");
      int count = 0;

      Map<String, Object> map = new HashMap<String, Object>();

      count = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).checkId(id);

      if (count == 0) {
         map.put("result", count);
         map.put("msg", "사용 가능한 아이디 입니다.");

      } else {
         map.put("result", count);
         map.put("msg", "중복된 아이디 입니다.");
      }

      return map;
   }

   // 회원가입폼
   @RequestMapping("/parkmoa/member/regist.do")
   public ModelAndView regist(@RequestParam("authority") String authority, HttpServletRequest req) {

      System.out.println("전달되는 authority값:" + authority);
      String m_name = req.getParameter("m_name");
      String m_email = req.getParameter("m_email");

      ModelAndView mv = new ModelAndView();
      mv.addObject("m_name", m_name);
      mv.addObject("m_email", m_email);
      mv.addObject("authority", authority);
      mv.setViewName("parkmoa/member/regist");

      return mv;
   }

   // 회원가입 처리
   @RequestMapping("/parkmoa/member/registAction.do")
   public void registAction(ParkmoaMemberDTO parkmoaMemberDTO, HttpServletRequest req, HttpServletResponse response)
         throws Exception {

      String grade = req.getParameter("authority");

      System.out.println("넘어오는 아이디값 체크:" + parkmoaMemberDTO.getM_id());

      int temp = 0;

      // 일반회원 가입처리
      if (grade.equalsIgnoreCase("member")) {
         temp = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).registAction(parkmoaMemberDTO);
      }
      // 기업회원 가입처리
      if (grade.equalsIgnoreCase("company")) {
         temp = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).registAction1(parkmoaMemberDTO);
      }
      System.out.println("temp값:" + temp);

      if (temp == 1) {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         out.println("<script>alert('회원가입이 완료 되었습니다'); location.href='/project3rd/parkmoa/index.do';</script>");
         out.flush();
      }

      // return "redirect:/parkmoa/index.do";
   }

   // 테마파크 리스트게시판(갤러리형)
   @RequestMapping("parkmoa/board/list.do")
   public String list(Model model, HttpServletRequest req) {

      String tp_category = req.getParameter("tp_category");
      String authority = req.getParameter("authority");
      System.out.println("tp_category" + tp_category);
      String addQueryString = "";
      String searchColumn = req.getParameter("searchColumn");
      String searchWord = req.getParameter("searchWord");
      System.out.println("searchColum=" + searchColumn);
      System.out.println("searchWord=" + searchWord);
      int totalRecordCount = 0;

      if (searchWord != null) {
         addQueryString = "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";

      }

      totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).getTotalCount(tp_category,
            searchColumn, searchWord);
      System.out.println("갤러리토털레코드카운트:" + totalRecordCount);

      // 페이지 처리를 위한 설정값
      int pageSize = 2;
      int blockPage = 2;

      // 전체페이지수계산하기
      int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);
      System.out.println("갤러리토털페이지:" + totalPage);

      // 시작 및 끝 rownum구하기
      int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
      int start = (nowPage - 1) * pageSize + 1;
      int end = nowPage * pageSize;

      ArrayList<ParkmoaBoardDTO> lists = null;
      ArrayList<ThemeParkDTO> lists1 = null;

      lists1 = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).gallerylist(tp_category, searchColumn,
            searchWord);

      lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectboard();

      model.addAttribute("lists", lists);
      model.addAttribute("lists1", lists1);
      model.addAttribute("nowPage", nowPage);
      model.addAttribute("tp_category", tp_category);
      model.addAttribute("authority", authority);

      return "parkmoa/board/list";
   }

   // 테마파크 리스트 상세보기(갤러리형)
   @RequestMapping("parkmoa/board/listView.do")
   public ModelAndView listView(Model model, HttpServletRequest req) {

      HttpSession session = req.getSession();
      try {
         String m_id = session.getAttribute("m_id").toString();
         model.addAttribute("m_id", m_id);

      } catch (Exception e) {
         // TODO: handle exception
      }

      String ave = req.getParameter("ave");
      System.out.println("ave" + ave);

      String authority = req.getParameter("authority");
      session.setAttribute("authority", authority);
      System.out.println("autorty:" + authority);
      model.addAttribute("authority", authority);

      int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
      String tp_category = req.getParameter("tp_category");

      System.out.println("파크모아상세보기tp_idx=" + tp_idx);
      System.out.println("파크모아상세보기tp_category=" + tp_category);

      ThemeParkDTO dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).listSelect(tp_idx);

      ArrayList<TicketsDTO> lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).ticketList(tp_idx);
      int visitcount = 0;
      visitcount = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).updatevisitcount(tp_idx);

      model.addAttribute("dto", dto);
      model.addAttribute("lists", lists);
      model.addAttribute("tp_category", tp_category);
      model.addAttribute("tp_idx", tp_idx);

      ModelAndView mv = new ModelAndView();

      mv.setViewName("parkmoa/board/listView");

      return mv;
   }

   // 사이트 소개
   @RequestMapping("parkmoa/about.do")
   public ModelAndView about(HttpServletRequest req) {

      ModelAndView mv = new ModelAndView();

      String authority = req.getParameter("authority");

      System.out.println("넘어오는 authority값:" + authority);

      mv.setViewName("parkmoa/about");
      mv.addObject("authority", authority);

      return mv;
   }

   // 목록형 게시판 List
   @RequestMapping("parkmoa/board/infoevent.do")
   public String infoevent(Model model, HttpServletRequest req, HttpSession session) {

      String b_flag = req.getParameter("b_flag");
      String authority = req.getParameter("authority");

      String addQueryString = "";
      String searchColumn = req.getParameter("searchColumn");
      String searchWord = req.getParameter("searchWord");
      System.out.println("서치컬럼" + searchColumn);

      // 모든게시판들 안에 파라미터값 잘보면서 수정하시길.
      int totalRecordCount = 0;

      if (searchWord != null) {
         addQueryString = "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";

      }

      if (b_flag.equalsIgnoreCase("event") || b_flag.equalsIgnoreCase("faq")) {
         totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).getTotalCount1(b_flag,
               searchColumn, searchWord);
         System.out.println("앙 토털레코드카운터1 " + totalRecordCount);
      }

      // 페이지 처리를 위한 설정값
      int pageSize = 5;
      int blockPage = 5;

      // 전체페이지수계산하기
      int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);

      // 시작 및 끝 rownum구하기
      int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
      int start = (nowPage - 1) * pageSize + 1;
      int end = nowPage * pageSize;

      ArrayList<ParkmoaBoardDTO> lists = null;

      if (b_flag.equalsIgnoreCase("event") || b_flag.equalsIgnoreCase("faq")) {
         lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).listPage(b_flag, start, end, searchColumn,
               searchWord);

         // 줄바꿈처리
         for (ParkmoaBoardDTO dto : lists) {
            String temp = dto.getB_content().replace("\r\n", "<br/>");
            dto.setB_content(temp);
         }

         model.addAttribute("lists", lists);
         model.addAttribute("totalRecordCount", totalRecordCount);
         model.addAttribute("nowPage", nowPage);
         model.addAttribute("pageSize", pageSize);
      }

      // 페이지 처리를 위한 처리부분
      String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage, req.getContextPath()
            + "/parkmoa/board/infoevent.do?b_flag=" + b_flag + "&authority=" + authority + "&" + addQueryString);

      model.addAttribute("pagingImg", pagingImg);
      model.addAttribute("authority", authority);
      model.addAttribute("b_flag", b_flag);

      return "parkmoa/board/infoevent";
   }

   // 목록형 게시판 상세보기
   @RequestMapping("/parkmoa/board/infoeventView.do")
   public String infoeventView(Model model, HttpServletRequest req) {

      int b_idx = Integer.parseInt(req.getParameter("b_idx"));
      String authority = req.getParameter("authority");
      String b_flag = req.getParameter("b_flag");
      int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
            : Integer.parseInt(req.getParameter("nowPage"));

      String addQueryString = "";
      String searchColumn = req.getParameter("searchColumn");
      String searchWord = req.getParameter("searchWord");

      if (searchWord != null) {
         addQueryString = "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";
      }
      System.out.println("파크모아상세보기idx=" + b_idx);
      System.out.println("파크모아상세보기b_flag=" + b_flag);
      System.out.println("파크모아상세보기nowPage = " + nowPage);

      ParkmoaBoardDTO dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).boardSelect1(b_idx);

      model.addAttribute("dto", dto);
      model.addAttribute("b_flag", b_flag);
      model.addAttribute("nowPage", nowPage);
      model.addAttribute("b_idx", b_idx);
      model.addAttribute("authority", authority);

      return "parkmoa/board/infoeventView";
   }

   // 파일다운로드
   @RequestMapping("/parkmoa/fileDownload.do")
   public ModelAndView download(HttpServletRequest req, HttpServletResponse resp) throws Exception {

      String fileName = req.getParameter("fileName");
      String oriFileName = req.getParameter("oriFileName");

      String saveDirectory = req.getSession().getServletContext().getRealPath("/resources/upload");

      File downloadFile = new File(saveDirectory + "/" + fileName);

      if (!downloadFile.canRead()) {
         throw new Exception("파일을 찾을 수 없습니다.");
      }
      ModelAndView mv = new ModelAndView();

      mv.setViewName("fileDownloadView");
      mv.addObject("downloadFile", downloadFile);
      mv.addObject("oriFileName", oriFileName);
      return mv;
   }

   // 문의게시판 답글
   @RequestMapping("/parkmoa/board/BoardReply.do")
   public String modifyAction(Model model, HttpServletRequest req) {
      int b_idx = Integer.parseInt(req.getParameter("b_idx"));
      int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
            : Integer.parseInt(req.getParameter("nowPage"));
      String b_flag = req.getParameter("b_flag");
      String authority = req.getParameter("authority");

      System.out.println("b_idx= " + b_idx);
      System.out.println("nowPage= " + nowPage);
      System.out.println("b_flag=" + b_flag);

      ParkmoaBoardDTO parkmoaBoardDTO;

      parkmoaBoardDTO = sqlSession.getMapper(ParkmoaImpl.class).boardSelect(b_idx);

      parkmoaBoardDTO.setB_title(parkmoaBoardDTO.getB_title());
      parkmoaBoardDTO.setB_content("");

      model.addAttribute("b_idx", b_idx);
      model.addAttribute("authority", authority);
      model.addAttribute("nowPage", nowPage);
      model.addAttribute("b_flag", b_flag);
      model.addAttribute("dto", parkmoaBoardDTO);

      return "/parkmoa/board/BoardReply";
   }

   @RequestMapping("/parkmoa/board/ListReplyAction.do")
   public String ListReplyAction(Model model, HttpServletRequest req, ParkmoaBoardDTO parkmoaBoardDTO) {

      int replyprevupdate = 0;
      int replyaffected = 0;
      int replyupdated = 0;
      int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
            : Integer.parseInt(req.getParameter("nowPage"));
      String b_flag = req.getParameter("b_flag");
      String authority = req.getParameter("authority");
      parkmoaBoardDTO.setB_title("<img src='/project3rd/resources/imgimg.PNG';/>" + parkmoaBoardDTO.getB_title());

      replyaffected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).boardreply(parkmoaBoardDTO);
      if (replyaffected != 0) {
         replyprevupdate = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
               .replyprevupdate(parkmoaBoardDTO);
         replyupdated = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).alertupdate(parkmoaBoardDTO);
         System.out.println("replyupdated=" + replyupdated);
      }

      return "redirect:/parkmoa/board/infoevent.do?b_flag=" + b_flag + "&authority=" + authority + "&nowPage="
            + nowPage;
   }

   @RequestMapping("/parkmoa/KakaoMap.do")
   public ModelAndView Map() {
      ModelAndView mv = new ModelAndView();
      mv.setViewName("parkmoa/KakaoMap");

      return mv;
   }

   @RequestMapping("/parkmoa/KakaoMap1.do")
   public ModelAndView Map1() {
      ModelAndView mv = new ModelAndView();
      mv.setViewName("parkmoa/KakaoMap1");

      return mv;
   }

   @RequestMapping("/parkmoa/KakaoMap2.do")
   public ModelAndView Map2() {
      ModelAndView mv = new ModelAndView();
      mv.setViewName("parkmoa/KakaoMap2");

      return mv;
   }

   @RequestMapping("/parkmoa/KakaoMap3.do")
   public ModelAndView Map3() {
      ModelAndView mv = new ModelAndView();
      mv.setViewName("parkmoa/KakaoMap3");

      return mv;
   }

   @RequestMapping("/parkmoa/KakaoMap4.do")
   public ModelAndView Map4() {
      ModelAndView mv = new ModelAndView();
      mv.setViewName("parkmoa/KakaoMap4");

      return mv;
   }

   @RequestMapping(value = "/oauth") // 카카오 api 명령어 ouath. 특별한 이유없이 바꾸지 말것.
   public String kakaologin(@RequestParam("code") String code, HttpSession session, Model model) {
      System.out.println("code : " + code);

      String access_Token = kakao.getAccessToken(code);
      HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
      System.out.println("controller access_token : " + access_Token);

      ParkmoaMemberDTO dto = null;
      String temp = (String) userInfo.get("email");
      String nickname = (String) userInfo.get("nickname");

      int count = 0;

      count = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).emailcheck(temp);

      if (count == 1) {
         System.out.println("일치하는 이메일 찾음");
         dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).emailcheck2(temp);
         model.addAttribute("authority", dto.getAuthority());
         session.setAttribute("m_id", dto.getM_id());
         return "redirect:/parkmoa/index.do";

      } else {
         System.out.println("일치하는 이메일 없음");
         // model.addAttribute("m_email",temp);
         String kakao_id = temp.split("@")[0];
         session.setAttribute("m_id", kakao_id);
         session.setAttribute("m_email", temp);
         session.setAttribute("m_name", nickname);
         return "redirect:parkmoa/member/policy.do";
      }

   }

   // 네아로 콜백
   @RequestMapping(value = "parkmoa/member/callback")
   public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
         throws IOException {
      System.out.println("여기는 callback");
      OAuth2AccessToken oauthToken;
      oauthToken = naverLoginBO.getAccessToken(session, code, state);
      // 로그인 사용자 정보를 읽어온다.
      apiResult = naverLoginBO.getUserProfile(oauthToken);
      model.addAttribute("result", apiResult);

      /* 네이버 로그인 성공 페이지 View 호출 */
      return "parkmoa/member/naverSuccess";
   }

   // 네이버로그인 시 회원
   @RequestMapping("/parkmoa/member/naver.do")
   public String naverLoginrs(HttpServletRequest req, HttpSession session, Model model) {

      String m_name = req.getParameter("m_name");
      String m_email = req.getParameter("m_email");
      System.out.println("m_name" + m_name);
      System.out.println("m_email" + m_email);

      // 네아로 로그인으로 진입한 경우
      int affected = 0;

      affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectMember(m_email);

      // 일치하는 아이디 있는경우(기존회원)
      if (affected == 1) {

         ParkmoaMemberDTO dto;

         dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectMember1(m_email);

         String authority = dto.getAuthority();
         String m_id = dto.getM_id();

         // 세션영역에 아이디저장해서 메인페이지로
         session.setAttribute("m_id", m_id);
         model.addAttribute("authority", authority);
         return "redirect:../index.do";

      } else {
         // 이름과 이메일정보 회원약관페이지로(회원가입시키기)
         String m_id = m_email.split("@")[0] + "nv";
         System.out.println(m_id);
         session.setAttribute("m_id", m_id);
         session.setAttribute("m_name", m_name);
         session.setAttribute("m_email", m_email);
         return "redirect:./policy.do";
      }

   }

   // 리뷰게시판작성ajax
   @RequestMapping("/parkmoa/board/writeReply.do")
   @ResponseBody
   public String ajax_writeReply(HttpServletRequest req) throws Exception {

      int affected = 0;
      HttpSession session = req.getSession();
      String m_id = session.getAttribute("m_id").toString();
      String b_content = req.getParameter("b_content");
      String b_title = req.getParameter("b_title");
      int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
      int b_rating = Integer.parseInt(req.getParameter("b_rating"));

      affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).listwrite2(m_id, b_title, b_content,
            tp_idx, b_rating);
      System.out.println("댓글작성됨" + affected);

      return "success";

   }

   // 리뷰게시판리스트ajax
   @RequestMapping(value = "/parkmoa/board/commentList.do", produces = "application/json; charset=utf8")
   @ResponseBody
   public ResponseEntity ajax_CommentList(@ModelAttribute("ParkMoaBoardDTO") ParkmoaBoardDTO parkmoaBoardDTO,
         HttpServletRequest req) throws Exception {

      HttpHeaders responseHeaders = new HttpHeaders();
      ArrayList<HashMap> hmlist = new ArrayList<HashMap>();

      int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
      System.out.println("여기찍히는 tp_idx:" + tp_idx);
      String m_id = req.getParameter("m_id");
      System.out.println("여기 찍히는 m_id" + m_id);

      int pageSize = 5;
      // 해당 테마파크의 리뷰
      List<ParkmoaBoardDTO> commentVO = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
            .selectComment(tp_idx);

      String tp_category = req.getParameter("tp_category");

      System.out.println("commentVO.size()" + commentVO.size());
      if (commentVO.size() > 0) {
         for (int i = 0; i < commentVO.size(); i++) {

            HashMap hm = new HashMap();
            hm.put("b_bgroup", commentVO.get(i).getB_bgroup());
            hm.put("b_content", commentVO.get(i).getB_content());
            hm.put("m_id", commentVO.get(i).getM_id());
            hm.put("b_rating", commentVO.get(i).getB_rating());
            hm.put("b_regidate", commentVO.get(i).getB_regidate());
            hmlist.add(hm);

         }
      }
      JSONArray json = new JSONArray(hmlist);
      return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
   }

   // 총 합계금액 계산
   @RequestMapping("/parkmoa/pay/total_price.do")
   @ResponseBody
   public Map<String, Object> total_price(@RequestParam(value = "array") List<String> array) {

      Map<String, Object> map = new HashMap<String, Object>();
      int total_price = 0;
      for (String num : array) {

         total_price += Integer.parseInt(num);
      }
      map.put("total_price", total_price);
      return map;
   }

   // 장바구니 담기
   @RequestMapping("/parkmoa/pay/cartAction.do")
   public String cartAction(HttpServletRequest req, HttpSession session, Model model) {

      ModelAndView mv = new ModelAndView();
      String m_id = session.getAttribute("m_id").toString();
      // tp_idx로 등록된 티켓 종류 select
      int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
      String tp_name = req.getParameter("tp_name");

      ArrayList<TicketsDTO> lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).ticketList(tp_idx);

      for (TicketsDTO dto : lists) {
         if (req.getParameter("price" + dto.getT_idx()) != null) {
            String r_usedate = req.getParameter("confirmday");
            int r_cnt = Integer.parseInt(req.getParameter("price" + dto.getT_idx()));
            int affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).insertRes(m_id, dto.getT_idx(),
                  r_cnt, dto.getT_price(), dto.getT_name(), tp_name, r_usedate, tp_idx);
         }
      }

      ArrayList<ReservationDTO> lists2 = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
            .reservationList(m_id);

      model.addAttribute("lists", lists);

      String authority = req.getParameter("authority");
      model.addAttribute("authority", authority);

      // 장바구니 리스트로 이동
      return "redirect:/parkmoa/pay/cart.do";
   }

   // 장바구니 리스트 보기
   @RequestMapping("/parkmoa/pay/cart.do")
   public String cart(Model model, HttpServletRequest req, HttpSession session) throws ParseException {

      String authority = req.getParameter("authority");
      String m_id = session.getAttribute("m_id").toString();

      System.out.println("authority" + authority);

      ArrayList<ReservationDTO> lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
            .reservationList(m_id);

      for (ReservationDTO dto : lists) {
         dto.setR_useregi(dto.getR_useregi().substring(0, 10));
      }
      SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
      SimpleDateFormat min = new SimpleDateFormat("yyyy/MM/dd", Locale.KOREA);
      Date currentTime = new Date();
      Date currentTime1 = new Date();
      String current = f.format(currentTime);
      String current1 = f.format(currentTime1);
      Date today = f.parse(current);// 오늘날짜
      Date today1 = f.parse(current1);
      String r_regist = null;
      System.out.println("today:" + today);

      for (ReservationDTO dto : lists) {

         String r_regi1 = dto.getR_regi();// 장바구니 등록날짜(Date)
         System.out.println("r_regi1" + r_regi1);
         String r_useregi1 = dto.getR_useregi().substring(0, 10);// 이용날짜
         System.out.println("r_useregi1" + r_useregi1);
         Date r_useregi44 = f.parse(r_useregi1);

         System.out.println("이용날짜" + r_useregi1);
         int result = today.compareTo(r_useregi44);

         System.out.println("장바구니1분후시간" + r_regist);
         System.out.println("999::" + today1.getTime());

         if (result == 1) {// 이용일날짜가 오늘날짜(sysdate)보다 적은경우 삭제
            System.out.println(result);

            int daffected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
                  .deletereservationlist(r_useregi1);
            System.out.println("qwdqwdqwd" + daffected);
         }
      }

      model.addAttribute("lists", lists);
      model.addAttribute("authority", authority);

      return "parkmoa/pay/cart";
   }

   // 장바구니 삭제
   @RequestMapping("/parkmoa/pay/cartDelete.do")
   @ResponseBody
   public Map<String, String> deleteCart(@RequestParam("chk") String[] chk, HttpServletRequest req) throws Exception {

      Map<String, String> map = new HashMap<String, String>();
      int param = 0;
      for (String schk : chk) {
         param = Integer.parseInt(schk);
         int deleteaffected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).cartDelete(param);
         System.out.println("장바구니에서 삭제" + deleteaffected);
      }
      map.put("message", "삭제성공");
      return map;
   }

   // 리뷰게시판 펼쳐보기
   @RequestMapping(value = "/parkmoa/board/ReviewAll.do", produces = "application/text; charset=utf8")
   @ResponseBody
   public String ReviewAll(ThemeParkDTO themeParkDTO, ParkmoaBoardDTO parkmoaBoardDTO, HttpServletRequest req) {

      int tp_idx = themeParkDTO.getTp_idx();

      List<ParkmoaBoardDTO> commentVO = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
            .selectComment(tp_idx);

      String html = "";

      int startList = 7;
      int endList = 0;
      int totalPage = commentVO.size();
      int pageSize = totalPage / 5;

      for (int i = 7; i < commentVO.size(); i++) {
         String star = "";
         if (commentVO.get(i).getB_rating() == 1) {
            star = "★";
         }
         if (commentVO.get(i).getB_rating() == 2) {
            star = "★★";
         }
         if (commentVO.get(i).getB_rating() == 3) {
            star = "★★★";
         }
         if (commentVO.get(i).getB_rating() == 4) {
            star = "★★★★";
         }
         if (commentVO.get(i).getB_rating() == 5) {
            star = "★★★★★";
         }

         html += "<div>";
         html += "<div>";
         html += "<table class='table'>";
         html += "<h6><strong>" + commentVO.get(i).getM_id() + "(" + commentVO.get(i).getB_regidate() + ")(" + star
               + ")</strong></h6>";
         html += commentVO.get(i).getB_content() + "<tr><td></td></tr>";
         html += "</table></div>";
         html += "</div>";
      }

      return html;

   }

   // 리뷰수정모달창에 정보꽂아주기
   @RequestMapping("/parkmoa/member/reviewEdit.do")
   @ResponseBody
   public ParkmoaBoardDTO reviewEdit(HttpServletRequest req, Model model, ParkmoaBoardDTO parkmoaBoardDTO) {

      int b_idx = parkmoaBoardDTO.getB_idx();
      System.out.println("여기b_idx=" + b_idx);

      ParkmoaBoardDTO dto = null;
      dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).reviewselect(b_idx);

      System.out.println(dto.getM_id());
      System.out.println(dto.getB_content());

      return dto;

   }

   // 마이페이지리뷰수정
   @RequestMapping("/parkmoa/member/reviewEditAction.do")
   public String reviewEditAction(HttpServletRequest req, Model model, ParkmoaBoardDTO parkmoaBoardDTO) {

      int b_idx = Integer.parseInt(req.getParameter("b_idx"));
      String b_content = req.getParameter("b_content");
      int b_rating = Integer.parseInt(req.getParameter("b_rating"));

      int affected = 0;

      affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).reviewEdit(b_content, b_rating, b_idx);

      return "redirect:myPageReview.do";

   }

   // 마이페이지리뷰삭제
   @RequestMapping("/parkmoa/member/reviewDelete.do")
   public String reviewDelete(HttpServletRequest req, ParkmoaBoardDTO parkmoaBoardDTO, Model model,
         HttpServletResponse resp) throws Exception {
      String authority = req.getParameter("authority");
      String m_id = req.getParameter("m_id");
      int b_idx = Integer.parseInt(req.getParameter("b_idx"));

      int affected = 0;

      affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).reviewDelete(b_idx);

      model.addAttribute("msg", "리뷰가 삭제되었습니다.");
      model.addAttribute("affected", affected);
      model.addAttribute("url", "./myPageReview.do");
      model.addAttribute("authority", authority);

      return "redirect:myPageReview.do";
   }

   // 테마파크 이용권을 등록폼으로 뿌려주기
   @RequestMapping("/parkmoa/member/tkaction.do")
   @ResponseBody
   public Map<String, Object> tkaction(Model model, HttpServletRequest req) {

      Map<String, Object> map = new HashMap<String, Object>();

      String authority = req.getParameter("modalauthority");
      System.out.println("authority==" + authority);

      String[] t_name = req.getParameterValues("t_names");

      String[] t_price = req.getParameterValues("t_prices");

      map.put("t_name", t_name);
      map.put("t_price", t_price);
      return map;

   }

   // 결제창으로 이동
   @RequestMapping("/parkmoa/pay/payment.do")
   public ModelAndView payment(HttpServletRequest req, HttpSession session) {
      ModelAndView mv = new ModelAndView();

      String m_id = session.getAttribute("m_id").toString();
      String[] chk = req.getParameterValues("rechk");
      String totalPrice = req.getParameter("total_Price");

      int r_idx = 0;
      int r_cnt = 0;

      // 장바구니 리스트 업데이트
      for (String idx : chk) {
         r_idx = Integer.parseInt(idx);
         r_cnt = Integer.parseInt(req.getParameter("cnt" + r_idx));
         int affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).resUpdate(r_cnt, r_idx);
      }

      ArrayList<ReservationDTO> lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
            .reservationList(m_id);

      // list 분류용 map, list선언
      ArrayList<ReservationDTO> payList = new ArrayList<ReservationDTO>();

      ArrayList<Integer> p_idxList = new ArrayList<Integer>();
      ArrayList<ParkinginfoDTO> p_infoList = new ArrayList<ParkinginfoDTO>();

      Map<String, ArrayList<ReservationDTO>> map = new HashMap<String, ArrayList<ReservationDTO>>();

      int index = 0;

      for (int i = 0; i < lists.size(); i++) {

         ReservationDTO dto = lists.get(i);

         // 0번째면 분류용 리스트에 저장
         if (i == 0) {
            payList.add(dto);
         } else {

            ReservationDTO dto1 = lists.get(i - 1);
            // tp_idx, useregi가 일치할경우 list에 계속 저장
            if (dto.getTp_idx() == dto1.getTp_idx()
                  && dto.getR_useregi().toString().equalsIgnoreCase(dto1.getR_useregi().toString())) {
               payList.add(dto);
            } else {
               // tp_idx, useregi중 하나가 다를경우 map에 저장
               map.put(Integer.toString(index), payList);

               // 해당 키값에서 쓰일 주차장idx를 조회해서 리스트에 저장
               p_idxList.add(
                     sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).p_idxSelect(dto1.getTp_idx()));

               // 키값 +1
               index++;

               // list 초기화 후 저장
               payList = new ArrayList<ReservationDTO>();
               payList.add(dto);

            }
         }
      }

      // 마지막 리스트를 맵에 저장
      map.put(Integer.toString(index), payList);

      p_idxList.add(sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
            .p_idxSelect(payList.get(payList.size() - 1).getTp_idx()));

      // 주차장정보 가져오기
      for (int tp_idx : p_idxList) {

         ParkinginfoDTO dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).p_infoSelect(tp_idx);
         dto.setP_content(dto.getP_code().split(", "));

         p_infoList.add(dto);
      }

      // 결제테이블에서 레코드 불러오기
      ArrayList<PaymentDTO> paymentList = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).payListSelect();
      ParkmoaMemberDTO dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).MemberView(m_id);

      // tp_idx만큼 주자정보가져오기
      String[] tp_idxs = req.getParameterValues("tp_idxconfirm");
      ArrayList<ThemeParkDTO> tp_parkregis = new ArrayList<ThemeParkDTO>();

      for (String tp_idx : tp_idxs) {
         ThemeParkDTO themeParkDTO = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
               .tp_parkregi(Integer.parseInt(tp_idx));
         tp_parkregis.add(themeParkDTO);
      }
      // Model에 저장
      mv.addObject("tp_parkregis", tp_parkregis);

      String authority = req.getParameter("authority");
      mv.addObject("dto", dto);
      mv.addObject("authority", authority);
      mv.addObject("map", map);
      mv.addObject("p_infoList", p_infoList);
      mv.addObject("paymentList", paymentList);
      mv.addObject("totalPrice", totalPrice);
      mv.setViewName("parkmoa/pay/payment");

      return mv;
   }

   // 결제하기
   @RequestMapping("/parkmoa/pay/paymentAction.do")
   public ModelAndView paymentAction(HttpServletRequest req, HttpSession session) {
      ModelAndView mv = new ModelAndView();

      String m_id = session.getAttribute("m_id").toString();
      String authority = req.getParameter("authority");
      
      System.out.println("authorty=" + authority);

      // 폼값 받기
      String[] listSize = req.getParameterValues("listSize"); 
      String tp_name = "";
      String r_useregi = "";
      int p_num = 0;
      int tp_idx = 0;
      int totalPrice = Integer.parseInt(req.getParameter("total_Price"));
      int pay_group = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectPayGroup();
      
      int after_Membership = Integer.parseInt(req.getParameter("after_Membership"));
      int mileage = Integer.parseInt(req.getParameter("mileage"));

      int m_membership = after_Membership+mileage;
      
      String m_mobile = req.getParameter("m_mobile");
      String m_email = req.getParameter("m_email");

      System.out.println(pay_group);

      for (int i = 0; i < listSize.length; i++) {
         String t_name = "";
         String r_cnt = "";

         tp_idx = Integer.parseInt(req.getParameter("tp_idx" + i));
         tp_name = req.getParameter("tp_name" + i);
         r_useregi = req.getParameter("r_useregi" + i);
         if (req.getParameter("p_num" + i).equalsIgnoreCase("")) {
            p_num = 0;
         } else {
            p_num = Integer.parseInt(req.getParameter("p_num" + i));
         }

         String[] t_nameArr = req.getParameterValues("t_name" + i);
         String[] r_cntArr = req.getParameterValues("r_cnt" + i);

         for (int j = 0; j < t_nameArr.length; j++) {

            if (j == 0) {
               t_name += t_nameArr[j] + "*" + r_cntArr[j];
            } else {
               t_name += "," + t_nameArr[j] + "*" + r_cntArr[j];
            }
         }

         // 그룹화시켜서 DB에 insert
         int affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).paymentInsert(m_id, tp_idx,
               tp_name, t_name, totalPrice, r_useregi, p_num, pay_group, m_mobile, m_email);

         if (affected == 1) {
            int updatemembership = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
                  .updatemembership(m_membership, m_id);
            int delete = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).deleteResevation(m_id);
         }
      }
      // 결제내역으로 이동하기
      mv.addObject("authority", authority);
      mv.setViewName("redirect:/parkmoa/pay/paymentHistory.do");

      return mv;
   }

   // 결제내역 바로가기
   @RequestMapping("/parkmoa/pay/paymentHistory.do")
   public ModelAndView paymentHistory(HttpSession session) {

      ModelAndView mv = new ModelAndView();

      String m_id = session.getAttribute("m_id").toString();

      ArrayList<PaymentDTO> templists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).myPayList(m_id);
      // list 분류용 map, list선언
      ArrayList<PaymentDTO> lists = new ArrayList<PaymentDTO>();

      Map<String, ArrayList<PaymentDTO>> map = new HashMap<String, ArrayList<PaymentDTO>>();

      int index = 0;

      for (int i = 0; i < templists.size(); i++) {

         PaymentDTO dto = templists.get(i);

         // 0번째면 분류용 리스트에 저장
         if (i == 0) {
            lists.add(dto);
         } else {

            PaymentDTO dto1 = templists.get(i - 1);
            // tp_idx, useregi가 일치할경우 list에 계속 저장
            if (dto.getPay_group() == dto1.getPay_group()) {
               lists.add(dto);
            } else {
               // tp_idx, useregi중 하나가 다를경우 map에 저장
               map.put(Integer.toString(index), lists);

               // 키값 +1
               index++;

               // list 초기화 후 저장
               lists = new ArrayList<PaymentDTO>();
               lists.add(dto);

            }
         }
      }

      ParkmoaMemberDTO dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).MemberView(m_id);

      map.put(Integer.toString(index), lists);
      mv.addObject("dto", dto);
      mv.addObject("map", map);
      mv.setViewName("parkmoa/pay/paymentHistory");

      return mv;
   }

   // 상세보기에서 바로 결제페이지로
   @RequestMapping("/parkmoa/pay/paymentDirect.do")
   public ModelAndView paymentDirect(HttpServletRequest req, HttpSession session) throws ParseException {

      ModelAndView mv = new ModelAndView();
      String m_id = session.getAttribute("m_id").toString();

      // tp_idx로 등록된 티켓 종류 select
      int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
      String tp_name = req.getParameter("tp_name");
      String totalPrice = req.getParameter("totalPrice");

      ArrayList<TicketsDTO> lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).ticketList(tp_idx);
      ArrayList<ReservationDTO> lists2 = new ArrayList<ReservationDTO>();

      String r_useregi = req.getParameter("confirmday");

      for (TicketsDTO dto : lists) {
         if (req.getParameter("price" + dto.getT_idx()) != null) {

            ReservationDTO resDTO = new ReservationDTO();

            int r_cnt = Integer.parseInt(req.getParameter("price" + dto.getT_idx()));

            resDTO.setM_id(m_id);
            resDTO.setTp_name(tp_name);
            resDTO.setT_name(dto.getT_name());
            resDTO.setT_idx(dto.getT_idx());
            resDTO.setR_cnt(r_cnt);
            resDTO.setT_price(dto.getT_price());
            resDTO.setTp_idx(tp_idx);
            resDTO.setR_useregi(r_useregi);

            lists2.add(resDTO);
         }
      }
      Map<String, ArrayList<ReservationDTO>> map = new HashMap<String, ArrayList<ReservationDTO>>();
      map.put("0", lists2);

      int p_idx = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).p_idxSelect(tp_idx);
      ArrayList<ParkinginfoDTO> p_infoList = new ArrayList<ParkinginfoDTO>();

      // 주차장정보 가져오기
      ParkinginfoDTO parkingInfoDTO = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).p_infoSelect(p_idx);
      parkingInfoDTO.setP_content(parkingInfoDTO.getP_code().split(", "));
      p_infoList.add(parkingInfoDTO);

      // 결제테이블에서 레코드 불러오기
      ArrayList<PaymentDTO> paymentList = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).payListSelect();
      ParkmoaMemberDTO dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).MemberView(m_id);

      // tp_idx만큼 주자정보가져오기
      String[] tp_idxs = req.getParameterValues("tp_idxconfirm");
      ArrayList<ThemeParkDTO> tp_parkregis = new ArrayList<ThemeParkDTO>();

      for (String tp_idx2 : tp_idxs) {
         ThemeParkDTO themeParkDTO = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
               .tp_parkregi(Integer.parseInt(tp_idx2));
         tp_parkregis.add(themeParkDTO);
      }
      // Model에 저장
      mv.addObject("tp_parkregis", tp_parkregis);

      // Model에 저장
      String authority = req.getParameter("authority");
      mv.addObject("dto", dto);
      mv.addObject("authority", authority);
      mv.addObject("map", map);
      mv.addObject("p_infoList", p_infoList);
      mv.addObject("paymentList", paymentList);
      mv.addObject("totalPrice", totalPrice);
      mv.setViewName("parkmoa/pay/payment");
 
      return mv;
   }

   // ***********************안드로이드*******************************************
   // ***********************가즈아~~~~********************************************
   @RequestMapping("/parkmoa/androidLoginAction.do")
   @ResponseBody
   public Map<String, Object> memberLogin(HttpServletRequest req) {

      Map<String, Object> memberMap = new HashMap<String, Object>();

      String id = req.getParameter("m_id");
      String pw = req.getParameter("m_pw");
      System.out.println("아이디 파라미터 전달값:" + id);
      System.out.println("패스워드 파라미터 전달값:" + pw);
      int enabled = 0;
      ParkmoaMemberDTO dtotemp = new ParkmoaMemberDTO();

      String m_pw = sqlSession.getMapper(ParkmoamainImpl.class).login(id);
      System.out.println("찾은비번:" + m_pw);

      if (m_pw != null) {
         enabled = sqlSession.getMapper(ParkmoamainImpl.class).selectenabled(id);
         if (enabled == 1) {
            System.out.println("로그인성공");
            System.out.println("활성화 된 사용자 입니다.");
            dtotemp = sqlSession.getMapper(ParkmoamainImpl.class).androidDtoAction(id);
            memberMap.put("success", 1);
            memberMap.put("memberInfo", dtotemp);
         }

      } else {
         memberMap.put("success", 0);

      }
      return memberMap;
   }

   // 아이디 찾기 실행
   @RequestMapping("/parkmoa/AndroidfindIdAction.do")
   @ResponseBody
   public Map<String, Object> AndroidfindIdAction(ParkmoaMemberDTO parkmoaMemberDTO, HttpServletRequest req) {

      String m_id = "";

      System.out.println(parkmoaMemberDTO.getM_name() + "  " + parkmoaMemberDTO.getM_mobile());

      Map<String, Object> map = new HashMap<String, Object>();
      ParkmoaMemberDTO dtotemp = new ParkmoaMemberDTO();

      m_id = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).findIdAction(parkmoaMemberDTO);

      System.out.println("불러온 id값:" + m_id);

      if (m_id != null) {
         System.out.println("아이디 찾기 진입");
         dtotemp = sqlSession.getMapper(ParkmoamainImpl.class).androidDtoAction(m_id);
         map.put("success", 1);
         map.put("memberInfo", dtotemp);
         System.out.println("아이디는?" + dtotemp.getM_id());

      } else {
         System.out.println("아이디 못찾음");
         map.put("success", 0);

      }

      return map;
   }

   // 안드로이드 비번찾기. 웹과는 다르게 비번 그대로 발송.(임시코드 생성 X)
   @RequestMapping("/parkmoa/AndroidfindPwAction.do")
   @ResponseBody
   public Map<String, Object> androidfindPwAction(ParkmoaMemberDTO parkmoaMemberDTO, HttpServletRequest req) {
      String email = "";

      System.out.println(parkmoaMemberDTO.getM_id() + "  " + parkmoaMemberDTO.getM_email());
      Map<String, Object> map = new HashMap<String, Object>();

      ParkmoaMemberDTO dtotemp = new ParkmoaMemberDTO();
      /*
       * email =
       * sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).findPwAction(
       * parkmoaMemberDTO);
       */
      dtotemp = sqlSession.getMapper(ParkmoamainImpl.class).androidFindPwAction(parkmoaMemberDTO);
      if (dtotemp != null) {
         System.out.println("비밀번호 찾기 진입");
         map.put("success", 1);
         map.put("memberInfo", dtotemp);
         System.out.println(dtotemp.getM_pw());
      } else {
         System.out.println("비밀번호 못찾음");
         map.put("success", 0);

      }
      return map;

   }

   // 안드로이드 회원가입. 앱상 가입시는 일반 회원으로만 가입 처리.
   @RequestMapping("/parkmoa/AndroidMemberRegistAction.do")
   @ResponseBody
   public Map<String, Object> AndroidMemberRegistAction(ParkmoaMemberDTO parkmoaMemberDTO, HttpServletRequest req) {

      // 일반 회원으로만 가입 처리위한 authority 변수 선언.
      String grade = "member";
      String id = req.getParameter("m_id");

      System.out.println("넘어오는 아이디값 체크:" + parkmoaMemberDTO.getM_id());
      Map<String, Object> map = new HashMap<String, Object>();

      int temp = 0; // 중복체크용 확인 변수
      temp = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).checkId(id);

      if (temp == 0) {
         sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).registAction(parkmoaMemberDTO);
         System.out.println("회원가입 성공");
         map.put("success", 1);

      } else {
         System.out.println("회원가입 실패:");
         map.put("success", 0);

      }
      return map;

   }

   @RequestMapping("/parkmoa/androidPaymentList.do")
   @ResponseBody
   public ArrayList<PaymentDTO> boardList(HttpServletRequest req) {

      String id = req.getParameter("m_id");
      System.out.println("넘어오는 id값" + id);

      ArrayList<PaymentDTO> boardLists = sqlSession.getMapper(ParkmoamainImpl.class).PaymentList(id);
      System.out.println(boardLists.get(0).getM_id());
      System.out.println(boardLists.get(0).getP_num());
      System.out.println(boardLists.get(0).getPay_price());
      System.out.println(boardLists.get(0).getPay_regidate());
      System.out.println(boardLists.get(0).getR_useregi());
      System.out.println(boardLists.get(0).getT_name());
      System.out.println(boardLists.get(0).getPay_idx());
      System.out.println(boardLists.get(0).getPay_group());

      String sql = sqlSession.getConfiguration().getMappedStatement("PaymentList").getBoundSql("").getSql();

      System.out.println("sql=" + sql);

      return boardLists;
   }

   @RequestMapping("/parkmoa/androidPersonInfo.do")
   @ResponseBody
   public ArrayList<ParkmoaMemberDTO> PersonInfo(HttpServletRequest req) {

      String id = req.getParameter("m_id");
      System.out.println("넘어오는 id값" + id);

      ArrayList<ParkmoaMemberDTO> boardLists = sqlSession.getMapper(ParkmoamainImpl.class).PersonInfo(id);
      System.out.println(boardLists.get(0).getM_id());

      String sql = sqlSession.getConfiguration().getMappedStatement("PersonInfo").getBoundSql("").getSql();

      System.out.println("sql=" + sql);

      return boardLists;
   }

   @RequestMapping("/parkmoa/qrcode.do")
   @ResponseBody
   public Map<String, Object> QRcode(HttpServletRequest req) {

      String m_id = req.getParameter("m_id");
      int membership = Integer.parseInt((req.getParameter("membership")));
      System.out.println("m_id=" + m_id);
      System.out.println("membership=" + membership);

      Map<String, Object> map = new HashMap<String, Object>();

      int affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).qrcode(m_id, membership);

      if (affected == 1) {
         map.put("success", affected);
      } else {
         map.put("fail", affected);
      }

      return map;
   }

   @RequestMapping("parkmoa/androidList.do")
   @ResponseBody
   public ArrayList<ThemeParkDTO> androidList(HttpServletRequest req) {

      String tp_name = req.getParameter("tp_name");
      System.out.println("TP_NAME" + tp_name);
//       String tp_attach = req.getParameter("tp_attach");
//       String tp_addr1 = req.getParameter("tp_addr1");
      ArrayList<ThemeParkDTO> list = sqlSession.getMapper(ParkmoamainImpl.class).androidList(tp_name);

      return list;
   }

   // 안드로이드 테마파크 리스트
   @RequestMapping("/parkmoa/androidTplist.do")
   @ResponseBody
   public Map<String, Object> AndroidTplist(ThemeParkDTO themeParkDTO, HttpServletRequest req) {

      String tp_category = req.getParameter("tp_category");
      System.out.println("tp_category=" + tp_category);

      Map<String, Object> map = new HashMap<String, Object>();
      ArrayList<ThemeParkDTO> lists = new ArrayList<ThemeParkDTO>();
      lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectTplist(tp_category);

      map.put("Tpmap", lists);

      return map;
   }

   // 안드로이드 테마파크 상세보기
   @RequestMapping("/parkmoa/androidTplistView.do")
   @ResponseBody
   public Map<String, Object> AndroidTplistView(ThemeParkDTO themeParkDTO, HttpServletRequest req) {

      String tp_idx1 = req.getParameter("tp_idx");
      System.out.println("tp_idx=" + tp_idx1);

      int tp_idx = Integer.parseInt(tp_idx1);

      Map<String, Object> map = new HashMap<String, Object>();

      themeParkDTO = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectTplistView(tp_idx);
      int affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).updatevisitcount(tp_idx);

      map.put("Tpmap", themeParkDTO);

      return map;
   }

   // 안드로이드 네이버 간편로그인
   @RequestMapping("/parkmoa/androidnaverAction.do")
   @ResponseBody
   public Map<String, Object> andNaverLogin(HttpServletRequest req) {
      Map<String, Object> navermap = new HashMap<String, Object>();
      String m_id = req.getParameter("m_id");
      String m_email = req.getParameter("m_email");
      System.out.println("m_id" + m_id);
      System.out.println("email" + m_email);
      int affected = 0;
      affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectMember(m_email);
      // 일치하는 아이디 있는 경우(기존회원)
      if (affected == 1) {
         System.out.println("기존회원입니다.");
         ParkmoaMemberDTO memberInfo = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class)
               .selectMember1(m_email);
         navermap.put("exist", 1);
         navermap.put("memberInfo", memberInfo);
         return navermap;
      } else {
         // 회원가입시켜야 하는 경우
         System.out.println("기존회원아님");
         navermap.put("exist", 0);
         navermap.put("memberInfo", m_id);
         navermap.put("memberInfo", m_email);
         return navermap;
      }

   }
   // 안드로이드 티켓 리스트
   @RequestMapping("/parkmoa/ticketList.do")
   @ResponseBody
   public Map<String, Object> ticketList(TicketsDTO ticketsDTO, HttpServletRequest req) {
      
      int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
      System.out.println("tp_idx=" + tp_idx);
      
      Map<String, Object> map = new HashMap<String, Object>();
      ArrayList<TicketsDTO> lists = new ArrayList<TicketsDTO>();
      lists = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).ticketList(tp_idx);
      
      map.put("ticketList", lists);
      
      return map;
   }

   //안드로이드 결제창
   @RequestMapping("/parkmoa/androidPayment.do")
   @ResponseBody
   public Map<String, Object> androidPayment(HttpServletRequest req) {
      
      int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
      
      String m_id = "ehdgk765nv";
      System.out.println("아이디"+m_id);

      
      Map<String, Object> map = new HashMap<String, Object>();
      
      int p_idx= sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).p_idxSelect(tp_idx);
      
      ParkinginfoDTO parkingInfoDTO = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).p_infoSelect(p_idx);
      parkingInfoDTO.setP_content(parkingInfoDTO.getP_code().split(", "));
      
      
      ThemeParkDTO TPdto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectTplistView(tp_idx);  
      
      // 결제테이블에서 레코드 불러오기
      ArrayList<PaymentDTO> paymentList = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).payListSelect();   
      ParkmoaMemberDTO dto = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).PersonInfo(m_id).get(0);
      map.put("dto", dto);
      map.put("TPdto", TPdto);
      map.put("parkingInfoDTO", parkingInfoDTO); 
      map.put("paymentList", paymentList);

      return map;
   }
   
   @RequestMapping("/parkmoa/AndroidPaymentAction.do")
   @ResponseBody
   public ModelAndView paymentAction(HttpServletRequest req){
	   
	   ModelAndView mv = new ModelAndView();
	   
	   String m_id = req.getParameter("m_id");
	   System.out.println("아이디:"+m_id); 
	   String t_name = req.getParameter("t_name");
	   System.out.println("t_name:"+t_name);
	   String TotalPrice = req.getParameter("TotalPrice");
	   System.out.println("TotalPrice"+TotalPrice);
	   String r_useregi = req.getParameter("r_useregi");
	   System.out.println("r_useregi"+r_useregi);
	   String p_num = req.getParameter("p_num");
	   System.out.println("p_num"+p_num);
	   String m_mobile = req.getParameter("m_mobile");
	   System.out.println("m_mobile"+m_mobile);
	   String m_email = req.getParameter("m_email");
	   System.out.println("m_email"+m_email);
	   String tp_name = req.getParameter("tp_name");
	   System.out.println("tp_name"+tp_name);
	   String m_membership = req.getParameter("m_membership");
	   System.out.println("m_membership"+m_membership);
	   int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
	   System.out.println("tp_idx"+tp_idx); 
	   mv.addObject("m_id", m_id);
	   mv.addObject("t_name", t_name); 
	   mv.addObject("TotalPrice", TotalPrice);
	   mv.addObject("r_useregi", r_useregi);
	   mv.addObject("p_num", p_num);
	   mv.addObject("m_mobile", m_mobile);
	   mv.addObject("m_email", m_email);
	   mv.addObject("tp_idx",tp_idx);
	   mv.addObject("tp_name",tp_name);
	   mv.addObject("m_membership",m_membership);
	   
	   mv.setViewName("/parkmoa/KaKaoPay");
	     
	   
	   return mv;
	   
   }
   
   //내 주차장위치 보기
   @RequestMapping("/parkmoa/androidParkingHistory.do")
   @ResponseBody
   public Map<String, Object> parkingHistorySelect(HttpServletRequest req) {

      Map<String, Object> map = new HashMap<String, Object>();
      String id = req.getParameter("m_id");
      
      System.out.println(id);

      ArrayList<PaymentDTO> paymentList = sqlSession.getMapper(ParkmoamainImpl.class).parkingHistorySelect(id);
      int[] tp_idx = new int[paymentList.size()];
      ArrayList<ParkinginfoDTO> parkingList = new ArrayList<ParkinginfoDTO>();
      
      
      for(int i=0; i<paymentList.size(); i++) {
    	  tp_idx[i] = sqlSession.getMapper(ParkmoamainImpl.class).p_idxSelect(paymentList.get(i).getTp_idx());
    	  parkingList.add(sqlSession.getMapper(ParkmoamainImpl.class).p_infoSelect(tp_idx[i]));
      }

      for(ParkinginfoDTO dto : parkingList) {
    	  dto.setP_content(dto.getP_code().split(", "));
      }
      String sql = sqlSession.getConfiguration().getMappedStatement("PaymentList").getBoundSql("").getSql();
      
      map.put("parkingList", parkingList);
      map.put("paymentList", paymentList);
      return map;
   }
   
   @RequestMapping("/parkmoa/AndroidpayResult.do")
   @ResponseBody
   public void PayResult(HttpServletRequest req) {
	  
	   Map<String, Object> map = new HashMap<String, Object>();
	   String t_name = req.getParameter("t_name");
	   int totalPrice = Integer.parseInt(req.getParameter("TotalPrice"));
	   String m_membership = req.getParameter("m_membership");
	   String m_email = req.getParameter("m_email");
	   String m_id = req.getParameter("m_id");
	   String m_mobile = req.getParameter("m_mobile");
	   String r_useregi = req.getParameter("r_useregi");
	   String tp_name = req.getParameter("tp_name");
	   int p_num = Integer.parseInt(req.getParameter("p_num"));
	   int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
	   int pay_group = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).selectPayGroup();
	   
	   System.out.println("멤버쉽"+m_membership);
	   
	   int affected = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).paymentInsert(m_id, tp_idx,
               tp_name, t_name, totalPrice, r_useregi, p_num, pay_group, m_mobile, m_email);
	   
	   if(affected ==1) {
		   int updatemembership = sqlSession.getMapper(parkmoa.model.ParkmoamainImpl.class).updatemembership(Integer.parseInt(m_membership), m_id);
	   }
	   
   }
   
   
   
   
   

}