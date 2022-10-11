<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript" src="check.js"></script>
	<jsp:include page="header.jsp"></jsp:include>
	
	<section style="position:fixed; width:100%; height:100%; top:70px; left:0; background:beige; text-align:center">
		<h3>도서 대여 페이지</h3>
		<form method="post" action="action.jsp" name="borrow_frm" style="display:flex; align-items:center; justify-content:center; text-align:center">
			<% 
				request.setCharacterEncoding("UTF-8");
				Connection conn = null;
				PreparedStatement pstmt = null;
				String bookno = request.getParameter("bookno");
				String bookname = request.getParameter("bookname");
				try{
					conn = Util.getConnection();
					String sql = "select max(bor_no) + 1 from borrow_tbl";
					pstmt = conn.prepareStatement(sql);
					ResultSet rs = pstmt.executeQuery();
					rs.next();
			%>
		<input type="hidden" name="mode" value="borrow">
		<input type="hidden" name="bookno" value="<%=bookno%>">
			<table border="1">
			
		
			<tr>
				<td>대여번호</td>
				<td><input type="text" name="bor_no" value="<%=rs.getString(1)%>"></td>
			</tr>
			
			<%
				}
			catch(Exception e){
				e.printStackTrace();
			}
			%>
			<tr>
				<td>고객이름</td>
				<td>
					<select name="m_name" onchange="chk_select(this);">
						<option selected>고객명</option>
						<%
						try{
						String sql2 = "select m_no, m_name from mem_tbl";
						pstmt = conn.prepareStatement(sql2);
						ResultSet rs2 = pstmt.executeQuery();
						while(rs2.next()){
						%>
						<option id = "<%=rs2.getString(1)%>"><%=rs2.getString(2) %></option>
						<%
						}
						%>
						
					</select>
				</td>
			</tr>
			<tr>
				<td>고객번호</td>
				<td><input type="text" name="m_no" value=""></td>
			</tr>
			<tr>
				<td>직업</td>
				<td>
					<input type="radio" name="job" value="학생"> 학생
					<input type="radio" name="job" value="교사"> 교사
					<input type="radio" name="job" value="외부인"> 외부인
				</td>
			</tr>
			<tr>
				<td>도서명</td>
				<td><input type="text" name="bookname" value="<%=bookname%>"></td>
			</tr>
					<%
						}catch(Exception e){
							e.printStackTrace();
						}
					%>
			<tr>
				<td>대여날짜</td>
				<td><input type="text" name="bor_date" value=""></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="대출하기" onclick="return chk_borrow()">
					<input type="reset" value="다시하기" onclick="alert('처음부터 다시 입력!');">
				</td>
			</tr>
			</table>
		</form>
	</section>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>