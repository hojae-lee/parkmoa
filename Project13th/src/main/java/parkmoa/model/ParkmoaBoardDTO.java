package parkmoa.model;

import java.sql.Date;

public class ParkmoaBoardDTO {

   private int b_idx;
   private String m_id;
   private String b_title;
   private String b_content;
   private String b_attachedfile;
   private java.sql.Date b_regidate;
   private int b_bgroup;
   private int b_bstep;
   private int b_bindent;
   private int b_rating;
   private String b_flag;
   private int b_alert;
   private String b_realfilename;
   private String b_parkregi;
   private String b_phone;
   private String b_addr1;
   
   public ParkmoaBoardDTO() {}

   public ParkmoaBoardDTO(int b_idx, String m_id, String b_title, String b_content, String b_attachedfile,
         Date b_regidate, int b_bgroup, int b_bstep, int b_bindent, int b_rating, String b_flag, int b_alert,
         String b_realfilename, String b_parkregi, String b_phone, String b_addr1) {
      super();
      this.b_idx = b_idx;
      this.m_id = m_id;
      this.b_title = b_title;
      this.b_content = b_content;
      this.b_attachedfile = b_attachedfile;
      this.b_regidate = b_regidate;
      this.b_bgroup = b_bgroup;
      this.b_bstep = b_bstep;
      this.b_bindent = b_bindent;
      this.b_rating = b_rating;
      this.b_flag = b_flag;
      this.b_alert = b_alert;
      this.b_realfilename = b_realfilename;
      this.b_parkregi = b_parkregi;
      this.b_phone = b_phone;
      this.b_addr1 = b_addr1;
   }

   public int getB_idx() {
      return b_idx;
   }

   public void setB_idx(int b_idx) {
      this.b_idx = b_idx;
   }

   public String getM_id() {
      return m_id;
   }

   public void setM_id(String m_id) {
      this.m_id = m_id;
   }

   public String getB_title() {
      return b_title;
   }

   public void setB_title(String b_title) {
      this.b_title = b_title;
   }

   public String getB_content() {
      return b_content;
   }

   public void setB_content(String b_content) {
      this.b_content = b_content;
   }

   public String getB_attachedfile() {
      return b_attachedfile;
   }

   public void setB_attachedfile(String b_attachedfile) {
      this.b_attachedfile = b_attachedfile;
   }

   public java.sql.Date getB_regidate() {
      return b_regidate;
   }

   public void setB_regidate(java.sql.Date b_regidate) {
      this.b_regidate = b_regidate;
   }

   public int getB_bgroup() {
      return b_bgroup;
   }

   public void setB_bgroup(int b_bgroup) {
      this.b_bgroup = b_bgroup;
   }

   public int getB_bstep() {
      return b_bstep;
   }

   public void setB_bstep(int b_bstep) {
      this.b_bstep = b_bstep;
   }

   public int getB_bindent() {
      return b_bindent;
   }

   public void setB_bindent(int b_bindent) {
      this.b_bindent = b_bindent;
   }

   public int getB_rating() {
      return b_rating;
   }

   public void setB_rating(int b_rating) {
      this.b_rating = b_rating;
   }

   public String getB_flag() {
      return b_flag;
   }

   public void setB_flag(String b_flag) {
      this.b_flag = b_flag;
   }

   public int getB_alert() {
      return b_alert;
   }

   public void setB_alert(int b_alert) {
      this.b_alert = b_alert;
   }

   public String getB_realfilename() {
      return b_realfilename;
   }

   public void setB_realfilename(String b_realfilename) {
      this.b_realfilename = b_realfilename;
   }

   public String getB_parkregi() {
      return b_parkregi;
   }

   public void setB_parkregi(String b_parkregi) {
      this.b_parkregi = b_parkregi;
   }

   public String getB_phone() {
      return b_phone;
   }

   public void setB_phone(String b_phone) {
      this.b_phone = b_phone;
   }

   public String getB_addr1() {
      return b_addr1;
   }

   public void setB_addr1(String b_addr1) {
      this.b_addr1 = b_addr1;
   }


}