package com.human24.main;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.human24.main.dto.AdminBoardConfigDto;
import com.human24.main.dto.GenreDto;
import com.human24.main.dto.MemberDto;
import com.human24.main.dto.bookDto;
import com.human24.main.idao.IMDao;
import com.human24.main.idao.StatisticsIDao;
import com.human24.main.idao.adminBoardConfigIDao;
import com.human24.main.idao.adminIDao;
import com.human24.main.idao.bookIDao;

@Controller
public class adminController {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	/* 관리자 로그인 */
	
	@RequestMapping("/admin/login")
	public String admin_login() {
		return "admin_login";
	}
	
	@RequestMapping(method = { RequestMethod.POST }, value = "admin/adminLogin")
	public String login(Model model, HttpServletRequest hsr) {
		String admin_id = hsr.getParameter("admin_id");
		model.addAttribute("admin_id", admin_id);
		return "admin_loginDo";
	}
	
	@RequestMapping(value = "/main/admin/loginCheck", method = RequestMethod.GET)
	@ResponseBody
	public int loginCheck(@RequestParam("admin_id") String admin_id, @RequestParam("userPwd") String userPwd) {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		return dao.loginCheck(admin_id, userPwd);
	}
	
	/* 유저 관리 */
	
	@RequestMapping("/admin/user/list")
	public String admin_user_list(Model model, HttpServletRequest hsr) throws UnsupportedEncodingException {
		
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		int nowPage = 1;
		
		String admin_index = hsr.getParameter("admin_index");
		String nowPageString = hsr.getParameter("nowPage");
		String sel = hsr.getParameter("sel");
		
		if (admin_index == null || admin_index == "" || admin_index == "undefined") admin_index = "0"; 
		if (nowPageString == null || nowPageString == "" || nowPageString == "undefined") nowPage = 1;
		else nowPage = Integer.parseInt(nowPageString);
		
		int totalPage = 0;
		ArrayList<MemberDto> memberDto = new ArrayList<MemberDto>();
		
		if (sel == null || sel == "" || sel == "undefined") { // 검색이 아닐 경우
			int totalcnt = dao.memberCount(admin_index);
			
			totalPage = totalcnt / 10;
			if (totalcnt % 10 != 0) totalPage++;
			
			if (nowPage == totalPage) memberDto = dao.memberSelect(admin_index, ((nowPage * 10) - 9), totalcnt);
			else memberDto = dao.memberSelect(admin_index, ((nowPage * 10) - 9), (nowPage * 10));
		}else { // 검색일 경우
			int totalcnt = dao.schMemberCount(admin_index, sel, hsr.getParameter("schText"));
			String schText = new String(hsr.getParameter("schText").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
			totalPage = totalcnt / 10;
			if (totalcnt % 10 != 0) totalPage++;
			
			if (nowPage == totalPage) memberDto = dao.schMemberSelect(admin_index, sel, schText, ((nowPage * 10) - 9), totalcnt);
			else memberDto = dao.schMemberSelect(admin_index, sel, schText, ((nowPage * 10) - 9), (nowPage * 10));
		}
		
		model.addAttribute("admin_index", admin_index);
		model.addAttribute("memberList", memberDto);
		model.addAttribute("noticeLength", dao.memberCount(admin_index));
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("nowPage", nowPage);
		
		return "admin_user_list";
	}
	
	@RequestMapping("/admin/user/detail")
	public String admin_user_detail(Model model, HttpServletRequest hsr) {
		String user_id = hsr.getParameter("user_id");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		model.addAttribute("memberList", dao.memberSelect4(user_id));
		return "admin_user_detail";
	}
	
	/******** 회원 권한 부여 ************/
	@RequestMapping("/admin/rank")
	@ResponseBody
	public void commentDel(Model model, HttpServletRequest hsr) {
		String admin_index = hsr.getParameter("admin_index");
		String user_id = hsr.getParameter("user_id");
		int admin_index2 = Integer.parseInt(admin_index);
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		dao.memberUpdate(admin_index2, user_id);
	}
	
	/* 게시판 관리 */
	
	@RequestMapping("/admin/board/list")
	public String admin_board_list(Model model) {
		adminBoardConfigIDao dao = sqlSession.getMapper(adminBoardConfigIDao.class);
		ArrayList<AdminBoardConfigDto> arr = dao.boardAllList();
	    model.addAttribute("boardlist", arr);
		return "admin_board_list";
	}
	
	@RequestMapping("/admin/board/detail")
	public String admin_board_detail() {
		return "admin_board_detail";
	}
	
	@RequestMapping("/admin/board/configView")
	public String admin_board_config(Model model,  HttpServletRequest hsr) {
		adminBoardConfigIDao dao = sqlSession.getMapper(adminBoardConfigIDao.class);
		String boardIndex = hsr.getParameter("boardIndex");
		int boardIndexEx = Integer.parseInt(boardIndex);
		ArrayList<AdminBoardConfigDto> arr = dao.boardConfigList(boardIndexEx);
	    model.addAttribute("bdName", arr.get(0).getBoard_name());
	    model.addAttribute("bdNum", arr.get(0).getBoard_index());
	    model.addAttribute("presense", arr.get(0).getPresence());
	    model.addAttribute("paging", arr.get(0).getPaging());
	    model.addAttribute("deleteCompl", arr.get(0).getDelete_compl());
	    model.addAttribute("writeAuth", arr.get(0).getWrite_auth());
	    model.addAttribute("writeCompl", arr.get(0).getWriter_compl());
	    model.addAttribute("mobileCompl", arr.get(0).getMobile_compl());
	    model.addAttribute("emailCompl", arr.get(0).getEmail_compl());
	    model.addAttribute("emailReceive", arr.get(0).getEmail_receive());
	    model.addAttribute("dateCompl", arr.get(0).getDate_compl());
	    model.addAttribute("replyCompl", arr.get(0).getReply_compl());
	    model.addAttribute("commentCompl", arr.get(0).getComment_compl());
	    model.addAttribute("commentAuth", arr.get(0).getComment_auth());
	    model.addAttribute("securityCompl", arr.get(0).getSecurity_compl());
		return "admin_board_config";
	}


	@RequestMapping(value = "/admin/board/listCount", method = RequestMethod.GET)
	@ResponseBody
	public int boardListCount(@RequestParam("boardIndex") String boardIndex) {
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		return dao.NoticeCount(boardIndex);
	}
	
	@RequestMapping(value = "/admin/board/update")
	public void admin_board_update(HttpServletResponse response, HttpServletRequest hsr) throws IOException {
		String bdName = new String(hsr.getParameter("bdName").getBytes("ISO-8859-1"), "UTF-8");
		int bdNum = Integer.parseInt(hsr.getParameter("bdNum"));
		String presence = hsr.getParameter("presence");
		int paging = Integer.parseInt(hsr.getParameter("paging"));
		String deleteCompl = hsr.getParameter("deleteCompl");
		String writeAuth = hsr.getParameter("writeAuth");
		String writerCompl = hsr.getParameter("writerCompl");
		String mobileCompl = hsr.getParameter("mobileCompl");
		String emailCompl = hsr.getParameter("emailCompl");
		String emailReceive = hsr.getParameter("emailReceive");
		String dateCompl = hsr.getParameter("dateCompl");
		String replyCompl = hsr.getParameter("replyCompl");
		String commentCompl = hsr.getParameter("commentCompl");
		String commentAuth = hsr.getParameter("commentAuth");
		String securityCompl = hsr.getParameter("securityCompl");
		adminBoardConfigIDao configDao = sqlSession.getMapper(adminBoardConfigIDao.class);
		configDao.boardConfigUpdate(bdName, presence, paging, deleteCompl, writeAuth, writerCompl, mobileCompl, emailCompl, emailReceive, dateCompl, replyCompl, commentCompl, commentAuth, securityCompl, bdNum);
		response.sendRedirect("list");
	}
	
	/* 도서 관리 */
	
	@RequestMapping("/admin/book/list")
	public String admin_book_list(Model model, HttpServletRequest hsr) throws UnsupportedEncodingException {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);

		int nowPage = 1;
		
		String nowPageString = hsr.getParameter("nowPage");
		String call = hsr.getParameter("call");
		
		String order = hsr.getParameter("order");
		
		if (order == null || order == "" || order == "undefined") order = "default";
		if (call == null || call == "" || call == "undefined") call = "all";
		if (nowPageString == null || nowPageString == "" || nowPageString == "undefined") nowPage = 1;
		else nowPage = Integer.parseInt(nowPageString);
		
		int totalPage = 0;
		ArrayList<bookDto> bookDto= new ArrayList<bookDto>();
		
		String field = "";
		String value = "";
		if(call.equals("all")) {
			field = "1";
			value = "1";
		}else if(call.equals("mainGenre")) {
			field = "main_genre";
			value = new String(hsr.getParameter("mainGenre").getBytes("ISO-8859-1"), "UTF-8");
			model.addAttribute("mainGenre", hsr.getParameter("mainGenre"));
			model.addAttribute("genreName", value);
		}else if(call.equals("subGenre")) {
			field = "genre";
			value = new String(hsr.getParameter("subGenre").getBytes("ISO-8859-1"), "UTF-8");
			model.addAttribute("subGenre", hsr.getParameter("subGenre"));
			model.addAttribute("genreName", value);
		}else if(call.equals("sch")) {
			field = hsr.getParameter("sel");
			value = new String(hsr.getParameter("schText").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
			model.addAttribute("sel", field);
			model.addAttribute("schText", value);
		}
		int totalcnt = dao.bookCount(field, value);
		
		totalPage = totalcnt / 10;
		if (totalcnt % 10 != 0) totalPage++;
		
		if (nowPage == totalPage) bookDto = dao.genreSelect(field, value, ((nowPage * 10) - 9), totalcnt, order);
		else bookDto = dao.genreSelect(field, value, ((nowPage * 10) - 9), (nowPage * 10), order);
		
		model.addAttribute("bookList", bookDto);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("call", call);
		model.addAttribute("order", order);
		
		return "admin_book_list";
	}
	
	@RequestMapping("/admin/book/list2")
	public void admin_book_list2(Model model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		String booknum = hsr.getParameter("booknum");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		dao.genreDelete(booknum);
		response.sendRedirect("/main/admin/book/list"); 
	}
	
	@RequestMapping("/admin/book/detail")
	public String admin_book_detail(Model model, HttpServletRequest hsr) {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		String booknum = hsr.getParameter("booknum");
		
		model.addAttribute("bookdetail", dao.detailSelect(booknum));
		
		return "admin_book_detail";
	}	
	
	@RequestMapping("/admin/book/add")
	public String admin_book_add(Model model, HttpServletRequest hsr) {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		model.addAttribute("genreMain", dao.genreMain());
		return "admin_book_add";
	}
	
	@RequestMapping("/admin/book/modify")
	public String admin_book_modify(Model model, HttpServletRequest hsr) {
		String booknum = hsr.getParameter("booknum");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		model.addAttribute("bookmodify", dao.detailSelect(booknum));
		model.addAttribute("genreMain", dao.genreMain());
		return "admin_book_modify";
	}
	
	
	@RequestMapping(method = { RequestMethod.POST }, value = "/admin/book/bookModify")
	public void bookModify(Model model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		String booknum = hsr.getParameter("booknum");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		
		String sub_genre_name = hsr.getParameter("sub_genre");
		String booktitle = hsr.getParameter("booktitle");
		String writer = hsr.getParameter("writer");
		String publisher = hsr.getParameter("publisher");
		String price = hsr.getParameter("price");
		double dis_per = Integer.parseInt(hsr.getParameter("dis_per"));
		String dis_index = hsr.getParameter("dis_index");
		String book_intro = hsr.getParameter("book_intro");
		String main_genre = hsr.getParameter("main_genre");
		
		dis_per = ((100-dis_per)*0.01);
		dao.bookModify(sub_genre_name, booktitle, writer, publisher, price, dis_per, dis_index, book_intro, main_genre, booknum);
		
		response.sendRedirect("/main/admin/book/detail?booknum="+booknum);
	}
	
	@RequestMapping(method = { RequestMethod.POST }, value = "/admin/book/bookInsert")
	public void bookInsert(Model model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		
		String sub_genre_name = hsr.getParameter("sub_genre");
		String booktitle = hsr.getParameter("booktitle");
		String writer = hsr.getParameter("writer");
		String publisher = hsr.getParameter("publisher");
		String price = hsr.getParameter("price");
		double dis_per = Integer.parseInt(hsr.getParameter("dis_per"));
		String dis_index = hsr.getParameter("dis_index");
		String book_intro = hsr.getParameter("book_intro");
		String main_genre = hsr.getParameter("main_genre");
		
		dis_per = ((100-dis_per)*0.01);
		
		dao.bookInsert(sub_genre_name, booktitle, writer, publisher, price, dis_per, dis_index, book_intro, main_genre);
		
		String booknum = dao.bookInsertGetBooknum(sub_genre_name, booktitle, writer, publisher, price, dis_per, dis_index, book_intro);
		response.sendRedirect("/main/admin/book/detail?booknum="+booknum);
	}
	
	@RequestMapping("/admin/book/weekDiscount")
	public String admin_book_weekDiscount() {
		return "admin_book_weekDiscount";
	}
	
	@RequestMapping("/admin/book/discountBook")
	public String admin_book_discountBook() {
		return "admin_book_discountBook";
	}
	
	@RequestMapping("/admin/book/genreSelectPopup")
	public String admin_book_genreSelectPopup(Model model) {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		model.addAttribute("mainGenre", dao.genreMain());

		return "admin_book_genreSelectPopup";
	}

	@RequestMapping(value="/admin/book/popup", method=RequestMethod.POST)
	@ResponseBody
	public void admin_book_popup(HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);

		ArrayList<GenreDto> subGenreList = dao.genreSub("main_genre_num", hsr.getParameter("main_genre_num"));
		PrintWriter out = response.getWriter();		
		Gson gson = new Gson();
		String data = gson.toJson(subGenreList);
		
		out.print(data);
	}
	
