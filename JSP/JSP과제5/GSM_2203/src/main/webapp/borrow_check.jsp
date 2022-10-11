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
	<jsp:include page="header.jsp"></jsp:include>
	
	<section style="position:fixed; width:100%; height:100%; top:70px; left:0; background:beige; text-align:center">
		<h3>대여 정보 확인하기</h3>
		<form style="display:flex; align-items:center; justify-content:center; text-align:center">
			<table border="1">
			
			<tr>
				<td>대여번호</td>
				<td>고객번호</td>
				<td>고객이름</td>
				<td>연락처</td>
				<td>도서명</td>
				<td>대여날짜</td>
				<td>대여기간</td>
				<td>반납여부</td>
			</tr>
			
			<% 
				request.setCharacterEncoding("UTF-8");
				Connection conn = null;
				PreparedStatement pstmt = null;
				try{
					conn = Util.getConnection();
					String sql = "select r.bor_no, m.m_no, m.m_name, m.phone, r.bookname, r.bor_date, r.bor_date+7, r.re_book from borrow_tbl r, mem_tbl m where m.m_no = r.m_no";
					pstmt = conn.prepareStatement(sql);
					ResultSet rs = pstmt.executeQuery();
					while(rs.next()){
				
			%>
			
				<tr>
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td><%=rs.getString(5) %></td>
					<td><%=rs.getDate(6) %></td>
					<td><%=rs.getDate(7) %></td>
					<td><%if(rs.getString(8).equals("대여"))out.println("<a href='return.jsp?bor_no="+rs.getString(1)+"'>반납하기</a>");%></td>
				</tr>
			
			<% 
					}
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