package parkmoa.model;

public class ParkinginfoDTO {

   private int p_idx;
   private String p_code;
   private int p_repeatNum;
   private String[] p_content;

   public ParkinginfoDTO () {}

   public ParkinginfoDTO(int p_idx, String p_code, int p_repeatNum, String[] p_content) {
      super();
      this.p_idx = p_idx;
      this.p_code = p_code;
      this.p_repeatNum = p_repeatNum;
      this.p_content = p_content;
   }

   public int getP_idx() {
      return p_idx;
   }

   public void setP_idx(int p_idx) {
      this.p_idx = p_idx;
   }

   public String getP_code() {
      return p_code;
   }

   public void setP_code(String p_code) {
      this.p_code = p_code;
   }

   public int getP_repeatNum() {
      return p_repeatNum;
   }

   public void setP_repeatNum(int p_repeatNum) {
      this.p_repeatNum = p_repeatNum;
   }

   public String[] getP_content() {
      return p_content;
   }

   public void setP_content(String[] p_content) {
      this.p_content = p_content;
   }
}