	@RequestMapping("/admin/book/genreBigList")
	public String admin_book_genreBigList(Model model) {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		model.addAttribute("genre", dao.mGenreSelect());
		return "admin_book_genreBigList";
	}
	
	@RequestMapping("/admin/book/genreBigList2")
	public void admin_book_genreBigList2(Model model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		String main_genre_num = hsr.getParameter("main_genre_num");
		String main_genre_name = hsr.getParameter("main_genre_name");
		if(main_genre_name == "" || main_genre_name == null || main_genre_name == "undefined") main_genre_name = "";
		else main_genre_name = new String(main_genre_name.getBytes("ISO-8859-1"), "UTF-8");
		dao.mgenreBookDelete(main_genre_name);
		dao.mgenreDelete(main_genre_num);
		response.sendRedirect("/main/admin/book/genreBigList"); 
	}
	
	@RequestMapping("/admin/book/genreBigDetail")
	public String admin_book_genreBigDetail(Model model, HttpServletRequest hsr) throws UnsupportedEncodingException {
		String main_genre_num = hsr.getParameter("main_genre_num");
		String num = hsr.getParameter("num");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		if(num.equals("1"))
		{
			model.addAttribute("genre", dao.genreDetail(main_genre_num));			
		}
		else
		{
			String main_genre_name = new String(hsr.getParameter("main_genre_name").getBytes("ISO-8859-1"), "UTF-8");
			String use = hsr.getParameter("use");
			dao.bigUpdate(main_genre_name, use, main_genre_num);
			model.addAttribute("genre", dao.genreDetail(main_genre_num));
		}
		return "admin_book_genreBigDetail";
	}
	
