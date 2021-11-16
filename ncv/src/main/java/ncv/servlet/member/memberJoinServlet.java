package ncv.servlet.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ncv.beans.MemberDao;
import ncv.beans.MemberDto;


@WebServlet(urlPatterns = "/member/join.kh")
public class memberJoinServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(req.getParameter("memberId"));
			memberDto.setMemberPw(req.getParameter("memberPw"));
			memberDto.setMemberName(req.getParameter("memberName"));
			memberDto.setMemberFrontRrn(req.getParameter("memberFrontRrn"));
			memberDto.setMemberGender(req.getParameter("memberGender"));
			memberDto.setMemberPhone(req.getParameter("memberPhone"));
			memberDto.setMemberPostcode(req.getParameter("memberPostcode"));
			memberDto.setMemberAddress(req.getParameter("memberAddress"));
			memberDto.setMemberDetailAddress(req.getParameter("memberDetailAddress"));
			memberDto.setMemberBackRrn(req.getParameter("memberBackRrn"));
			
			//처리 : MemberDao
			MemberDao memberDao = new MemberDao();
			memberDao.join(memberDto);
			
			//출력 : 리다이렉트
			resp.sendRedirect("join_success.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}