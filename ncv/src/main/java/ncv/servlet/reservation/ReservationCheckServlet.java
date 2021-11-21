package ncv.servlet.reservation;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ncv.beans.ReservationDao;
import ncv.beans.ReservationDto;
import ncv.beans.Shot2Dao;
import ncv.beans.Shot2Vo;

@WebServlet(urlPatterns = "/reservation/check.txt")
public class ReservationCheckServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			String memberId = (String) req.getSession().getAttribute("ses");

			ReservationDao reservationDao = new ReservationDao();
			List<ReservationDto> resCheckList = reservationDao.resCheckList(memberId);
			ReservationDto reservationDto = reservationDao.vaccineCheck(memberId);

			int vacNo = 0;
			if (reservationDto != null) {
				vacNo= reservationDto.getVaccineNo();
			}

			Shot2Dao shotDao = new Shot2Dao();
			List<Shot2Vo> checkList = shotDao.checkList(memberId);

//			System.out.println(resCheckList.size());
//			System.out.println(checkList.size());
			
			boolean check = memberId != null && resCheckList.size() == 0; // 미접종
			boolean check1 = memberId != null && resCheckList != null && checkList != null &&
										resCheckList.size() == 1 && checkList != null && checkList.size() != 0;// 접종내역 1차 완료
			boolean check2 = memberId != null && checkList != null && checkList.size() == 2 &&
										resCheckList.size() == 2; // 접종내역 1차 / 2차 완료
			boolean vacCheck = vacNo == 4; // 얀센일때
				
			// 출력
			if (check) {// 미접종
				resp.sendRedirect("reservation_reserve.jsp");
//				System.out.println("미접종");

			} else if (check1 && !vacCheck) { // 접종내역 1차 완료
				resp.sendRedirect("reservation_reserve.jsp");
//				System.out.println("접종1차완료");
			} else if (check2 || vacCheck) { // 접종내역 1차 / 2차 완료
				resp.sendRedirect("reservation_resNo.jsp");
//				System.out.println("접종1차, 2차완료");
			} else {
				resp.sendRedirect("reservation_isRes.jsp"); // 예약중일때
//				System.out.println("이미예약중");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