	@RequestMapping("/admin/book/genreBigModify")
	public String admin_book_genreBigModify(Model model, HttpServletRequest hsr) {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		String main_genre_num = hsr.getParameter("main_genre_num");
		model.addAttribute("genre", dao.mgenreSelect(main_genre_num));
		return "admin_book_genreBigModify";
	}
	
	@RequestMapping("/admin/book/genreBigadd")
	public String admin_book_genreBigadd() {
		return "admin_book_genreBigadd";
	}
	
	@RequestMapping("/admin/book/genreSmallList")
	public String admin_book_genreSmallList(Model model, HttpServletRequest hsr) throws UnsupportedEncodingException {
		String main_genre_num = hsr.getParameter("main_genre_num");
		String sub_genre_num = hsr.getParameter("sub_genre_num");
		String sub_genre_name = hsr.getParameter("sub_genre_name");
		if(sub_genre_name == null || sub_genre_name == "" || sub_genre_name == "undefined") sub_genre_name = "";
		else sub_genre_name = new String(sub_genre_name.getBytes("ISO-8859-1"), "UTF-8");
		String num = hsr.getParameter("num");
		
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		
		if(num == null || num == "" || num == "undefined") num = "0";
		if(num.equals("1")) {
			dao.mgenreBookDelete2(sub_genre_name);
			dao.mgenreDelete2(sub_genre_num);	
		}
		
		
		model.addAttribute("main_genre_num", main_genre_num);
		model.addAttribute("genre", dao.subSelect(main_genre_num));
		
		return "admin_book_genreSmallList";
	}

