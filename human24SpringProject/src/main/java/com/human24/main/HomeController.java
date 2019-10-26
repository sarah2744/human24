package com.human24.main;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.human24.main.dto.AdminBoardConfigDto;
import com.human24.main.dto.AttendanceDto;
import com.human24.main.dto.BoardCommentDto;
import com.human24.main.dto.BoardDto;
import com.human24.main.dto.BuyDto;
import com.human24.main.dto.CartJDto;
import com.human24.main.dto.GenreDto;
import com.human24.main.dto.MemberDto;
import com.human24.main.dto.PointDto;
import com.human24.main.dto.bookDto;
import com.human24.main.dto.orderJDto;
import com.human24.main.idao.AttendanceIDao;
import com.human24.main.idao.IMDao;
import com.human24.main.idao.StoreIDao;
import com.human24.main.idao.adminBoardConfigIDao;
import com.human24.main.idao.adminIDao;
import com.human24.main.idao.boardCommentIDao;
import com.human24.main.idao.bookIDao;

@Controller
public class HomeController {
	@Autowired
	private SqlSession sqlSession;

	// 현재 날짜 가져오기
	Calendar calendar = new GregorianCalendar(Locale.KOREA);
	int nYear = calendar.get(Calendar.YEAR);
	int nMonth = calendar.get(Calendar.MONTH) + 1;
	int nDay = calendar.get(Calendar.DATE);

	public int getDateDay(Date date) throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		int dayNum = cal.get(Calendar.DAY_OF_WEEK);

