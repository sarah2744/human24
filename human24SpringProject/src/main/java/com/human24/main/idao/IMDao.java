package com.human24.main.idao;

import java.util.ArrayList;

import com.human24.main.dto.MemberDto;

public interface IMDao {	
	public ArrayList<MemberDto> memberList();  //select * from member
	
	public int checkOverId(String user_id);  //checking userId 
	
	//insert member
	public void memberJoin(String user_id, String user_name, String user_pwd, String birth, String mail, String adr, String gender, String mobile, int user_point, int admin_index);

	public String userFindId(String mail);
	
	public String userFindPwd(String user_id, String mail);
	
	public ArrayList<MemberDto> userInfo(String user_id);
	
	public String passUpdateCheck(String userId);
	
	public void passUpdate(String userPwd, String userId);
	
	public void memberUpdate(String user_id, String user_name, String birth, String adr, String gender, String mobile);
	
	public void memberDelete(String tablename,String user_id);
	
	public int loginCheck(String user_id, String user_pwd);
}