	@RequestMapping("/admin/book/genreSmallDetail")
	public String admin_book_genreSmallDetail(Model model, HttpServletRequest hsr) throws UnsupportedEncodingException {
		String sub_genre_num = hsr.getParameter("sub_genre_num");
		String main_genre_num = hsr.getParameter("main_genre_num");

 
		String use = hsr.getParameter("use");
		String num = hsr.getParameter("num");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		
		if(num.equals("1"))
		{
			model.addAttribute("genre", dao.subSelect2(sub_genre_num));			
		}
		else
		{
			String sub_genre_name = sub_genre_name = new String(hsr.getParameter("sub_genre_name").getBytes("ISO-8859-1"), "UTF-8");
			dao.subUpdate(main_genre_num, sub_genre_name, use, sub_genre_num);
			model.addAttribute("genre", dao.subSelect2(sub_genre_num));
		}
		return "admin_book_genreSmallDetail";
	}
	
	@RequestMapping("/admin/book/genreSmallModify")
	public String admin_book_genreSmallModfy(Model model, HttpServletRequest hsr) {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		String sub_genre_num = hsr.getParameter("sub_genre_num");
		model.addAttribute("genre", dao.subSelect2(sub_genre_num));
		model.addAttribute("genreMain", dao.genreMain());
		return "admin_book_genreSmallModify";
	}
	
