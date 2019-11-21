package parkmoa.model;

import java.sql.Date;

public class ReservationDTO {

	private int r_idx;
	private String m_id;
	private String tp_name;
	private String t_name;
	private int t_idx;
	private int r_cnt;
	private int t_price;
	private String r_useregi;
	private String r_regi;
	private int tp_idx;

	public ReservationDTO() {
	}

	public ReservationDTO(int r_idx, String m_id, String tp_name, String t_name, int t_idx, int r_cnt, int t_price,
			String r_useregi, String r_regi, int tp_idx) {
		super();
		this.r_idx = r_idx;
		this.m_id = m_id;
		this.tp_name = tp_name;
		this.t_name = t_name;
		this.t_idx = t_idx;
		this.r_cnt = r_cnt;
		this.t_price = t_price;
		this.r_useregi = r_useregi;
		this.r_regi = r_regi;
		this.tp_idx = tp_idx;
	}

	public int getR_idx() {
		return r_idx;
	}

	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
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

	public String getT_name() {
		return t_name;
	}

	public void setT_name(String t_name) {
		this.t_name = t_name;
	}

	public int getT_idx() {
		return t_idx;
	}

	public void setT_idx(int t_idx) {
		this.t_idx = t_idx;
	}

	public int getR_cnt() {
		return r_cnt;
	}

	public void setR_cnt(int r_cnt) {
		this.r_cnt = r_cnt;
	}

	public int getT_price() {
		return t_price;
	}

	public void setT_price(int t_price) {
		this.t_price = t_price;
	}

	public String getR_useregi() {
		return r_useregi;
	}

	public void setR_useregi(String r_useregi) {
		this.r_useregi = r_useregi;
	}

	public String getR_regi() {
		return r_regi;
	}

	public void setR_regi(String r_regi) {
		this.r_regi = r_regi;
	}

	public int getTp_idx() {
		return tp_idx;
	}

	public void setTp_idx(int tp_idx) {
		this.tp_idx = tp_idx;
	}
	

}