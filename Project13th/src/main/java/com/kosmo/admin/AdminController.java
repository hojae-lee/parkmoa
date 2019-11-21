package com.kosmo.admin;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import parkmoa.model.ParkmoaBoardDTO;
import parkmoa.model.ParkmoaImpl;
import parkmoa.model.ParkmoaMemberDTO;
import parkmoa.model.PaymentDTO;
import parkmoa.model.ThemeParkDTO;
import parkmoa.model.TicketsDTO;
import springboard.util.PagingUtil;

@Controller
public class AdminController {

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		return "redirect:/parkmoa/index.do";
	}
	
	@RequestMapping("/admin/AdLogin.do")
	public String AdminLogin(Model model, Principal principal) {
		 
		return "/admin/AdLogin";
	}

	@RequestMapping("/admin/AdminIndex.do")
	public String AdminIndex(Model model, Principal principal) {
		// 관리자메인

		String m_id = "";

		try {
			m_id = principal.getName();
			System.out.println("어드민아이이디: " + m_id);
		} catch (Exception e) {
		}

		int totalmembercount = 0;
		int membercount = 0;
		int companycount = 0;
		int slavecount = 0;
		int faqcount = 0;
		int themeregistcount = 0;

		totalmembercount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).totalmembercount();
		membercount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).membercount();
		companycount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).companycount();
		slavecount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).slavecount();
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();

		System.out.println("totalmembercount=" + totalmembercount);
		System.out.println("membercount=" + membercount);
		System.out.println("companycount=" + companycount);
		System.out.println("slavecount=" + slavecount);
		System.out.println("faqcount=" + faqcount);
		System.out.println("themeregistcount=" + themeregistcount);

		int average1 = (int) (((double) membercount / (double) totalmembercount) * 100);
		int average2 = (int) (((double) companycount / (double) totalmembercount) * 100);
		int average3 = (int) (((double) slavecount / (double) totalmembercount) * 100);

		System.out.println("totalmembercount=" + totalmembercount);
		System.out.println("average1=" + average1);
		System.out.println("average2=" + average2);
		System.out.println("average3=" + average3);

		model.addAttribute("faqcount", faqcount);
		model.addAttribute("themeregistcount", themeregistcount);
		model.addAttribute("totalmembercount", totalmembercount);
		model.addAttribute("membercount", average1);
		model.addAttribute("companycount", average2);
		model.addAttribute("slavecount", average3);
		model.addAttribute("m_id", m_id);

		return "/admin/AdminIndex";
	}

	@RequestMapping("/admin/ConfirmList.do")
	public String ConfrimList(Model model, HttpServletRequest req, ThemeParkDTO themeParkDTO) {

		String confirm = req.getParameter("confirm");
		System.out.println("confirm=" + confirm);

		System.out.println("themeParkDTO1:" + themeParkDTO.getTp_category());
		int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));
		System.out.println("뀨?" + nowPage);
		int affected = 0;
		int deleted = 0;

		if (confirm.equalsIgnoreCase("confirm")) {
			affected = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).insertWrite(tp_idx);
		} else {
			deleted = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).deleteConfrim(tp_idx);
		}

		System.out.println("deleted=" + deleted);

		return "redirect:/admin/BoardList.do?boardname=themeconfirm&nowPage=" + nowPage;

	}

	@RequestMapping("/admin/BoardList.do")
	public String BoardList(Model model, HttpServletRequest req) {

		String flag = req.getParameter("boardname");
		System.out.println("flag=" + flag);

		String addQueryString = "";
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		System.out.println("서치컬럼" + searchColumn);
		System.out.println("서치단어" + searchWord);

		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();
		// 모든게시판들 안에 파라미터값 잘보면서 수정하시길.
		int totalRecordCount = 0;

		if (searchWord != null) {
			addQueryString = "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";

		}

		if (flag.equalsIgnoreCase("event") || flag.equalsIgnoreCase("faq")) {
			totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).getTotalCount(flag, searchColumn,
					searchWord);
			System.out.println("앙 토털레코드카운터1 " + totalRecordCount);
		}

		if (flag.equalsIgnoreCase("payment")) {
			totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).getTotalCount1(searchColumn,
					searchWord);
		}

		if (flag.equalsIgnoreCase("themeconfirm")) {
			totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).getTotalCount2(searchWord);
			System.out.println("앙 토털레코드카운터3 " + totalRecordCount);
		}

		if (flag.equalsIgnoreCase("member") || flag.equalsIgnoreCase("company") || flag.equalsIgnoreCase("admin")
				|| flag.equalsIgnoreCase("disabled")) {
			totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).getTotalCount3(flag, searchColumn,
					searchWord);
			System.out.println("앙 토텔레코드카운터 멤버띠 " + totalRecordCount);
		}

		if (flag.equalsIgnoreCase("park") || flag.equalsIgnoreCase("water") || flag.equalsIgnoreCase("zoo")
				|| flag.equalsIgnoreCase("forest")) {
			totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).getTotalCount4(flag, searchColumn,
					searchWord);
			System.out.println("앙 토털레코드카운터 4 띠" + totalRecordCount);
		}

		if (flag.equalsIgnoreCase("tickets")) {
			totalRecordCount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).getTotalCount5(searchColumn,
					searchWord);
			System.out.println("앙 토털레코드카운터 5띠 " + totalRecordCount);
		}

		// 페이지 처리를 위한 설정값
		int pageSize = 12;
		int blockPage = 5;

		// 전체페이지수계싼하기
		int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);

		// 시작 및 끝 rownum구하기
		int nowPage = req.getParameter("nowPage") == null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		System.out.println(nowPage);
		int start = (nowPage - 1) * pageSize + 1;
		int end = nowPage * pageSize;

		ArrayList<ParkmoaBoardDTO> lists = null;

		if (flag.equalsIgnoreCase("event") || flag.equalsIgnoreCase("faq")) {
			lists = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).listPage(flag, start, end, searchColumn,
					searchWord);

			// 줄바꿈처리
			for (ParkmoaBoardDTO dto : lists) {
				String temp = dto.getB_content().replace("\r\n", "<br/>");
				dto.setB_content(temp);
			}

			model.addAttribute("lists", lists);
		}

		ArrayList<PaymentDTO> paylists = null;

		if (flag.equalsIgnoreCase("payment")) {
			paylists = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).paymentlistPage(start, end, searchColumn,
					searchWord);
			model.addAttribute("paylists", paylists);
		}

		ArrayList<ThemeParkDTO> lists2 = null;

		if (flag.equalsIgnoreCase("themeconfirm")) {
			lists2 = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).listPage2(start, end, searchWord);
			model.addAttribute("lists2", lists2);
		}

		ArrayList<ThemeParkDTO> lists4 = null;

		if (flag.equalsIgnoreCase("park") || flag.equalsIgnoreCase("water") || flag.equalsIgnoreCase("zoo")
				|| flag.equalsIgnoreCase("forest")) {
			lists4 = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).listPage4(flag, start, end, searchColumn,
					searchWord);
			model.addAttribute("lists4", lists4);
		}

		ArrayList<ParkmoaMemberDTO> lists3 = null;
		if (flag.equalsIgnoreCase("member") || flag.equalsIgnoreCase("company") || flag.equalsIgnoreCase("admin")
				|| flag.equalsIgnoreCase("disabled")) {
			lists3 = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).listPage3(flag, start, end, searchColumn,
					searchWord);
			model.addAttribute("lists3", lists3);
		}

		ArrayList<TicketsDTO> ticketlists = null;
		if (flag.equalsIgnoreCase("tickets")) {
			ticketlists = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).ticketlistPage(start, end, searchColumn,
					searchWord);
			model.addAttribute("ticketlists", ticketlists);
		}

		// 페이지 처리를 위한 처리부분
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
				req.getContextPath() + "/admin/BoardList.do?boardname=" + flag + "&" + addQueryString);

		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();

		model.addAttribute("faqcount", faqcount);
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("themeregistcount", themeregistcount);
		model.addAttribute("flag", flag);

		return "/admin/BoardList";
	}

	@RequestMapping("/admin/ListWrite.do")
	public String ListWrite(Model model, HttpServletRequest req, Principal principal) {
		// 게시판 글등록폼 필요한곳은 이벤트공지 FAQ게시판
		String flag = req.getParameter("boardname");
		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();
		String m_id = "";
		try {
			m_id = principal.getName();
			System.out.println("어드민아이이디: " + m_id);
		} catch (Exception e) {
		}

		model.addAttribute("m_id", m_id);

		model.addAttribute("faqcount", faqcount);
		model.addAttribute("themeregistcount", themeregistcount);
		model.addAttribute("flag", flag);

		return "/admin/ListWrite";
	}

	// 글쓰기(멀티파트)
	@RequestMapping(value = "/admin/ListWriteAction.do", method = RequestMethod.POST)
	public String ListWriteAction(Model model, HttpServletRequest req, ParkmoaBoardDTO parkmoaBoardDTO,
			MultipartHttpServletRequest mhsr, Principal principal) throws IllegalStateException, IOException {

		String m_id = principal.getName();
		model.addAttribute("m_id", m_id);
		String flag = req.getParameter("b_flag");
		System.out.println("플래그는?" + flag);

		int affected = 0;

		MultipartFile files = mhsr.getFile("fileNm");

		// 첨부파일 안하고 글쓰기
		if (flag.equalsIgnoreCase("event")
				|| flag.equalsIgnoreCase("faq") && files.getOriginalFilename().isEmpty() == true) {
			System.out.println("이벤트게시판,문의게시판 첨부없는글써져야하는곳");
			affected = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).listwrite1(parkmoaBoardDTO);
		}

		System.out.println("파일명:" + files);

		// 서버의 물리적 경로 가져오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println("path:" + path);

		// 뷰로 전달할 데이터 저장용 Map
		Map returnObj = new HashMap();
		/*
		 * 파일 업로드를 위한 Multipart객체를 생성한다. 생성과 동시에 업로드는 완료되고 나머지 폼값은 Multipart가 통째로 받아서
		 * 처리한다.
		 */

		// 업로드폼의 file속성 필드의 이름을 모두 읽음
		Iterator itr = mhsr.getFileNames();

		MultipartFile mfile = null;

		String fileName = "";

		List resultList = new ArrayList();

		// 파일 외 나머지 폼값받기
		String b_title = mhsr.getParameter("b_title");
		String b_content = mhsr.getParameter("b_content");
		String b_flag = mhsr.getParameter("b_flag");

		/*
		 * File객체를 통해 물리적경로로 지정된 디렉토리가 존재하는지 확인 후 없으면 생성한다.
		 */
		File directory = new File(path);
		if (!directory.isDirectory()) {
			directory.mkdirs();
		}

		// 업로드폼의 file속성의 필드갯수만큼 반복
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

				file.put("b_title", b_title);

				resultList.add(file);
				System.out.println("문의게시판첨부글써져야하는 곳");
				affected = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).listwrite(m_id, b_title, b_content,
						originalName, saveFileName, b_flag);
				System.out.println("fileName=" + fileName);
				System.out.println("originalName=" + originalName);
				System.out.println("serverFullName=" + serverFullName);
				System.out.println("affected문의=" + affected);
				returnObj.put("files", resultList);
			}

		}

		model.addAttribute("returnObj", returnObj);

		return "redirect:/admin/BoardList.do?boardname=" + flag;
	}

	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된 UUID:" + uuid);
		return uuid;
	}

	@RequestMapping("/admin/View.do")
	public String View(Model model, HttpServletRequest req) {
		// 게시판 상세보기. 상세보기필요한곳은 이벤트공지 FAQ게시판 테마파크 리스트들..

		String flag = req.getParameter("boardname");
		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));

		System.out.println("상세보기flag=" + flag);
		System.out.println("상세보기nowPage = " + nowPage);

		ArrayList<TicketsDTO> ticketlists = null;

		if (flag.equalsIgnoreCase("park") || flag.equalsIgnoreCase("zoo") || flag.equalsIgnoreCase("water")
				|| flag.equalsIgnoreCase("forest")) {
			int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
			ThemeParkDTO themeParkDTO = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeSelect(tp_idx);

			if (themeParkDTO != null) {
				ticketlists = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).ticketlists(tp_idx);
				model.addAttribute("ticketlists", ticketlists);
			}

			model.addAttribute("dto", themeParkDTO);
			model.addAttribute("tp_idx", tp_idx);
			System.out.println("상세보기tp_idx=" + tp_idx);
		}
		if (flag.equalsIgnoreCase("event") || flag.equalsIgnoreCase("faq")) {
			int b_idx = Integer.parseInt(req.getParameter("b_idx"));
			ParkmoaBoardDTO dto = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).boardSelect(b_idx);
			model.addAttribute("dto", dto);
			model.addAttribute("b_idx", b_idx);
			System.out.println("상세보기idx=" + b_idx);
		}
		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();

		model.addAttribute("faqcount", faqcount);
		model.addAttribute("themeregistcount", themeregistcount);
		model.addAttribute("flag", flag);
		model.addAttribute("nowPage", nowPage);

		return "/admin/View";
	}

	// 파일다운로드
	@RequestMapping("/admin/fileDownload.do")
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

	// 수정페이지로 정보뿌리기
	@RequestMapping("/admin/BoardEdit.do")
	public String BoardListEdit(Model model, HttpServletRequest req, Principal principal) {

		String m_id = principal.getName();
		model.addAttribute("m_id", m_id);

		int b_idx = Integer.parseInt(req.getParameter("b_idx"));
		System.out.println("수정b_idx=" + b_idx);
		String flag = req.getParameter("boardname");
		System.out.println("수정boardname=" + flag);

		ParkmoaBoardDTO dto = new ParkmoaBoardDTO();
		dto = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).boardSelect(b_idx);

		String path = req.getSession().getServletContext().getRealPath("/resources/upload");

		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();

		model.addAttribute("faqcount", faqcount);
		model.addAttribute("themeregistcount", themeregistcount);
		model.addAttribute("dto", dto);
		model.addAttribute("b_idx", b_idx);
		model.addAttribute("flag", flag);

		return "/admin/BoardListEdit";
	}

	// 수정하기
	@RequestMapping(value = "/admin/BoardEditAction.do", method = RequestMethod.POST)
	public String BoardListEditAction(Model model, HttpServletRequest req, ParkmoaBoardDTO parkmoaBoardDTO,
			MultipartHttpServletRequest mhsr, Principal principal) throws IllegalStateException, IOException {

		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));
		String flag = req.getParameter("flag");
		int b_idx = Integer.parseInt(req.getParameter("b_idx"));
		String m_id = principal.getName();
		model.addAttribute("m_id", m_id);

		int affected = 0;

		MultipartFile files = mhsr.getFile("fileNm");

		// 첨부파일 안하고 수정하기
		if (flag.equalsIgnoreCase("event")
				|| flag.equalsIgnoreCase("faq") && files.getOriginalFilename().isEmpty() == true) {
			System.out.println("이벤트게시판,문의게시판 첨부없는글써져야하는곳");
			affected = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).boardEdit1(parkmoaBoardDTO);
		}

		System.out.println("파일명:" + files);

		// 서버의 물리적 경로 가져오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println("path:" + path);

		// 뷰로 전달할 데이터 저장용 Map
		Map returnObj = new HashMap();
		/*
		 * 파일 업로드를 위한 Multipart객체를 생성한다. 생성과 동시에 업로드는 완료되고 나머지 폼값은 Multipart가 통째로 받아서
		 * 처리한다.
		 */

		// 업로드폼의 file속성 필드의 이름을 모두 읽음
		Iterator itr = mhsr.getFileNames();

		MultipartFile mfile = null;

		String fileName = "";

		List resultList = new ArrayList();

		// 파일 외 나머지 폼값받기
		String b_title = mhsr.getParameter("b_title");
		String b_content = mhsr.getParameter("b_content");
		String b_flag = mhsr.getParameter("b_flag");

		/*
		 * File객체를 통해 물리적경로로 지정된 디렉토리가 존재하는지 확인 후 없으면 생성한다.
		 */
		File directory = new File(path);
		if (!directory.isDirectory()) {
			directory.mkdirs();
		}

		// 업로드폼의 file속성의 필드갯수만큼 반복
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

				file.put("b_title", b_title);

				resultList.add(file);
				System.out.println("문의게시판첨부글써져야하는 곳");
				affected = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).boardEdit(m_id, b_title, b_content,
						originalName, saveFileName, b_idx);
				System.out.println("fileName=" + fileName);
				System.out.println("originalName=" + originalName);
				System.out.println("serverFullName=" + serverFullName);
				System.out.println("affected문의=" + affected);
				returnObj.put("files", resultList);
			}

		}

		model.addAttribute("returnObj", returnObj);

		return "redirect:/admin/View.do?boardname=" + flag + "&b_idx=" + b_idx + "&nowPage=" + nowPage;
	}

	@RequestMapping("/admin/BoardDelete.do")
	public String BoardDelete(Model model, HttpServletRequest req) {

		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));

		String flag = req.getParameter("boardname");

		if (flag.equalsIgnoreCase("park") || flag.equalsIgnoreCase("water") || flag.equalsIgnoreCase("zoo")
				|| flag.equalsIgnoreCase("forest")) {

			int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
			System.out.println("tp_idx=" + tp_idx);

			int themeDelete = 0;
			themeDelete = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeDelete(tp_idx);
			System.out.println("themeDelete   " + themeDelete);
			if (themeDelete == 1) {
				int reviewdelete = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).reviewdelete(tp_idx);
				System.out.println("reviewdelete" + reviewdelete);
			}
		}

		if (flag.equalsIgnoreCase("event") || flag.equalsIgnoreCase("faq")) {

			int b_idx = Integer.parseInt(req.getParameter("b_idx"));
			System.out.println("b_idx=" + b_idx);
			int boardDelete = 0;
			boardDelete = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).boarddelete(b_idx);
			System.out.println("boarddelete= " + boardDelete);

			int boardreplydelete = 0;

			if (boardDelete == 1) {
				boardreplydelete = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).boardreplydelete(b_idx);
			}

		}

		if (flag.equalsIgnoreCase("tickets")) {
			int t_idx = Integer.parseInt(req.getParameter("t_idx"));
			System.out.println("t_idx=" + t_idx);
			int ticketsDelete = 0;
			ticketsDelete = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).ticketsDelete(t_idx);
		}

		return "redirect:/admin/BoardList.do?boardname=" + flag + "&nowPage=" + nowPage;
	}

	@RequestMapping("/admin/Tp_registconfirm.do")
	public String Tp_registconfrim(Model model, HttpServletRequest req) {
		// 테마파크 승인폼
		int tp_idx = Integer.parseInt(req.getParameter("tp_idx"));
		System.out.println("tp_idx=" + tp_idx);
		String flag = req.getParameter("boardname");
		System.out.println("boardname=" + flag);

		ThemeParkDTO dto = new ThemeParkDTO();
		dto = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).Tp_selectView(tp_idx);

		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();

		ArrayList<TicketsDTO> Tkdto = null;

		System.out.println("tp_name=" + tp_idx);

		Tkdto = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).ticketlists(tp_idx);

		model.addAttribute("Tkdto", Tkdto);
		model.addAttribute("faqcount", faqcount);
		model.addAttribute("themeregistcount", themeregistcount);

		model.addAttribute("dto", dto);

		return "/admin/Tp_registconfirm";
	}

	@RequestMapping("/admin/deleteUser.do")
	public String delete_User(@RequestParam("chk") String[] chk, HttpServletRequest req) throws Exception {

		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));

		String flag = req.getParameter("boardname");
		System.out.println("nowPage=" + nowPage);
		System.out.println("flag=" + flag);

		int deleteaffected = 0;

		// @RequestParam ("chk") String [] chk 으로 받은 체크박스 배열을 foreach문으로 확인후 m_grade변경처리
		for (String schk : chk) {
			deleteaffected = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).deleteUser(schk);
			System.out.println("회원비활성화" + deleteaffected);
		}

		return "redirect:BoardList.do?boardname=" + flag + "&nowPage=" + nowPage;

	}

	@RequestMapping("/admin/ListEdit.do")
	public String ListEdit(Model model, HttpServletRequest req, HttpSession session) {

		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));
		String flag = req.getParameter("boardname");

		// 파라미터 전달을 위한 DTO객체를 생성후 저장.

		ParkmoaBoardDTO parkmoaBoardDTO = new ParkmoaBoardDTO();
		parkmoaBoardDTO.setM_id(req.getParameter("id"));

		System.out.println(parkmoaBoardDTO.getM_id());

		String m_id = parkmoaBoardDTO.getM_id();
		ParkmoaMemberDTO parkmoaMemberDTO = sqlSession.getMapper(ParkmoaImpl.class).MemberView(m_id);
		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();

		model.addAttribute("faqcount", faqcount);
		model.addAttribute("themeregistcount", themeregistcount);
		model.addAttribute("dto", parkmoaMemberDTO);
		model.addAttribute("flag", flag);
		model.addAttribute("nowPage", nowPage);

		return "/admin/MemberListEdit";
	}

	@RequestMapping("/admin/ListEditAction.do")
	public String modifyAction(Model model, HttpServletRequest req, HttpSession session,
			ParkmoaMemberDTO parkmoaMemberDTO) {

		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));
		String flag = req.getParameter("boardname");

		model.addAttribute("flag", flag);
		model.addAttribute("nowPage", nowPage);

		sqlSession.getMapper(ParkmoaImpl.class).ListEdit(parkmoaMemberDTO);

		return "redirect:/admin/BoardList.do?boardname=" + flag + "&nowPage=" + nowPage;
	}

	@RequestMapping("/admin/TicketEditAction.do")
	public String modifyAction(Model model, HttpServletRequest req, HttpSession session, TicketsDTO ticketsDTO) {

		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));
		String flag = req.getParameter("boardname");

		model.addAttribute("flag", flag);
		model.addAttribute("nowPage", nowPage);

		sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).ticketedit(ticketsDTO);

		return "redirect:/admin/BoardList.do?boardname=" + flag + "&nowPage=" + nowPage;
	}

	@RequestMapping("/admin/BoardReply.do")
	public String modifyAction(Model model, HttpServletRequest req, Principal principal) {
		int b_idx = Integer.parseInt(req.getParameter("b_idx"));
		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));
		String flag = req.getParameter("boardname");
		String m_id = principal.getName();
		model.addAttribute("m_id", m_id);

		System.out.println("b_idx= " + b_idx);
		System.out.println("nowPage= " + nowPage);
		System.out.println("flag=" + flag);
		System.out.println("m_id=" + m_id);

		ParkmoaBoardDTO parkmoaBoardDTO;

		parkmoaBoardDTO = sqlSession.getMapper(ParkmoaImpl.class).boardSelect(b_idx);

		parkmoaBoardDTO.setB_title(parkmoaBoardDTO.getB_title());
		parkmoaBoardDTO.setB_content("");
		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();

		model.addAttribute("faqcount", faqcount);
		model.addAttribute("themeregistcount", themeregistcount);
		model.addAttribute("b_idx", b_idx);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("flag", flag);
		model.addAttribute("dto", parkmoaBoardDTO);

		return "/admin/BoardReply";
	}

	@RequestMapping("/admin/ListReplyAction.do")
	public String ListReplyAction(Model model, HttpServletRequest req, ParkmoaBoardDTO parkmoaBoardDTO) {
		int replyprevupdate = 0;
		int replyaffected = 0;
		int replyupdated = 0;
		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));
		String flag = req.getParameter("b_flag");

		parkmoaBoardDTO.setB_title("<img src='/project3rd/resources/imgimg.PNG';/>" + parkmoaBoardDTO.getB_title());

		replyaffected = sqlSession.getMapper(ParkmoaImpl.class).boardreply(parkmoaBoardDTO);
		if (replyaffected != 0) {
			replyprevupdate = sqlSession.getMapper(ParkmoaImpl.class).replyprevupdate(parkmoaBoardDTO);
			replyupdated = sqlSession.getMapper(ParkmoaImpl.class).alertupdate(parkmoaBoardDTO);
			System.out.println("replyupdated=" + replyupdated);
		}

		return "redirect:/admin/BoardList.do?boardname=" + flag + "&nowPage=" + nowPage;
	}

	@RequestMapping("/admin/adminthemeRegist.do")
	public String adminthemeRegist(Model model, HttpServletRequest req) {
		String flag = req.getParameter("boardname");

		System.out.println("테마파크등록폼플래스 = " + flag);

		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();

		model.addAttribute("faqcount", faqcount);
		model.addAttribute("themeregistcount", themeregistcount);
		model.addAttribute("flag", flag);
		return "/admin/adminthemeRegist";
	}

	@RequestMapping("/admin/ActionadminthemeRegist.do")
	public String ActionadinthemeRegist(Model model, HttpServletRequest req, MultipartHttpServletRequest mhsr)
			throws IllegalStateException, IOException {

		MultipartFile files = mhsr.getFile("fileNm");

		int themeRegistaffected = 0;

		// 서버의 물리적 경로 가져오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println("path:" + path);

		// 뷰로 전달할 데이터 저장용 Map
		Map returnObj = new HashMap();
		/*
		 * 파일 업로드를 위한 Multipart객체를 생성한다. 생성과 동시에 업로드는 완료되고 나머지 폼값은 Multipart가 통째로 받아서
		 * 처리한다.
		 */

		// 업로드폼의 file속성 필드의 이름을 모두 읽음
		Iterator itr = mhsr.getFileNames();

		MultipartFile mfile = null;

		String fileName = "";

		List resultList = new ArrayList();

		// 파일 외 나머지 폼값받기
		String flag = mhsr.getParameter("boardname");
		String m_id = mhsr.getParameter("m_id");
		String tp_name = mhsr.getParameter("tp_name");
		String tp_phone = mhsr.getParameter("tp_phone");
		String tp_addr1 = mhsr.getParameter("tp_addr1");
		String tp_content = mhsr.getParameter("tp_content");
		String tp_category = mhsr.getParameter("tp_category");
		String tp_parkregi = mhsr.getParameter("tp_parkregi");

		System.out.println("멤버아이디:" + m_id);
		System.out.println("테마파크이름:" + tp_name);
		System.out.println(tp_phone);
		System.out.println(tp_addr1);
		System.out.println(tp_content);
		System.out.println(tp_category);
		System.out.println(tp_parkregi);

		/*
		 * File객체를 통해 물리적경로로 지정된 디렉토리가 존재하는지 확인 후 없으면 생성한다.
		 */
		File directory = new File(path);
		if (!directory.isDirectory()) {
			directory.mkdirs();
		}

		// 업로드폼의 file속성의 필드갯수만큼 반복
		while (itr.hasNext()) {

			fileName = (String) itr.next();
			// 서버로 업로드된 임시파일명 가져오기
			mfile = mhsr.getFile(fileName);

			// 한글깨짐방지 처리 후 업로드된 파일명을 가져옴
			String tp_realfilename = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");

			if ("".equals(tp_realfilename)) {
				continue;
			}

			if (mfile.isEmpty() == false) {
				// 파일의 확장자 가져오기
				String ext = tp_realfilename.substring(tp_realfilename.lastIndexOf('.'));
				String tp_attach = getUuid() + ext;

				// 설정한 경로에 파일저장
				File serverFullName = new File(path + File.separator + tp_attach);

				mfile.transferTo(serverFullName);

				themeRegistaffected = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).adminthemeRegist(m_id,
						tp_name, tp_phone, tp_realfilename, tp_attach, tp_addr1, tp_content, tp_category, tp_parkregi);
				System.out.println("fileName=" + fileName);
				System.out.println("originalName=" + tp_realfilename);
				System.out.println("serverFullName=" + serverFullName);
			}
		}

		return "redirect:/admin/BoardList.do?boardname=" + flag;
	}

	// 비활성회원 -> 활성화
	@RequestMapping("/admin/enabledUser.do")
	public String enabled_User(@RequestParam("chk") String[] chk, HttpServletRequest req) throws Exception {

		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));

		String flag = req.getParameter("boardname");
		System.out.println("nowPage=" + nowPage);
		System.out.println("flag=" + flag);

		int deleteaffected = 0;

		// @RequestParam ("chk") String [] chk 으로 받은 체크박스 배열을 foreach문으로 확인후 m_grade변경처리
		for (String schk : chk) {
			deleteaffected = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).enabledUser(schk);
			System.out.println("회원 활성화" + deleteaffected);
		}

		return "redirect:BoardList.do?boardname=" + flag + "&nowPage=" + nowPage;

	}

	// 이용권 뷰
	@RequestMapping("/admin/TicketViewEdit.do")
	public ModelAndView ticketViewEdit(HttpServletRequest req) {

		ModelAndView mv = new ModelAndView();

		int nowPage = req.getParameter("nowPage").equalsIgnoreCase("") ? 1
				: Integer.parseInt(req.getParameter("nowPage"));

		String flag = req.getParameter("boardname");
		int t_idx = Integer.parseInt(req.getParameter("t_idx"));

		TicketsDTO dto = new TicketsDTO();

		dto = sqlSession.getMapper(ParkmoaImpl.class).ticketsview(t_idx);

		System.out.println("dddd" + dto.getTp_idx());

		int tp_idx = dto.getTp_idx();

		String tp_category = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).tp_categoryselect(tp_idx);

		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();

		mv.addObject("tp_category", tp_category);
		mv.addObject("faqcount", faqcount);
		mv.addObject("themeregistcount", themeregistcount);
		mv.addObject("dto", dto);
		mv.addObject("flag", flag);
		mv.addObject("nowPage", nowPage);
		mv.setViewName("/admin/ticketListEdit");

		return mv;
	}

	@RequestMapping("/admin/paymentView.do")
	public ModelAndView paymentViewPage(HttpServletRequest req) {

		ModelAndView mv = new ModelAndView();
		String flag = req.getParameter("boardname");
		String m_id = req.getParameter("m_id");
		System.out.println("아" + m_id);

		ArrayList<PaymentDTO> list = null;
		list = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).paymentViewPage(m_id);

		int faqcount = 0;
		faqcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).faqcount();
		int themeregistcount = 0;
		themeregistcount = sqlSession.getMapper(parkmoa.model.ParkmoaImpl.class).themeregistcount();
		mv.addObject("faqcount", faqcount);
		mv.addObject("themeregistcount", themeregistcount);

		mv.addObject("flag", flag);
		mv.addObject("list", list);
		mv.setViewName("/admin/View");

		return mv;
	}

}