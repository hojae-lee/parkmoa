package parkmoa.model;

public class PaymentDTO {

	private int pay_idx;
	private int p_idx;
	private String m_id;
	private String m_email;
	private String m_mobile;
	private String pay_cnt;
	private String t_name;
	private int pay_price;
	private String r_useregi;
	private String tp_name;
	private String pay_regidate;
	private int tp_idx;
	private int p_num;
	private int pay_group;

	public PaymentDTO() {
	}

	public PaymentDTO(int pay_idx, int p_idx, String m_id, String m_email, String m_mobile, String pay_cnt,
			String t_name, int pay_price, String r_useregi, String tp_name, String pay_regidate, int tp_idx, int p_num,
			int pay_group) {
		super();
		this.pay_idx = pay_idx;
		this.p_idx = p_idx;
		this.m_id = m_id;
		this.m_email = m_email;
		this.m_mobile = m_mobile;
		this.pay_cnt = pay_cnt;
		this.t_name = t_name;
		this.pay_price = pay_price;
		this.r_useregi = r_useregi;
		this.tp_name = tp_name;
		this.pay_regidate = pay_regidate;
		this.tp_idx = tp_idx;
		this.p_num = p_num;
		this.pay_group = pay_group;
	}

	public int getPay_idx() {
		return pay_idx;
	}

	public void setPay_idx(int pay_idx) {
		this.pay_idx = pay_idx;
	}

	public int getP_idx() {
		return p_idx;
	}

	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getM_mobile() {
		return m_mobile;
	}

	public void setM_mobile(String m_mobile) {
		this.m_mobile = m_mobile;
	}

	public String getPay_cnt() {
		return pay_cnt;
	}

	public void setPay_cnt(String pay_cnt) {
		this.pay_cnt = pay_cnt;
	}

	public String getT_name() {
		return t_name;
	}

	public void setT_name(String t_name) {
		this.t_name = t_name;
	}

	public int getPay_price() {
		return pay_price;
	}

	public void setPay_price(int pay_price) {
		this.pay_price = pay_price;
	}

	public String getR_useregi() {
		return r_useregi;
	}

	public void setR_useregi(String r_useregi) {
		this.r_useregi = r_useregi;
	}

	public String getTp_name() {
		return tp_name;
	}

	public void setTp_name(String tp_name) {
		this.tp_name = tp_name;
	}

	public String getPay_regidate() {
		return pay_regidate;
	}

	public void setPay_regidate(String pay_regidate) {
		this.pay_regidate = pay_regidate;
	}

	public int getTp_idx() {
		return tp_idx;
	}

	public void setTp_idx(int tp_idx) {
		this.tp_idx = tp_idx;
	}

	public int getP_num() {
		return p_num;
	}

	public void setP_num(int p_num) {
		this.p_num = p_num;
	}

	public int getPay_group() {
		return pay_group;
	}

	public void setPay_group(int pay_group) {
		this.pay_group = pay_group;
	}

}