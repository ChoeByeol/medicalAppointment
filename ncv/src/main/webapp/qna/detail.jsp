<%@page import="ncv.beans.QnaDto"%>
<%@page import="ncv.beans.QnaFileDto"%>
<%@page import="java.util.List"%>
<%@page import="ncv.beans.QnaFileDao"%>
<%@page import="ncv.beans.QnaDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력 : 게시글 번호 --%>
<%
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
%>

<%
	String memberId = (String)session.getAttribute("ses");
	QnaDao qnaDao = new QnaDao();
	QnaDto qnaDto = qnaDao.get(qnaNo);
	
	//본인 글인지 아닌지 판정
	boolean writer = memberId.equals(qnaDto.getQnaWriter());
%>

<%
	//현재 게시글에 대한 파일 정보를 조회
	QnaFileDao qnaFileDao = new QnaFileDao();
	List<QnaFileDto> qnaFileList = qnaFileDao.find(qnaNo);//파일이 여러 개일 경우
	//QnaFileDto qnaFileDto = qnaFileDao.find(qnaNo);//파일이 한 개일 경우
%>

<%-- 출력 --%>
<jsp:include page="/template/header.jsp"></jsp:include>    

<style>

</style>

<div class="container-800 container-center">
	<div class="row center">
		<h2><%=qnaDto.getQnaNo()%>번 게시글</h2>
	</div>
	<div class="row">
		<table class="table table-hover">
			<thead>
				<tr align="left"><td><h3><%=qnaDto.getQnaTitle()%></h3></td></tr>
				<tr>
					<th colspan="2" align="left"><%=qnaDto.getQnaWriter()%> | <%=qnaDto.getQnaDate()%></th>
				</tr>
			</thead>
			<tr><td colspan="4"><hr><td></tr>
			<tbody>
			<!-- 답답해 보이지 않도록 기본높이를 부여 -->
			<!-- 
				pre 태그를 사용하여 내용을 있는 그대로 표시되도록 설정
				(주의) 태그 사이에 쓸데없는 엔터, 띄어쓰기 등이 들어가지 않도록 해야 한다.(모두 표시된다)
			 -->
				<tr height="200" valign="top">
					<td colspan="4"><pre><%=qnaDto.getQnaContent()%></pre></td>
				</tr>
			</tbody>
			<tr><td colspan="4"><hr><td></tr>
			<tfoot>
				<tr align="right">
					<td colspan="4">
						<a href="write.jsp">글쓰기</a>
						<a href="list.jsp">목록</a>
						
						<%if(writer){%>
						<a href="edit.jsp?qnaNo=<%=qnaDto.getQnaNo()%>">수정</a>
						<a href="delete.txt?qnaNo=<%=qnaDto.getQnaNo()%>">삭제</a>
						<%}%>
					</td>
			</tfoot>
		</table>
	</div>
</div>

	
<%-- 첨부 파일이 있다면 첨부파일을 다운받을 수 있는 링크를 제공 --%>
<%if(!qnaFileList.isEmpty()){ %>
	<%for(QnaFileDto boardFileDto : qnaFileList){ %>
		<h6>
			<%=boardFileDto.getQnaFileUploadName()%> 
			(<%=boardFileDto.getQnaFileSize()%> bytes)
			<a href="file/download.kh?boardFileNo=<%=boardFileDto.getQnaFileNo()%>">다운로드</a>
			<img src="file/download.kh?boardFileNo=<%=boardFileDto.getQnaFileNo()%>" width="15" height="15">
		</h6>
	<%} %>
<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>    