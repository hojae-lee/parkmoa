package parkmoa.model;

import java.util.ArrayList;
import java.util.List;

public interface ParkmoamainImpl {

   // 리뷰메인카운트
   public int reviewcount();

   // 리뷰메인불러오기
   public ArrayList<ParkmoaBoardDTO> reviewlists(int start, int end);

   // 카테고리가져오기
   public String selecttp_category(int tp_idx);

   // 갤러리게시물카운트
   public int getTotalCount(String flag, String searchColumn, String searchWord);

   // 목록게시물카운트
   public int getTotalCount1(String flag, String searchColumn, String searchWord);

   // start end값을 사용하여 리스트 출력 start=1 end=5
   public ArrayList<ParkmoaBoardDTO> listPage(String flag, int start, int end, String searchColumn, String searchWord);

   public ArrayList<PaymentDTO> paymentlistPage(int start, int end, String searchWord);

   // 테마파크승인폼리스트
   public int getTotalCount2(String searchWord);

   // 게시물페이지2
   public ArrayList<ThemeParkDTO> listPage2(int start, int end, String searchWord);

   // 승인폼상세보기
   public ThemeParkDTO Tp_selectView(int tp_idx);

   // 승인폼등록
   public int insertWrite(ThemeParkDTO themeParkDTO);

   // 테마파크등록신청
   public int applyTp(String m_id, String tp_name, String tp_phone, String orginalName, String saveFileName,
         String tp_addr1, String tp_content, String tp_category, String tp_parkregi, int p_num);

   // 승인폼삭제
   public int deleteConfrim(int tp_idx);

   // 상세보기
   public ThemeParkDTO boardSelect(int tp_idx);

   // 회원리스트카운트
   public int getTotalCount3(String flag, String searchColumn, String searchWord);

   // 회원 리스트출력
   public ArrayList<ParkmoaMemberDTO> listPage3(String flag, int start, int end, String searchColumn,
         String searchWord);

   // 게시물 비활성화처리(member->slave)
   public int deleteUser(String sChk);

   // 회원 게시판 상세보기
   public ParkmoaMemberDTO MemberView(String m_id);

   // 회원 수정처리
   public int ListEdit(ParkmoaMemberDTO parkmoaMemberDTO);

   // 게시판 삭제
   public int boarddelete(int b_idx);

   // 답변글 입력전 레코드 업데이트
   public int replyprevupdate(ParkmoaBoardDTO parkmoaBoardDTO);

   // 답글쓰기
   public int boardreply(ParkmoaBoardDTO parkmoaBoardDTO);

   // 답글 후 처리여부 확인전 = > 확인 후
   public int alertupdate(ParkmoaBoardDTO parkmoaBoardDTO);

   // 글쓰기(멀티파트)
   public int listwrite(String m_id, String b_title, String b_content, String originalName, String saveFileName,
         String b_flag);

   // 글쓰기(멀티파트아닌게시판)
   public int listwrite1(ParkmoaBoardDTO parkmoaBoardDTO);

   // 글수정하기(멀티파트O)
   public int boardEdit(String m_id, String b_title, String b_content, String originalName, String saveFileName,
         int b_idx);

   // 글수정하기(멀티파트X)
   public int boardEdit1(ParkmoaBoardDTO parkmoaBoardDTO);

   // 답변글
   public int faqcount();

   public int themeregistcount();

   // 로그인처리시
   public String login(String id);

   // 로그인처리시 활성화 비활성화부분 가져오기
   public int selectenabled(String id);

   // authority가져오기
   public String selectauthority(String id);

   // 아이디 중복체크
   public int checkId(String id);

   // 일반 회원가입
   public int registAction(ParkmoaMemberDTO parkmoaMemberDTO);

   // 기업 회원가입
   public int registAction1(ParkmoaMemberDTO parkmoaMemberDTO);

   // 아이디 찾기
   public String findIdAction(ParkmoaMemberDTO parkmoaMemberDTO);

   // 아이디 및 이메일 일치 확인여부
   public String findPwAction(ParkmoaMemberDTO parkmoaMemberDTO);

   // 임시비밀번호 변경
   public void findPwAction2(ParkmoaMemberDTO parkmoaMemberDTO);

   // 마이페이지 정보가져오기
   public ParkmoaMemberDTO myPageselect(String authority, String id);

   // 마이페이지 수정.
   public int mypageUpdate(ParkmoaMemberDTO parkmoaMemberDTO);

   // 갤러리형 리스트 뿌리기
   public ArrayList<ThemeParkDTO> gallerylist(String tp_category, String searchColumn, String searchWord);