		return dayNum;
	}

	@RequestMapping("/search")
	public String header(Model model, HttpServletRequest hsr) throws UnsupportedEncodingException {
		StoreIDao dao = sqlSession.getMapper(StoreIDao.class);
		String searchText = hsr.getParameter("searchText"); // 검색어 가져오기
		int noData = 1; // 데이터가 없을경우를 위해 변수 만들기
		if (searchText == null || searchText == "" || searchText == "undefined")
			searchText = ""; // 검색어 널예외 없애기
		else
			searchText = new String(hsr.getParameter("searchText").getBytes("ISO-8859-1"), "UTF-8"); // 검색어 한글 처리
		model.addAttribute("searchText", searchText); // 검색어 내보내기(공백 제거 전 검색어 내보내기)

		searchText = searchText.replaceAll("\\p{Z}", ""); // 검색어 공백 제거
		ArrayList<bookDto> bookList = dao.search(searchText);
		if (bookList.size() == 0)
			noData = 0; // 데이터가 없는 경우 noData 0 설정

		model.addAttribute("noData", noData); // 데이터가 없는 경우 텍스트 출력하기 위해 model add
		model.addAttribute("bookList", bookList); // 검색 책 리스트
		return "search";
	}

	@RequestMapping("/mypage")
	public String mypage(Model model) {
		return "mypage";
	}

	@RequestMapping(value = "/insertCart", method = RequestMethod.GET)
	@ResponseBody
	public void insertCart(Model model, HttpServletRequest hsr) {
		String cart_booknum = hsr.getParameter("cart_booknum");
		int cart_count = Integer.parseInt(hsr.getParameter("cart_count"));
		String userid = hsr.getParameter("userid");
		bookIDao dao = sqlSession.getMapper(bookIDao.class);

		int temp = dao.checkCartBooknum(cart_booknum, userid); // 장바구니에 booknum이 들어있는지 check

		if (temp > 0) { // 있을 경우 (update)
			dao.cartup(cart_count, userid, cart_booknum);
		} else { // 없을 경우 (insert)
			dao.cartin(cart_booknum, userid, cart_count);
		}

	}

	@RequestMapping("/cart")
	public String cart(Model model, HttpServletRequest hsr) {
		HttpSession session = hsr.getSession();
		String userid = (String) session.getAttribute("userid");
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		ArrayList<CartJDto> bookList = dao.cartTable(userid);

		model.addAttribute("cartTable", bookList);

		return "cart";
	}

	@RequestMapping(value = "/d_cart", method = RequestMethod.GET)
	@ResponseBody
	public void deleteCart(HttpServletRequest hsr, Model model) {
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		String userid = hsr.getParameter("userid");
		String delStr = hsr.getParameter("d_cartnum");
		String[] delArr = delStr.split(",");
		for (int i = 0; i < delArr.length; i++) {
			dao.deleteCart(delArr[i], userid);
		}
	}

	@RequestMapping(value = "/u_cart", method = RequestMethod.GET)
	@ResponseBody
	public void cartupdate(HttpServletRequest hsr, Model model) {
		String userid = hsr.getParameter("userid");
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		String count = hsr.getParameter("cartcount");
		String cart_num = hsr.getParameter("cartbooknum");
		dao.cartupdate(count, cart_num, userid);
	}

	@RequestMapping("/order")
	public String order(Model model, HttpServletRequest hsr) throws Exception {
		HttpSession session = hsr.getSession();
		String userid = (String) session.getAttribute("userid");
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		ArrayList<orderJDto> bookList = dao.buyRecordSelect(userid);
		for (int i = 0; i < bookList.size(); i++) {
			int buyDate = getDateDay(bookList.get(i).getBuy_date());
			int dis_index = bookList.get(i).getDis_index();
			if (dis_index == 1) {
				if (buyDate == 1 || buyDate == 7)
					bookList.get(i).setDis_per("0.7");
				else
					bookList.get(i).setDis_per("0.9");
			} else
				bookList.get(i).setDis_per("0.9");
		}
		model.addAttribute("buyTable", bookList);
		return "order";
	}

	@RequestMapping("/board")
	   public String board(Model  model, HttpServletRequest hsr) {
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		adminBoardConfigIDao configdao = sqlSession.getMapper(adminBoardConfigIDao.class);  //config
	      String board_index = hsr.getParameter("board_index");
	      String nowPageString = hsr.getParameter("nowPage");
	      int nowPage = 1;
	      if(nowPageString == null || nowPageString == "" || nowPageString == "undefined") nowPage = 1;
	      else nowPage = Integer.parseInt(nowPageString);
	      String DBFlag = (String) configdao.boardDeleteLogic(Integer.parseInt(board_index)); // config
	      int totalcnt = 0 ;
	      if(DBFlag == "DEL") {
		      totalcnt = dao.NoticeCount(board_index);
	      }else if(DBFlag == "DB"){
		      totalcnt = dao.NoticeFlagCount(board_index);
	      }
	      int pagingcnt = configdao.boardPaging(Integer.parseInt(board_index));  //config
	      int totalPage =  totalcnt/pagingcnt; 
	      if(totalcnt % pagingcnt != 0) totalPage++;
	      
	      ArrayList<BoardDto> boardDto = new ArrayList<BoardDto>();
	      if(DBFlag.equals("DEL")) {
		      if (nowPage == totalPage) {	    	  
		    	  boardDto = dao.NoticeCall(board_index, ((nowPage * pagingcnt) - (pagingcnt-1)), totalcnt);
		  	  } else {
		  		  boardDto = dao.NoticeCall(board_index, ((nowPage * pagingcnt) - (pagingcnt-1)), (nowPage * pagingcnt));	
		  	  }
	      }else if(DBFlag.equals("DB")) {
	    	  if (nowPage == totalPage) {	    	  
		    	  boardDto = dao.NoticeFlagCall(board_index, ((nowPage * pagingcnt) - (pagingcnt-1)), totalcnt);
		  	  } else {
		  		  boardDto = dao.NoticeFlagCall(board_index, ((nowPage * pagingcnt) - (pagingcnt-1)), (nowPage * pagingcnt));	
		  	  }
	      }
	      
	      model.addAttribute("board_index", board_index);
	      model.addAttribute("Notice", boardDto);
	      model.addAttribute("noticeLength", dao.NoticeCount(board_index));
	      model.addAttribute("totalPage", totalPage);
		  model.addAttribute("nowPage", nowPage);
		  
	      return "board";
	   }

	@RequestMapping(value = "/board_delete", method = RequestMethod.GET)
    @ResponseBody
    public void board_delete(HttpServletRequest hsr, Model model){
       bookIDao dao = sqlSession.getMapper(bookIDao.class);
       boardCommentIDao dao2 = sqlSession.getMapper(boardCommentIDao.class);
       adminBoardConfigIDao configdao = sqlSession.getMapper(adminBoardConfigIDao.class);  //config

       String board_num = hsr.getParameter("board_num");
       String board_index = hsr.getParameter("board_index");
       String DBFlag = (String) configdao.boardDeleteLogic(Integer.parseInt(board_index)); // config
      
       if(DBFlag.equals("DEL")) {
    	   dao2.boardCommentAllErase(board_index, board_num);
    	   dao.NoticeDelete(board_num);	    	  
       }else if(DBFlag.equals("DB")) {
    	   dao2.boardCommentAllErase(board_index, board_num);
    	   dao.NoticeFlagDelete(board_num);	
       }
    }
	
	@RequestMapping("/write_board")
	public void write_board(Model model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {
	   hsr.setCharacterEncoding("euc-kr"); // 한글 파라미터 받아오기 1
	   bookIDao dao = sqlSession.getMapper(bookIDao.class);
  	   String title = new String(hsr.getParameter("title").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
  	   String contents = new String(hsr.getParameter("contents").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
  	  
	   HttpSession session = hsr.getSession();
       String userid = (String) session.getAttribute("userid");
       String truename = userid;
       String board_index = hsr.getParameter("board_index");
       String dap_yn = hsr.getParameter("dap_yn");
      // (String book_num, String user_id, String title, String contents);
       if(dap_yn.equals("no")) dao.NoticeInsert(userid, title, contents, board_index, truename);
       else {//답글일 때
    	  int board_num = Integer.parseInt(dap_yn);
    	  dao.boardNumUpdate(board_num);
    	  dao.dapInsert(board_num-1, userid, title, contents);  
       }
       response.sendRedirect("board?board_index="+board_index); 
	}
	
	@RequestMapping("/write_configBoard")
    public void write_configBoard(Model  model, HttpServletRequest hsr, HttpServletResponse response) throws IOException {

     
	   hsr.setCharacterEncoding("euc-kr"); // 한글 파라미터 받아오기 1
	   bookIDao dao = sqlSession.getMapper(bookIDao.class);
	   adminBoardConfigIDao configDao = sqlSession.getMapper(adminBoardConfigIDao.class);
	  
	   HttpSession session = hsr.getSession();
	   String truename = (String)session.getAttribute("userid");
	   String board_index = ""+hsr.getParameter("board_index")+"";
	   String dap_yn = ""+hsr.getParameter("dap_yn")+"";
	   String title = new String(hsr.getParameter("title").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
	   String contents = new String(hsr.getParameter("contents").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
	  
	   HashMap<String, Object> box = new HashMap<String, Object>();
	  
       ArrayList<AdminBoardConfigDto> arr = configDao.boardConfigList(Integer.parseInt(board_index));
      
       String wc = arr.get(0).getWriter_compl();
       String mc = arr.get(0).getMobile_compl();
       String ec = arr.get(0).getEmail_compl();
       String er = arr.get(0).getEmail_receive();
       String sc = arr.get(0).getSecurity_compl();
       String bt = arr.get(0).getBoard_name();
       
	   if(wc.equals("Y")) {	
	 	  String nickname = new String(hsr.getParameter("nickname").getBytes("ISO-8859-1"), "UTF-8");
    	  box.put("user_id" , nickname);
       }
       if(mc.equals("Y")) {
    	  String mobile = new String(hsr.getParameter("mobile").getBytes("ISO-8859-1"), "UTF-8");
    	  box.put("mobile", mobile);
       }
       if(ec.equals("Y")) {
    	  String email = new String(hsr.getParameter("email").getBytes("ISO-8859-1"), "UTF-8");
    	  box.put("email", email);
       }
       if(sc.equals("Y")) {
    	  String security = hsr.getParameter("security");
    	  box.put("sec_compl", security);
       }
       box.put("truename", truename);
       box.put("board_index", board_index);
       box.put("title", title);
       box.put("contents", contents);
	      
       if(dap_yn.equals("no")) dao.NoticeConfigInsert(box);
       else {//답글일 때
    	  int board_num = Integer.parseInt(dap_yn);
    	  dao.boardNumUpdate(board_num);
    	  dao.dapInsert(board_num-1, truename, title, contents);  
       }
      
       response.sendRedirect("board?board_index="+board_index); 
    }
	
	@RequestMapping("/board_write")
	public String board_write(Model model, HttpServletRequest hsr) {
		String board_index = hsr.getParameter("board_index");
		String dap_yn = hsr.getParameter("dap_yn");
		model.addAttribute("dap_yn", dap_yn);
		model.addAttribute("board_index", board_index);
		return "board_write";
	}

	@RequestMapping("/board_write2")
	public String board_write2(Model model, HttpServletRequest hsr) {
		String board_num = hsr.getParameter("board_num");
		String board_index = hsr.getParameter("board_index");
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		model.addAttribute("board", dao.NoticeDetail(board_num));

		model.addAttribute("board_index", board_index);
		return "board_write2";
	}

	@RequestMapping(value = "/board/update", method = RequestMethod.GET)
	@ResponseBody
	public void board_update(HttpServletRequest hsr, Model model) throws UnsupportedEncodingException {
		hsr.setCharacterEncoding("euc-kr"); // 한글 파라미터 받아오기 1
		String title = new String(hsr.getParameter("title").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
		String contents = new String(hsr.getParameter("contents").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		String board_num = hsr.getParameter("board_num");

		String board_index = hsr.getParameter("board_index");
		dao.NoticeUpdate(title, contents, board_num);
	}

	
	/*@RequestMapping(value = "/board/Configupdate", method = RequestMethod.GET)
    @ResponseBody
    public void board_configupdate(HttpServletRequest hsr, Model model) throws UnsupportedEncodingException{
		hsr.setCharacterEncoding("euc-kr"); // 한글 파라미터 받아오기 1
	    String title = new String(hsr.getParameter("title").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
	    String contents = new String(hsr.getParameter("contents").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기
        bookIDao dao = sqlSession.getMapper(bookIDao.class);
        String board_num = hsr.getParameter("board_num");
        String board_index = hsr.getParameter("board_index");
	    adminBoardConfigIDao configDao = sqlSession.getMapper(adminBoardConfigIDao.class);
	    HttpSession session = hsr.getSession();
	 
	    HashMap<String, Object> box = new HashMap<String, Object>();
	  
        ArrayList<AdminBoardConfigDto> arr = configDao.boardConfigList(Integer.parseInt(board_index));
      
        String wc = arr.get(0).getWriter_compl();
        String mc = arr.get(0).getMobile_compl();
        String ec = arr.get(0).getEmail_compl();
        String er = arr.get(0).getEmail_receive();
        String sc = arr.get(0).getSecurity_compl();
        String bt = arr.get(0).getBoard_name();
      
        if(wc.equals("Y")) {
		   String nickname = new String(hsr.getParameter("nickname").getBytes("ISO-8859-1"), "UTF-8");
    	   box.put("user_id" , nickname);
        }
        if(mc.equals("Y")) {
    	   String mobile = new String(hsr.getParameter("mobile").getBytes("ISO-8859-1"), "UTF-8");
    	   box.put("mobile", mobile);
        }
        if(ec.equals("Y")) {
    	   String email = new String(hsr.getParameter("email").getBytes("ISO-8859-1"), "UTF-8");
    	   box.put("email", email);
        }
        box.put("title", title);
        box.put("contents", contents);
        box.put("board_num", board_num);
      
        dao.NoticeConfigUpdate(box);
    }
    */
	@RequestMapping("/board_detail_page")
	public String board_detail_page(Model model, HttpServletRequest hsr) {
		String boardnum = hsr.getParameter("boardnum");
		String board_index = hsr.getParameter("board_index");
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		HttpSession session = hsr.getSession();
		String userid = (String) session.getAttribute("userid");
		if (userid == null || userid == "" || userid == "undefined")
			userid = "";
		BoardDto board_detail = dao.NoticeDetail(boardnum);
		model.addAttribute("board_detail", board_detail);
		model.addAttribute("board_index", board_index);
		model.addAttribute("adminYN", dao.adminYN(userid));
		model.addAttribute("board_date", board_detail.getBoard_date());
		model.addAttribute("views", board_detail.getViews());
		return "board_detail_page";
	}

	@RequestMapping(method = { RequestMethod.GET }, value = "/viewsPlus")
	@ResponseBody
	public String viewsPlus(Model model, HttpServletRequest hsr) {
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		dao.viewsUpdate(hsr.getParameter("boardnum"));
		return "board";
	}

	@RequestMapping("/main")
	public String main(Model model) {
		StoreIDao dao = sqlSession.getMapper(StoreIDao.class);
		String value = "mainBestBook";
		ArrayList<bookDto> bookList = dao.weekOrBestBook(value);

		model.addAttribute("bookList", bookList);
		return "main";
	}

	@RequestMapping("/store")
	public String store(Model model, HttpServletRequest hsr) throws UnsupportedEncodingException {
		hsr.setCharacterEncoding("euc-kr"); // 한글 파라미터 받아오기 1
		String genre = hsr.getParameter("genre"); // 클릭한 장르 가져오기
		String page = hsr.getParameter("page");
		String order = hsr.getParameter("order"); // 정렬방식 불러오기
		if (order == "" || order == null) {
			order = "0";
		}
		int nowPage = 1;

		if (genre != null) { // 장르를 클릭했을 경우
			genre = new String(hsr.getParameter("genre").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기 2
		} else { // 장르를 클릭하지 않은 경우 기본 값(한국소설) store로 지정
			genre = "한국소설";
		}

		if (page == null || page == "")
			nowPage = 1;
		else
			nowPage = Integer.parseInt(page);

		StoreIDao dao = sqlSession.getMapper(StoreIDao.class); // 인터페이스 설정
		int totalcnt = dao.totalCount(genre); // 선택한 장르의 책 갯수
		int totalPage = totalcnt / 8; // 총 페이지 구하기
		if (totalcnt % 8 != 0)
			totalPage++;

		String value = "default";
		ArrayList<bookDto> bookList = dao.bookListPage(genre, ((nowPage * 7) - 8), (nowPage * 8), value);

		if (order.equals("0"))
			value = "default";
		else if (order.equals("1"))
			value = "orderBySellCnt";
		else if (order.equals("2"))
			value = "orderByHighPrice";
		else if (order.equals("3"))
			value = "orderByLowPrice";
		else if (order.equals("4"))
			value = "orderByGrade";
		
		if (nowPage == totalPage) {
			bookList = dao.bookListPage(genre, ((nowPage * 8) - 7), totalcnt, value);
		} else {
			bookList = dao.bookListPage(genre, ((nowPage * 8) - 7), (nowPage * 8), value);
		}

		model.addAttribute("totalPage", totalPage);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("bookList", bookList);
		model.addAttribute("bookGenre", genre);
		model.addAttribute("order", order);
		model.addAttribute("mainGenre", dao.useMainGenre());
		return "store";
	}
	@RequestMapping(value="/useSubGenre", method=RequestMethod.POST)
	@ResponseBody
	public void admin_book_popup(HttpServletRequest hsr, HttpServletResponse response) throws IOException {
		StoreIDao dao = sqlSession.getMapper(StoreIDao.class);

		ArrayList<GenreDto> subGenreList = dao.genreSub(hsr.getParameter("main_genre_num"));
		PrintWriter out = response.getWriter();		
		Gson gson = new Gson();
		String data = gson.toJson(subGenreList);
		
		out.print(data);
	}
	
	@RequestMapping("/best")
	public String best(Model model) {
		StoreIDao dao = sqlSession.getMapper(StoreIDao.class);
		String value = "bestBook";
		ArrayList<bookDto> bookList = dao.weekOrBestBook(value);

		model.addAttribute("bookList", bookList);
		return "best";
	}

	@RequestMapping("/used")
	public String used(Model model) {
		return "used";
	}

	@RequestMapping("/weekDiscount")
	public String weekDiscount(Model model) {
		StoreIDao dao = sqlSession.getMapper(StoreIDao.class);
		String value = "weekBook";
		ArrayList<bookDto> bookList = dao.weekOrBestBook(value);

		model.addAttribute("bookList", bookList);
		return "weekDiscount";
	}

	@RequestMapping("/modify")
	public String modify(Model model) {
		return "modify";
	}

	@RequestMapping(method = { RequestMethod.POST }, value = "/login")
	public String login(Model model, HttpServletRequest hsr) {
		String usrnm = hsr.getParameter("usrnm");
		model.addAttribute("usrnm", usrnm);
		return "login";
	}

	@RequestMapping("/logout")
	public String logout(Model model, HttpServletRequest hsr) {
		String id = hsr.getParameter("id");
		model.addAttribute("id", id);
		return "logout";
	}

	@RequestMapping("/attendance_check")
	public String attendance_check(Model model, HttpServletRequest hsr) {
		HttpSession session = hsr.getSession();
		String userid = (String) session.getAttribute("userid");
		if (userid == null || userid == "" || userid == "undefined") {
			userid = "";
		}
		// 매핑
		AttendanceIDao dao = sqlSession.getMapper(AttendanceIDao.class);

		ArrayList<AttendanceDto> tempArr = dao.attendanceDay(userid, nYear, nMonth);

		String atd = "";

		// 아이디와 일치하는 현재 년, 월에 맞는 출석일 가져오기
		for (int i = 0; i < tempArr.size(); i++) {
			if (i == (tempArr.size() - 1)) {
				atd += tempArr.get(i).getA_day();
				break;
			}
			atd += tempArr.get(i).getA_day() + ",";
		}

		model.addAttribute("attendDay", atd);

		return "attendance_check";
	}

	@RequestMapping(method = { RequestMethod.POST }, value = "/acAjax")
	@ResponseBody
	public String acAjax(Model model, HttpServletRequest hsr) {
		String userid = hsr.getParameter("userid");
		AttendanceIDao dao = sqlSession.getMapper(AttendanceIDao.class);
		bookIDao bookDao = sqlSession.getMapper(bookIDao.class);
		bookDao.insertPointList(userid, 1, 50);
		bookDao.totalPointUpdate(50, userid);
		dao.doAttendance(userid, nYear, nMonth, nDay);
		return "attendance_check";
	}

	@RequestMapping("/point")
	public String point(Model model, HttpServletRequest hsr) {
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		HttpSession session = hsr.getSession();
		String userid = (String) session.getAttribute("userid");
		ArrayList<PointDto> pointList = dao.pointList(userid);
		for (int i = 0; i < pointList.size(); i++) {
			if (pointList.get(i).getHow_point().equals("1"))
				pointList.get(i).setHow_point("출석체크");
			else if (pointList.get(i).getHow_point().equals("2"))
				pointList.get(i).setHow_point("책 구매");
			else if (pointList.get(i).getHow_point().equals("3"))
				pointList.get(i).setHow_point("댓글");
			else if (pointList.get(i).getHow_point().equals("4"))
				pointList.get(i).setHow_point("회원가입");
			else if (pointList.get(i).getHow_point().equals("5"))
				pointList.get(i).setHow_point("포인트 사용");
		}
		model.addAttribute("pointList", pointList);
		model.addAttribute("totalPoint", dao.totalPoint(userid));
		return "point";
	}

	@RequestMapping("/leave")
	public String leave(Model model) {
		return "leave";
	}

	@RequestMapping("/join_check")
	public String join_check(Model model) {
		return "join_check";
	}

	@RequestMapping("/find")
	public String find(Model model) {
		return "find";
	}

	@RequestMapping("/join")
	public String join(Model model) {
		return "join";
	}

	@RequestMapping("/findId")
	public String findId(Model model) {
		return "findId";
	}

	@RequestMapping("/findPwd")
	public String findPwd(Model model) {
		return "findPwd";
	}

	@RequestMapping(method = { RequestMethod.GET, RequestMethod.POST }, value = "/order_delivery")
	public String order_delivery(Model model, HttpServletRequest hsr) {
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		HttpSession session = hsr.getSession();
		String userid = (String) session.getAttribute("userid");
		String cartOrDetail = hsr.getParameter("cartOrDetail"); // 장바구니 구매인지 상세페이지 구매인지 구별
		ArrayList<BuyDto> buyArr = new ArrayList<BuyDto>();
		if (cartOrDetail.equals("cart")) {
			String[] buyTextArr = hsr.getParameter("buyText").split(",");
			String[] countArr = hsr.getParameter("count").split(",");
			ArrayList<bookDto> bookList = new ArrayList<bookDto>();
			for (int i = 0; i < buyTextArr.length; i++) {
				bookList.add(dao.buy(buyTextArr[i]));
			}
			for (int i = 0; i < bookList.size(); i++) {
				buyArr.add(new BuyDto(bookList.get(i).getBooknum(), bookList.get(i).getBooktitle(),
						bookList.get(i).getPrice(), bookList.get(i).getDis_per(), countArr[i]));
			}
		} else {
			String d_booknum = hsr.getParameter("d_booknum");
			String d_count = hsr.getParameter("d_count");
			bookDto bookInfo = dao.buy(d_booknum);
			buyArr.add(new BuyDto(bookInfo.getBooknum(), bookInfo.getBooktitle(), bookInfo.getPrice(),
					bookInfo.getDis_per(), d_count));
		}

		model.addAttribute("totalPoint", dao.totalPoint(userid));
		model.addAttribute("buyTable", buyArr);
		model.addAttribute("userInfo", dao.getUserInfo(userid));
		return "order_delivery";
	}

	@RequestMapping("/buyBook") 
	public String buyBook(Model model, HttpServletRequest hsr) {
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		HttpSession session = hsr.getSession();
		String userid = (String) session.getAttribute("userid");
		int point = Integer.parseInt(hsr.getParameter("point"));
		int usePoint = 0;
		
		dao.insertPointList(userid, 2, point); // 구매한 포인트 적립 (포인트리스트 추가)
		dao.totalPointUpdate(point, userid); // 구매한 포인트 적립 (멤버 테이블 총포인트 업데이트)
		dao.purCountUpdate(userid); // 해당 유저의 구매 횟수 update
		
		if (hsr.getParameter("pointFlag").equals("1")) { // 포인트를 사용할 경우
			usePoint = Integer.parseInt(hsr.getParameter("usePoint"));
			dao.insertPointList(userid, 5, (usePoint * -1)); // 포인트리스트에 사용기록 추가
			dao.totalPointUpdate((usePoint * -1), userid); // 멤버테이블 총포인트 사용한 포인트만큼 빼기
		}
		
		
		String[] buyText = hsr.getParameter("buyText").split(",");
		String[] count = hsr.getParameter("count").split(",");
		for (int i = 0; i < buyText.length; i++) {
			dao.buyBooklistUpdate(Integer.parseInt(count[i]), buyText[i]); // booklist 테이블에 sales_cnt 업데이트
			dao.insertPurInfo(buyText[i], userid, Integer.parseInt(count[i]), usePoint, buyText.length); // 구매 정보 테이블에 추가
			dao.buyDeleteCart(userid, buyText[i]); // 구매한 책 장바구니에서 삭제
		}

		return "main";
	}

	@RequestMapping("/detail")
	public String detail(Model model, HttpServletRequest hsr) {
		HttpSession session = hsr.getSession();
		String userid = (String) session.getAttribute("userid");
		if (userid == null || userid == "" || userid == "undefined")
			userid = "";
		String booknum = hsr.getParameter("booknum");
		String tab = hsr.getParameter("tab");
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		int comCount = dao.comCount(userid, booknum);
		int buyRecord = dao.buyRecord(userid, booknum);
		int receivePoint = dao.receivePoint(userid, booknum);
		bookDto bookList = dao.booklist(booknum);

		model.addAttribute("comCount", comCount);
		model.addAttribute("booklist", bookList); // 책 상세페이지
		model.addAttribute("commentShow", dao.commentShow(booknum)); // 책 상세페이지 댓글
		model.addAttribute("buyRecord", buyRecord);
		model.addAttribute("receivePoint", receivePoint);
		model.addAttribute("tab", tab);
		return "detail";
	}

	@RequestMapping(value = "/detail/comment", method = RequestMethod.GET)
	@ResponseBody
	public void d_comment(@RequestParam("booknum") String booknum, HttpServletRequest hsr, HttpServletResponse response)
			throws IOException {
		hsr.setCharacterEncoding("euc-kr"); // 한글 파라미터 받아오기 1
		bookIDao dao = sqlSession.getMapper(bookIDao.class);

		String userid = hsr.getParameter("userid");
		String contents = new String(hsr.getParameter("contents").getBytes("ISO-8859-1"), "UTF-8"); // 한글 파라미터 받아오기 2
		String grade = hsr.getParameter("grade");
		String buyRecord = hsr.getParameter("buyRecord");
		String receivePoint = hsr.getParameter("receivePoint");

		PrintWriter out = response.getWriter();
		if (!buyRecord.equals("0")) { // 구매한 기록이 있을 때
			if (receivePoint.equals("0")) { // 해당 책에 받은 포인트 기록이 없을 때
				dao.WriteCommentInsertPointList(userid, 3, 50, booknum);
				dao.totalPointUpdate(50, userid);
			}
		}

		int gradeNum = Integer.parseInt(grade);
		dao.write(userid, booknum, contents, gradeNum);
		dao.commentUpdate(gradeNum, booknum);
		int comNum = 0;
		comNum = dao.comNumGet(userid, booknum);
		int data = comNum;
		out.print(data);
	}

	@RequestMapping("/commentDel")
	@ResponseBody
	public void commentDel(Model model, HttpServletRequest hsr) {
		String comnum = hsr.getParameter("comnum");
		bookIDao dao = sqlSession.getMapper(bookIDao.class);
		dao.comDelBooklistUpdate(comnum);
		dao.comDel(comnum);
	}

	/**********************************************/

	@RequestMapping(value = "/join/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(@RequestParam("userId") String user_id) {
		IMDao dao = sqlSession.getMapper(IMDao.class);
		return dao.checkOverId(user_id);
	}

	@RequestMapping(value = "/join/sign", method = RequestMethod.GET)
	public String memberJoin(HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		IMDao dao = sqlSession.getMapper(IMDao.class);
		bookIDao bookDao = sqlSession.getMapper(bookIDao.class);

		// insertPointList
		String user_name = new String(request.getParameter("user_name").getBytes("ISO-8859-1"), "UTF-8");
		String adr = new String(request.getParameter("adr").getBytes("ISO-8859-1"), "UTF-8");
		String userid = request.getParameter("user_id");

		dao.memberJoin(userid, user_name, request.getParameter("user_pwd"), request.getParameter("birth"),
				request.getParameter("mail"), adr, request.getParameter("gender"), request.getParameter("mobile"), 1000,
				0);
		bookDao.insertPointList(userid, 4, 1000);
		return "redirect:/main";
	}

	@RequestMapping(value = "/findId/Submit", method = RequestMethod.GET)
	@ResponseBody
	public String userFindId(@RequestParam("mail") String mail) {
		IMDao dao = sqlSession.getMapper(IMDao.class);
		return dao.userFindId(mail);
	}

	@RequestMapping(value = "/findPwd/Submit", method = RequestMethod.GET)
	@ResponseBody
	public String userFindPwd(@RequestParam("userId") String userId, @RequestParam("mail") String mail) {

		IMDao dao = sqlSession.getMapper(IMDao.class);
		return dao.userFindPwd(userId, mail);
	}

	@RequestMapping(value = "/modify/userinfo", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<MemberDto> userinfo(@RequestParam("userId") String userId) {
		IMDao dao = sqlSession.getMapper(IMDao.class);

		return dao.userInfo(userId);
	}

	@RequestMapping("/passUpdate")
	public String passUpdate(Model model) {
		return "passUpdate";
	}

	@RequestMapping(value = "/passUpdate/passCheck", method = RequestMethod.GET)
	@ResponseBody
	public String passUpdateCheck(@RequestParam("userId") String userId) {
		IMDao dao = sqlSession.getMapper(IMDao.class);

		return dao.passUpdateCheck(userId);
	}

	@RequestMapping(value = "/passUpdate/Submit", method = RequestMethod.GET)
	@ResponseBody
	public void passUpdateSubmit(@RequestParam("userPwd") String userPwd, @RequestParam("userId") String userId) {
		IMDao dao = sqlSession.getMapper(IMDao.class);
		dao.passUpdate(userPwd, userId);
	}

	@RequestMapping(value = "/modify/Submit", method = RequestMethod.GET)
	public String memberUpdate(HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		IMDao dao = sqlSession.getMapper(IMDao.class);
		String user_name = new String(request.getParameter("user_name").getBytes("ISO-8859-1"), "UTF-8");
		String adr = new String(request.getParameter("adr").getBytes("ISO-8859-1"), "UTF-8");
		dao.memberUpdate(request.getParameter("user_id"), user_name, request.getParameter("birth"), adr,
				request.getParameter("gender"), request.getParameter("mobile"));
		return "redirect:/mypage";
	}

	@RequestMapping(value = "/leave/Submit", method = RequestMethod.GET)
	@ResponseBody
	public String userLeave(@RequestParam("userId") String userId) {
		IMDao dao = sqlSession.getMapper(IMDao.class);

		String[] tablenames = { "attendance", "board", "boardcomment", "cart", "commentlist", "pur_info", "pointlist",
				"member" };

		for (int i = 0; i < tablenames.length; i++) {
			dao.memberDelete(tablenames[i], userId);
		}

		return "redirect:/main";
	}

	@RequestMapping(value = "/main/loginCheck", method = RequestMethod.GET)
	@ResponseBody
	public int loginCheck(@RequestParam("userId") String userId, @RequestParam("userPwd") String userPwd) {
		IMDao dao = sqlSession.getMapper(IMDao.class);
		return dao.loginCheck(userId, userPwd);
	}

	@RequestMapping(value = "/board_detail_page/CommentWrite", method = RequestMethod.GET)
	@ResponseBody
	public void commentWrite(@RequestParam("boardIndex") String boardIndex, @RequestParam("boardNum") String boardNum,
			@RequestParam("userName") String userName, @RequestParam("comments") String comments) throws UnsupportedEncodingException  {
		int boardIndexEx = Integer.parseInt(boardIndex);
		String commentsEncording = new String(comments.getBytes("ISO-8859-1"), "UTF-8");
		boardCommentIDao dao = sqlSession.getMapper(boardCommentIDao.class);
		dao.boardCommentWrite(boardIndexEx, boardNum, userName, commentsEncording);
	}
	
	@RequestMapping(value = "/board_detail_page/CommentReWrite", method = RequestMethod.GET)
	@ResponseBody
	public void commentReWrite(@RequestParam("boardIndex") String boardIndex, @RequestParam("boardNum") String boardNum,
			@RequestParam("userName") String userName, @RequestParam("comments") String comments, @RequestParam("comNum") String commentNum) throws UnsupportedEncodingException  {
		String commentsEncording = new String(comments.getBytes("ISO-8859-1"), "UTF-8");
		int boardIndexEx = Integer.parseInt(boardIndex);
		int commentNumEx = Integer.parseInt(commentNum);
		boardCommentIDao dao = sqlSession.getMapper(boardCommentIDao.class);
		dao.boardCommentNumUpdate(commentNumEx);
		dao.boardCommentReWrite(boardIndexEx, boardNum, userName, commentsEncording);
	}
	
	@RequestMapping(value = "/board_detail_page/CommentList", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<BoardCommentDto> boardCommentList(@RequestParam("boardIndex") String boardIndex, @RequestParam("boardNum") String boardNum) {
		boardCommentIDao dao = sqlSession.getMapper(boardCommentIDao.class);
		return dao.boardCommentList(boardIndex, boardNum);
	}
	
	@RequestMapping(value = "/board_detail_page/CommentErase", method = RequestMethod.GET)
	@ResponseBody
	public void boardCommentErase(@RequestParam("comNum") String commentNum) {
		boardCommentIDao dao = sqlSession.getMapper(boardCommentIDao.class);
		int commentNum2 = Integer.parseInt(commentNum);
		dao.boardCommentErase(commentNum2);
	}
	
	
	@RequestMapping(value = "/board/boardTitleView", method = RequestMethod.GET)
	@ResponseBody
	public AdminBoardConfigDto boardTitleView(@RequestParam("boardIndex") String boardIndex) {
		adminBoardConfigIDao cDao = sqlSession.getMapper(adminBoardConfigIDao.class);
		IMDao mDao = sqlSession.getMapper(IMDao.class);
		int boardIndexEx = Integer.parseInt(boardIndex);
		return cDao.boardTitleView(boardIndexEx) ;
	}
	
	@RequestMapping(value = "/board/boardWriteAuth", method = RequestMethod.GET)
	@ResponseBody
	public int boardWriteAuth(@RequestParam("boardIndex") String boardIndex, @RequestParam("userid") String userid) {
		adminBoardConfigIDao cDao = sqlSession.getMapper(adminBoardConfigIDao.class);
		IMDao mDao = sqlSession.getMapper(IMDao.class);
		int boardIndexEx = Integer.parseInt(boardIndex);
		String writeAuth = cDao.boardWriteAuth(boardIndexEx);
		int writeAuthNum = 0;
		if(writeAuth.equals("ALL")) {
			writeAuthNum = -1;
		}else if(writeAuth.equals("USER")) {
			writeAuthNum = 0;
		}else if(writeAuth.equals("ADMIN")){
			writeAuthNum = 1;
		}else if(writeAuth.equals("NOWRITE")){
			writeAuthNum = 2;
		}
		ArrayList<MemberDto> userinfo = mDao.userInfo(userid);
		int userAdminIndex = userinfo.get(0).getAdmin_index();
		int writeJudge = 0;
		if(userAdminIndex >= writeAuthNum) {
			writeJudge = 1;
		}else {
			writeJudge = 0;
		}
		return writeJudge;
	}
	
	@RequestMapping(value = "/board/boardControll", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<AdminBoardConfigDto> boardControll(@RequestParam("boardIndex") String boardIndex) {
		adminBoardConfigIDao dao = sqlSession.getMapper(adminBoardConfigIDao.class);
		int boardIndexEx = Integer.parseInt(boardIndex);
		return dao.boardConfigList(boardIndexEx);
	}
	
	@RequestMapping(value = "/board/writeConfigView", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<AdminBoardConfigDto> writeboardConfig(@RequestParam("boardIndex") String boardIndex) {
		adminBoardConfigIDao dao = sqlSession.getMapper(adminBoardConfigIDao.class);
		int boardIndexEx = Integer.parseInt(boardIndex);
		return dao.boardConfigList(boardIndexEx);
	}
	
}
