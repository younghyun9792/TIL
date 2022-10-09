<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="DBPKG.Util"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="check.js"></script>	
	<jsp:include page="header.jsp"></jsp:include>
	
	 <section style="position:fixed; width:100%; height:100%; top:110px; left:0; background:beige">
 
	 	<h3 style="text-align:center;">회원목록조회/수정</h3>
	 
	 	<%
	 		Connection conn = null;
	 		PreparedStatement pstmt = null;
	 		
	 		try{
	 			conn = Util.getConnection();
	 			String sql ="select * from member_tbl_02 order by custno";
	 			pstmt = conn.prepareStatement(sql);
	 			ResultSet rs = pstmt.executeQuery();
	 				
	 		%>
	 		<form style="display:flex; justify-content:center; align-items:center; text-align:center;">
	 		<table border="1">
	 			<tr>
	 				<td>회원번호</td>
	 				<td>회원성명</td>
	 				<td>전화번호</td>
	 				<td>주소</td>
	 				<td>가입일자</td>
	 				<td>고객등급</td>
	 				<td>거주지역</td>
	 			</tr>
	 			<%
	 			while(rs.next()){
	 			%>
	 			<tr>	
	 				<td><a href="modify.jsp?custno=<%=rs.getString(1)%>"><%=rs.getString(1) %></a></td>
	 				<td><%=rs.getString(2) %></td>
	 				<td><%=rs.getString(3) %></td>
	 				<td><%=rs.getString(4) %></td>
	 				<td><%=rs.getDate(5) %></td>
	 				<td><%if(rs.getString(6).equals("A"))out.println("VIP");else if(rs.getString(6).equals("B"))out.println("일반");else if(rs.getString(6).equals("C"))out.println("직원");%></td>
	 				<td><%=rs.getString(7) %></td>
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