   // 리뷰게시판 글쓰기
   public int listwrite2(String m_id, String b_title, String b_content, int tp_idx, int b_rating);

   // 리뷰게시판 글 가져오기
   public List<ParkmoaBoardDTO> selectComment(int tp_idx);

   // 게시물 상세보기
   public ParkmoaBoardDTO boardSelect1(int b_idx);

   // 임시간편 로그인 카카오
   public int emailcheck(String temp);

   // 임시간편 로그인 카카오
   public ParkmoaMemberDTO emailcheck2(String temp);

   // 네이버로그인 사용자확인
   public int selectMember(String m_email);

   // 네이버로그인
   public ParkmoaMemberDTO selectMember1(String m_email);

   // 리스트게시판 상세보기
   public ThemeParkDTO listSelect(int tp_idx);

   // 테마파크 이용권 정보 조회
   public ArrayList<TicketsDTO> ticketList(int tp_idx);

   // 장바구니 저장
   public int insertRes(String m_id, int t_idx, int r_cnt, int t_price, String t_name, String tp_name,
         String r_usedate, int tp_idx);

   // 장바구니 리스트
   public ArrayList<ReservationDTO> reservationList(String m_id);

   // 장바구니 리스트 삭제
   public int cartDelete(int chk);

   // 마이페이지 내가 쓴 리뷰보기
   public ArrayList<ParkmoaBoardDTO> reviewSelectList(String m_id, int start, int end);

   // 마이페이지 리뷰 삭제
   public int reviewDelete(int b_idx);

   // 마이페이지 리뷰 수정
   public int reviewEdit(String b_content, int b_rating, int b_idx);

   // 마이페이지 리뷰정보 모달창뿌리기
   public ParkmoaBoardDTO reviewselect(int b_idx);

   // 내가남긴 리뷰카운터
   public int reviewselectCnt(String m_id);

   // 테마파크 고유번호찾기
   public ThemeParkDTO selectTp_idx(String tp_name);

   // 이용권등록
   public int ticketaffected(int tp_idx, String t_name, int t_price);

   // 리스트별점찍을라고함...
   public ArrayList<ParkmoaBoardDTO> selectboard();

   // 메인리뷰 -> 상세보기 방문수찍기
   public int updatevisitcount(int tp_idx);

   // 장바구니 업데이트
   public int resUpdate(int r_cnt, int r_idx);

   // 결제목록 불러오기
   public ArrayList<PaymentDTO> payListSelect();

   // 주차장 번호 조회
   public int p_idxSelect(int tp_idx);

   // 주차장 정보 조회
   public ParkinginfoDTO p_infoSelect(int tp_idx);

   // 결제목록그룹화 시퀀스값 조회
   public int selectPayGroup();

   // 결제완료 테이블에 insert
   public int paymentInsert(String m_id, int t_idx, String tp_name, String t_name, int totalPrice, String r_useregi,
         int p_num, int pay_group, String m_mobile, String m_email);

   // 결제목록보기
   public ArrayList<PaymentDTO> myPayList(String m_id);

   // 결제대면서 삭제!
   public int deleteResevation(String m_id);

   // 주차장여부가져오기
   public ThemeParkDTO tp_parkregi(int tp_idx);

   // 장바구니 날짜지나면 삭제
   public int deletereservationlist(String r_useregi);

   // 안드로이드
   // 안드로이드 아이디 찾기용
   public ParkmoaMemberDTO androidDtoAction(String id);

   // 안드로이드 비밀번호 찾기용
   public ParkmoaMemberDTO androidFindPwAction(ParkmoaMemberDTO pw);

   // 안드로이드 구매내역리스트
   public ArrayList<PaymentDTO> PaymentList(String id);

   // 안드로이드 개인정보 전송
   public ArrayList<ParkmoaMemberDTO> PersonInfo(String id);

   // QR코드입력
   public int qrcode(String m_id, int membership);

   // 안드로이드 테마파크 리스트
   public ArrayList<ThemeParkDTO> androidList(String tp_name);

   // 안드로이드 테마파크 리스트보기
   public ArrayList<ThemeParkDTO> selectTplist(String tp_category);

   // 안드로이드 테마파크 상세보기
   public ThemeParkDTO selectTplistView(int tp_idx);

   // 결제시 마일리지 적립
   public int updatemembership(int m_membership, String m_id);
   
   // 내 주차 정보보기
   public ArrayList<PaymentDTO> parkingHistorySelect(String m_id);

}