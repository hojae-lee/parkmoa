package parkmoa.model;

public class TicketsDTO {

	private int t_idx;
	private String t_name;
	private int t_price;
	private int tp_idx;

	public TicketsDTO() {
	}

	public TicketsDTO(int t_idx, String t_name, int t_price, int tp_idx) {
		super();
		this.t_idx = t_idx;
		this.t_name = t_name;
		this.t_price = t_price;
		this.tp_idx = tp_idx;
	}

	public int getT_idx() {
		return t_idx;
	}

	public void setT_idx(int t_idx) {
		this.t_idx = t_idx;
	}

	public String getT_name() {
		return t_name;
	}

	public void setT_name(String t_name) {
		this.t_name = t_name;
	}

	public int getT_price() {
		return t_price;
	}

	public void setT_price(int t_price) {
		this.t_price = t_price;
	}

	public int getTp_idx() {
		return tp_idx;
	}

	public void setTp_idx(int tp_idx) {
		this.tp_idx = tp_idx;
	}

}
