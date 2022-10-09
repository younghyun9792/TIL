<%@page import="java.sql.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="dbCon.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	
	<section style="position:fixed; width:100%; height:100%; top:70px; background-color:gray; left:0'">
	
		<h2 style="text-align:center">카페 메뉴</h2>
	
	<form name="frm" style="display:flex; align-items:center; justify-content:center; text-align: center">
	<table border="1">
		<tr>
			<td>메뉴번호</td>
			<td>메뉴이름</td>
			<td>가격</td>
			<td>칼로리</td>
		</tr>
		<%
			request.setCharacterEncoding("UTF-8");
			PreparedStatement pstmt = null;
			
			try{
				String sql = "select * from menu_tbl order by menuno asc";
				pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
				while(rs.next()){
					%>
					
					<tr>
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %>원</td>
					<td><%=rs.getString(4) %></td>
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