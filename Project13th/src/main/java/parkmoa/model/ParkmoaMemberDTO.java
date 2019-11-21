package parkmoa.model;

import java.sql.Date;

public class ParkmoaMemberDTO {

	private String m_id; 
    private String m_name;
    private String m_pw;
    private String m_mobile;
    private String m_email;
    private java.sql.Date m_regidate;
    private String authority;
    private int m_membership;
    private int enabled;
    
    public ParkmoaMemberDTO() {}

	public ParkmoaMemberDTO(String m_id, String m_name, String m_pw, String m_mobile, String m_email, Date m_regidate,
			String authority, int m_membership, int enabled) {
		super();
		this.m_id = m_id;
		this.m_name = m_name;
		this.m_pw = m_pw;
		this.m_mobile = m_mobile;
		this.m_email = m_email;
		this.m_regidate = m_regidate;
		this.authority = authority;
		this.m_membership = m_membership;
		this.enabled = enabled;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_pw() {
		return m_pw;
	}

	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}

	public String getM_mobile() {
		return m_mobile;
	}

	public void setM_mobile(String m_mobile) {
		this.m_mobile = m_mobile;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public java.sql.Date getM_regidate() {
		return m_regidate;
	}

	public void setM_regidate(java.sql.Date m_regidate) {
		this.m_regidate = m_regidate;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public int getM_membership() {
		return m_membership;
	}

	public void setM_membership(int m_membership) {
		this.m_membership = m_membership;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
    
    
	
}
