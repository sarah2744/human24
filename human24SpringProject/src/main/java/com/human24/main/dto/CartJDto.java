package com.human24.main.dto;

public class CartJDto {
   // booklist 테이블
   private String booknum;
   private String booktitle;
   private String price;
   private String dis_index;
   private String dis_per;
   
   // cart 테이블
   private int cart_count;
   
   
   public CartJDto(String booknum, String booktitle, String price, String dis_index, int cart_count, String dis_per) {
      this.booknum = booknum;
      this.booktitle = booktitle;
      this.price = price;
      this.dis_index = dis_index;
      this.cart_count = cart_count;
      this.dis_per = dis_per;
   }



   public CartJDto(){
      
   }


   public String getDis_per() {
      return dis_per;
   }

   public void setDis_per(String dis_per) {
      this.dis_per = dis_per;
   }
   
   public String getBooknum() {
      return booknum;
   }

   public void setBooknum(String booknum) {
      this.booknum = booknum;
   }

   public String getBooktitle() {
      return booktitle;
   }

   public void setBooktitle(String booktitle) {
      this.booktitle = booktitle;
   }

   public String getPrice() {
      return price;
   }

   public void setPrice(String price) {
      this.price = price;
   }

   public String getDis_index() {
      return dis_index;
   }

   public void setDis_index(String dis_index) {
      this.dis_index = dis_index;
   }

   public int getCart_count() {
      return cart_count;
   }

   public void setCart_count(int cart_count) {
      this.cart_count = cart_count;
   }
}