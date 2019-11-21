package parkmoa.model;

import java.util.ArrayList;

public interface ParkmoaImpl {

	// 관리자 토털회원카운트
	public int totalmembercount();

	// 관리자 일반회원카운트
	public int membercount();

	// 관리자 기업회원카운트
	public int companycount();

	// 관리자 비활성화회원카운트
	public int slavecount();

	// 관리자 답글카운트
	public int faqcount();

	// 관리자 테마파크카운트
	public int themeregistcount();

	// 테마파크게시물카운트
	public int getTotalCount(String flag, String searchColumn, String searchWord);

	// start end값을 사용하여 리스트 출력 start=1 end=5
	public ArrayList<ParkmoaBoardDTO> listPage(String flag, int start, int end, String searchColumn, String searchWord);

	// 결제리스트
	public int getTotalCount1(String searchColumn,String searchWord);

	public ArrayList<PaymentDTO> paymentlistPage(int start, int end, String searchColumn,String searchWord);

	// 테마파크승인폼리스트
	public int getTotalCount2(String searchWord);

	// 게시물페이지2
	public ArrayList<ThemeParkDTO> listPage2(int start, int end, String searchWord);

	// 승인폼상세보기
	public ThemeParkDTO Tp_selectView(int tp_idx);

	// 스인폼등록
	public int insertWrite(int tp_idx);

	// 승인폼삭제
	public int deleteConfrim(int tp_idx);

	// 상세보기
	public ParkmoaBoardDTO boardSelect(int idx);

	// 회원리스트카운트
	public int getTotalCount3(String flag, String searchColumn, String searchWord);

	// 회원 리스트출력
	public ArrayList<ParkmoaMemberDTO> listPage3(String flag, int start, int end, String searchColumn,
			String searchWord);

	// 게시물 비활성화처리(enabled=>0)
	public int deleteUser(String sChk);

	// 회원 활성화처리(enabled=>1)
	public int enabledUser(String sChk);

	// 회원 게시판 상세보기
	public ParkmoaMemberDTO MemberView(String m_id);

	// 회원 수정처리
	public int ListEdit(ParkmoaMemberDTO parkmoaMemberDTO);

	// 게시판 삭제
	public int boarddelete(int b_idx);

	// 게시판 삭제시 댓글달린거 있으면 삭제 ^^
	public int boardreplydelete(int b_idx);

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

	// 어드민에서 테마파크관리자 등록하기
	public int adminthemeRegist(String m_id, String tp_name, String tp_phone, String tp_realfilename, String tp_attach,
			String tp_addr1, String tp_content, String tp_category, String tp_parkregi);

	// 테마파크 카운터
	public int getTotalCount4(String flag, String searchColumn, String searchWord);

	// 테마파크 페이지 4
	public ArrayList<ThemeParkDTO> listPage4(String flag, int start, int end, String searchColumn, String searchWord);

	// 테마파크 상세보기
	public ThemeParkDTO themeSelect(int tp_idx);

	// 테마파크 삭제하기
	public int themeDelete(int tp_idx);

	// 이용권리스트카운트
	public int getTotalCount5(String searchColumn, String searchWord);

	// 회원 리스트출력
	public ArrayList<TicketsDTO> ticketlistPage(int start, int end, String searchColumn,
			String searchWord);
	
	//이용권 상세보기뷰
	public TicketsDTO ticketsview(int t_idx);
	
	//이용권 카테고리불러오기
	public String tp_categoryselect(int tp_idx);
	
	//이용권 삭제
	public int ticketsDelete(int t_idx);
	
	//이용권 수정
	public int ticketedit(TicketsDTO ticketsDTO);
	
	//상세보기 이용권불러오기
	public ArrayList<TicketsDTO> ticketlists(int tp_idx);
	
	//테마파크삭제시 해당테마파크에 있는 리뷰 삭제
	public int reviewdelete(int tp_idx);
	
	//결제내역 상세보기
	public ArrayList<PaymentDTO> paymentViewPage(String m_id);

}