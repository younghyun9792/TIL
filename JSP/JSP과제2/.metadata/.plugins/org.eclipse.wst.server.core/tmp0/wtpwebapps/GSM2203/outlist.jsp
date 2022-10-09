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
 
	 	<h3 style="text-align:center;">회원매출조회</h3>
	 
	 	<%
	 		Connection conn = null;
	 		PreparedStatement pstmt = null;
	 		
	 		try{
	 			conn = Util.getConnection();
	 			String sql ="select member.custno, member.custname, member.grade, sum(money.price) from member_tbl_02 member, money_tbl_02 money where member.custno = money.custno group by money.custno, member.custno, member.custname, member.grade order by sum(money.price) desc ";
	 			pstmt = conn.prepareStatement(sql);
	 			ResultSet rs = pstmt.executeQuery();
	 				
	 		%>
	 		<form style="display:flex; justify-content:center; align-items:center; text-align:center;">
	 		<table border="1">
	 			<tr>
	 				<td><b>회원번호</b></td>
	 				<td><b>회원성명</b></td>
	 				<td><b>고객등급</b></td>
	 				<td><b>매출</b></td>
	 			</tr>
	 			<%
	 			while(rs.next()){
	 			%>
	 			<tr>	
	 				<td><%=rs.getString(1) %></td>
	 				<td><%=rs.getString(2) %></td>
	 				<td><%if(rs.getString(3).equals("A"))out.println("VIP");else if(rs.getString(3).equals("B"))out.println("일반");else if(rs.getString(3).equals("C"))out.println("직원");%></td>
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