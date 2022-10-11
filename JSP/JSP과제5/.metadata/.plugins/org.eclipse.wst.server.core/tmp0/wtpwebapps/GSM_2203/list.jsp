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
		<h3>전체 도서 리스트</h3>
		<form style="display:flex; align-items:center; justify-content:center; text-align:center">
			<table border="1">
			
			<tr>
				<td>도서번호</td>
				<td>도서명</td>
				<td>장르</td>
				<td>가격</td>
				<td>남은 수량</td>
				<td>대출가능여부</td>
			</tr>
			
			<% 
				request.setCharacterEncoding("UTF-8");
				Connection conn = null;
				PreparedStatement pstmt = null;
				try{
					conn = Util.getConnection();
					String sql = "select b.bookno, b.bookname, b.genre, b.price, b.amount-count(r.bor_no) from book_tbl b left outer join borrow_tbl r on r.bookno=b.bookno and r.re_book = '대여' group by b.bookno, b.bookname, b.genre, b.price, b.amount order by b.bookno";
					pstmt = conn.prepareStatement(sql);
					ResultSet rs = pstmt.executeQuery();
					while(rs.next()){
				
			%>
			
				<tr>
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td>\<%=String.format("%,d",rs.getInt(4)) %></td>
					<td><%=rs.getString(5) %>권</td>
					<td><%if(Integer.parseInt(rs.getString(5))>=1)out.println("<a href='borrow.jsp?bookno="+rs.getString(1)+"&"+"bookname="+rs.getString(2)+"'>대출하기</a>"); %></td>
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