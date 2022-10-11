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
		<h3>도서 반납</h3>
		<form method="post" action="action.jsp" name="borrow_frm" style="display:flex; align-items:center; justify-content:center; text-align:center">
			<% 
				request.setCharacterEncoding("UTF-8");
				Connection conn = null;
				PreparedStatement pstmt = null;
				String bor_no = request.getParameter("bor_no");
				String bookname = request.getParameter("bookname");
				try{
					conn = Util.getConnection();
					String sql = "select r.bor_no, m.m_name, m.m_no, m.job, r.bookname, r.bor_date from borrow_tbl r, mem_tbl m where m.m_no = r.m_no and bor_no = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,bor_no);
					ResultSet rs = pstmt.executeQuery();
					rs.next();
			%>
		<input type="hidden" name="mode" value="return">
			<table border="1">
			
		
			<tr>
				<td>대여번호</td>
				<td><input type="text" name="bor_no" value="<%=bor_no%>"></td>
			</tr>
				<tr>
				<td>고객이름</td>
				<td>
					<select name="m_name" onchange="chk_select(this);">
						<option selected><%=rs.getString(2) %></option>						
					</select>
				</td>
			</tr>
			<tr>
				<td>고객번호</td>
				<td><input type="text" name="m_no" value="<%=rs.getString(3)%>"></td>
			</tr>
			<tr>
				<td>직업</td>
				<td>
					<input type="radio" name="job" value="학생" <%if(rs.getString(4).equals("학생")) out.println("checked");%>> 학생
					<input type="radio" name="job" value="교사" <%if(rs.getString(4).equals("교사")) out.println("checked");%>> 교사
					<input type="radio" name="job" value="외부인" <%if(rs.getString(4).equals("외부인")) out.println("checked");%>> 외부인
				</td>
			</tr>
			<tr>
				<td>도서명</td>
				<td><input type="text" name="bookname" value="<%=rs.getString(5)%>"></td>
			</tr>
			<tr>
				<td>대여날짜</td>
				<td><input type="text" name="bor_date" value="<%=rs.getDate(6)%>"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="반납하기" onclick="return chk_borrow()">
					<input type="reset" value="뒤로가기" onclick="history.go(-1);">
				</td>
			</tr>
			<%
				}
			catch(Exception e){
				e.printStackTrace();
			}
			%>
			
			</table>
		</form>
	</section>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>