	@RequestMapping("/admin/book/genreSmalladd")
	public String admin_book_genreSmalladd(Model model, HttpServletRequest hsr) {
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		String main_genre_num = hsr.getParameter("main_genre_num");
		model.addAttribute("genre", dao.mgenreSelect(main_genre_num));
		return "admin_book_genreSmalladd";
	}
	
	@RequestMapping("/insertGenre")
	@ResponseBody
	public void insertGenre(Model model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		String genreName = new String(hsr.getParameter("genreName").getBytes("ISO-8859-1"), "UTF-8");
		String use = hsr.getParameter("use");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		dao.mgenreInsert(genreName, use);
	}
	
	@RequestMapping("/insertSubGenre")
	@ResponseBody
	public void insertSubGenre(Model model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		String main_genre_num = hsr.getParameter("main_genre_num");
		String sub_genre_name = new String(hsr.getParameter("sub_genre_name").getBytes("ISO-8859-1"), "UTF-8");
		String use = hsr.getParameter("use");
		String main_genre_name = new String(hsr.getParameter("main_genre_name").getBytes("ISO-8859-1"), "UTF-8");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		dao.mgenreInsert2(main_genre_name, main_genre_num, sub_genre_name, use);
	}
	
	@RequestMapping("/admin/genreSub")
	@ResponseBody
	public void genreSub(Model model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		//String main_genre_name = "";
		//if(main_genre_name != null && main_genre_name != "" && main_genre_name != "undefined") main_genre_name = new String(hsr.getParameter("main_genre_name").getBytes("ISO-8859-1"), "UTF-8");
		String main_genre_name = new String(hsr.getParameter("main_genre_name").getBytes("ISO-8859-1"), "UTF-8");
		adminIDao dao = sqlSession.getMapper(adminIDao.class);
		ArrayList<GenreDto> subGenreList = dao.genreSub("main_genre_name", main_genre_name);
		model.addAttribute("subgenre", subGenreList);

		PrintWriter out = response.getWriter();		
		String data = "";
		for(int i = 0; i < subGenreList.size(); i++) {
			if(i == subGenreList.size()-1) 
			{
				data+=(subGenreList.get(i).getSub_genre_name());
				break;
			}
			data+=(subGenreList.get(i).getSub_genre_name()+",");
		}
		out.print(data);
	}
	
