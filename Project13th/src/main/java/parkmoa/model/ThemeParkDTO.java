package parkmoa.model;

import java.sql.Date;

public class ThemeParkDTO {

	private int tp_idx;
	private String m_id;
	private String tp_name;
	private String tp_phone;
	private String tp_attach;
	private String tp_addr1;
	private String tp_content;
	private java.sql.Date tp_regidate;
	private String tp_category;
	private String tp_parkregi;
	private String tp_realfilename;
	private int tp_confirm;
	private int tp_visitcount;
	private int p_idx;

	public ThemeParkDTO() {
	}

	public ThemeParkDTO(int tp_idx, String m_id, String tp_name, String tp_phone, String tp_attach, String tp_addr1,
			String tp_content, Date tp_regidate, String tp_category, String tp_parkregi, String tp_realfilename,
			int tp_confirm, int tp_visitcount, int p_idx) {
		super();
		this.tp_idx = tp_idx;
		this.m_id = m_id;
		this.tp_name = tp_name;
		this.tp_phone = tp_phone;
		this.tp_attach = tp_attach;
		this.tp_addr1 = tp_addr1;
		this.tp_content = tp_content;
		this.tp_regidate = tp_regidate;
		this.tp_category = tp_category;
		this.tp_parkregi = tp_parkregi;
		this.tp_realfilename = tp_realfilename;
		this.tp_confirm = tp_confirm;
		this.tp_visitcount = tp_visitcount;
		this.p_idx = p_idx;
	}

	public int getTp_idx() {
		return tp_idx;
	}

	public void setTp_idx(int tp_idx) {
		this.tp_idx = tp_idx;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getTp_name() {
		return tp_name;
	}

	public void setTp_name(String tp_name) {
		this.tp_name = tp_name;
	}

	public String getTp_phone() {
		return tp_phone;
	}

	public void setTp_phone(String tp_phone) {
		this.tp_phone = tp_phone;
	}

	public String getTp_attach() {
		return tp_attach;
	}

	public void setTp_attach(String tp_attach) {
		this.tp_attach = tp_attach;
	}

	public String getTp_addr1() {
		return tp_addr1;
	}

	public void setTp_addr1(String tp_addr1) {
		this.tp_addr1 = tp_addr1;
	}

	public String getTp_content() {
		return tp_content;
	}

	public void setTp_content(String tp_content) {
		this.tp_content = tp_content;
	}

	public java.sql.Date getTp_regidate() {
		return tp_regidate;
	}

	public void setTp_regidate(java.sql.Date tp_regidate) {
		this.tp_regidate = tp_regidate;
	}

	public String getTp_category() {
		return tp_category;
	}

	public void setTp_category(String tp_category) {
		this.tp_category = tp_category;
	}

	public String getTp_parkregi() {
		return tp_parkregi;
	}

	public void setTp_parkregi(String tp_parkregi) {
		this.tp_parkregi = tp_parkregi;
	}

	public String getTp_realfilename() {
		return tp_realfilename;
	}

	public void setTp_realfilename(String tp_realfilename) {
		this.tp_realfilename = tp_realfilename;
	}

	public int getTp_confirm() {
		return tp_confirm;
	}

	public void setTp_confirm(int tp_confirm) {
		this.tp_confirm = tp_confirm;
	}

	public int getTp_visitcount() {
		return tp_visitcount;
	}

	public void setTp_visitcount(int tp_visitcount) {
		this.tp_visitcount = tp_visitcount;
	}

	public int getP_idx() {
		return p_idx;
	}

	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}

}