	/* 통계 관리 */
	
	@RequestMapping("/admin/statistics/user")
	public String admin_statistics_user(Model model, HttpServletRequest hsr) {
		StatisticsIDao dao = sqlSession.getMapper(StatisticsIDao.class);
		String stat = hsr.getParameter("stat");  
		if(stat == null || stat == "" || stat == "undefined") stat = "age";
		
		if(stat.equals("age")) {
			
			model.addAttribute("ageArr", dao.ageArr(1));
			
		}else if(stat.equals("gender")) {
			
			model.addAttribute("maleCnt", dao.maCnt());
			model.addAttribute("femaleCnt", dao.feCnt());
			
		}else if(stat.equals("ageGender")) {
			
			model.addAttribute("maleArr", dao.ageArr(2));
			model.addAttribute("femaleArr", dao.ageArr(3));
			
		}
		
		
		model.addAttribute("choice",stat);
		return "admin_statistics_user";
	}
	
	@RequestMapping("/admin/statistics/sell")
	public String admin_statistics_sell(Model model, HttpServletRequest hsr) {
		
		StatisticsIDao dao = sqlSession.getMapper(StatisticsIDao.class);
		
		String stat = hsr.getParameter("stat");
		
		if(stat == null || stat == "" || stat == "undefined") stat = "mainGenre";
		
		if(stat.equals("mainGenre")) {
			
			model.addAttribute("mainGenreStat", dao.mainGenreStat(1));
			
		}else if(stat.equals("subGenre")) {
			
			model.addAttribute("subGenreStat", dao.subGenreStat(1));
			
		}else if(stat.equals("mainGenreGender")) {
			
			model.addAttribute("mainGenreMale", dao.mainGenreStat(2));
			model.addAttribute("mainGenreFemale", dao.mainGenreStat(3));
			
		}else if(stat.equals("subGenreGender")) {
			
			model.addAttribute("subGenreMale", dao.subGenreStat(2));
			model.addAttribute("subGenreFemale", dao.subGenreStat(3));
			
		}
		
		model.addAttribute("choice",stat);
		return "admin_statistics_sell";
	}
	
	@RequestMapping("/admin/statistics/login")
	public String admin_statistics_login(Model model, HttpServletRequest hsr) {
		
		Calendar cal = Calendar.getInstance();
		 
		//현재 년도, 월, 일
		int now_year = cal.get(cal.YEAR);
		int now_month = cal.get(cal.MONTH)+1;
		int now_date = cal.get(cal.DATE);

		StatisticsIDao dao = sqlSession.getMapper(StatisticsIDao.class);
		
		String fromDate = hsr.getParameter("fromDate");
		String toDate = hsr.getParameter("toDate");
		
		String stat = hsr.getParameter("stat");

		String statYear = hsr.getParameter("statYear");
		String statMon = hsr.getParameter("statMon");
		
		
		if(fromDate == null || fromDate == "" || fromDate == "undefined") fromDate = now_year+"/"+now_month+"/"+now_date;
		if(toDate == null || toDate == "" || toDate == "undefined") toDate = now_year+"/"+now_month+"/"+now_date;
		if(stat == null || stat == "" || stat == "undefined") stat = "ampm";
	
		
		if(stat.equals("ampm")) {
			model.addAttribute("amList", dao.amList(fromDate, toDate));
			model.addAttribute("pmList", dao.pmList(fromDate, toDate));
		}else if(stat.equals("time")) model.addAttribute("statArr", dao.timeList(fromDate, toDate));
		else if(stat.equals("date")) {
			
			if(Integer.parseInt(statMon) < 10) statMon = "0"+statMon;
			
			model.addAttribute("statArr", dao.dateList(statYear, statMon));
			model.addAttribute("selDate", statYear+"년 "+statMon+"월");
		}
		else if(stat.equals("day")) model.addAttribute("statArr", dao.dayList(fromDate, toDate));
		else if(stat.equals("month")) {
			model.addAttribute("statArr", dao.monthList(fromDate.substring(0,7)+"/01", toDate.substring(0,7)+"/31"));
			model.addAttribute("selDate",fromDate.substring(0,4)+"년 "+ fromDate.substring(5,7) + "월 ~ " + toDate.substring(0,4)+"년 "+ toDate.substring(5,7) + "월");
		}
		else if(stat.equals("year")) {
			model.addAttribute("statArr", dao.yearList(fromDate.substring(0,4)+"/01/01", toDate.substring(0,4)+"/12/31"));
			model.addAttribute("selDate",fromDate.substring(0,4)+"년  ~ " + toDate.substring(0,4)+"년 ");
		}
		
		model.addAttribute("choice",stat);
		
		if(!stat.equals("date") && !stat.equals("month") && !stat.equals("year")) {
			model.addAttribute("selDate",fromDate + " ~ " + toDate);
		}
		
		return "admin_statistics_login";
	}
	
	
	 
	 @RequestMapping("/fileUpEx")
	 public String fileUpEx() {
		 return "fileUpEx";
	 }

	 @RequestMapping(value = "/fileUpload") // method = RequestMethod.GET 
	 public Map fileUpload(HttpServletRequest req, HttpServletResponse rep) {
		 //파일이 저장될 path 설정 
		 String path = "c://temp"; 
		 Map returnObject = new HashMap();
		 try { 
			 // MultipartHttpServletRequest 생성 
			 MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req; 
			 Iterator iter = mhsr.getFileNames(); 
			 
			 MultipartFile mfile = null; 
			 String fieldName = ""; 
			 List resultList = new ArrayList(); // 디레토리가 없다면 생성 
			 File dir = new File(path); 
			 if (!dir.isDirectory()) dir.mkdirs(); 
			 
			 // 값이 나올때까지 
			 while (iter.hasNext()) { 
				 fieldName = (String) iter.next(); // 내용을 가져와서
				 mfile = mhsr.getFile(fieldName); 
				 String origName; 
				 origName = new String(mfile.getOriginalFilename().getBytes("8859_1"), "UTF-8"); //한글꺠짐 방지 
				 
				 // 파일명이 없다면 
				 if ("".equals(origName)) continue; 
				 
				 // 파일 명 변경(uuid로 암호화) 
				 String ext = origName.substring(origName.lastIndexOf('.')); // 확장자
				 String saveFileName = getUuid() + ext; 
				 
				 // 설정한 path에 파일저장 
				 File serverFile = new File(path + File.separator + saveFileName);
				 mfile.transferTo(serverFile); 
				 
				 Map file = new HashMap(); 
				 file.put("origName", origName); 
				 file.put("sfile", serverFile); 
				 resultList.add(file); 
				 
			} 
			returnObject.put("files", resultList); 
			returnObject.put("params", mhsr.getParameterMap()); 
			
		 }catch (UnsupportedEncodingException e) { 
			 // TODO Auto-generated catch block 
			 e.printStackTrace(); 
		 }catch (IllegalStateException e) { 
			 // TODO Auto-generated catch block 
			 e.printStackTrace(); 
		 }catch (IOException e) { 
			 // TODO Auto-generated catch block 
			 e.printStackTrace();
		 } 
		 return null; 
	 } 
	 
	 //uuid생성
	 public static String getUuid() {
		 return UUID.randomUUID().toString().replaceAll("-", ""); 
	 }
			

}
