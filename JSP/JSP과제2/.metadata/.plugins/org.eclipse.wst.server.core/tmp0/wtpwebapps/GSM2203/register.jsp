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
 
	 	<h3 style="text-align:center;">홈쇼핑 회원 등록</h3>
	 
	 	<%
	 		Connection conn = null;
	 		PreparedStatement pstmt = null;
	 		
	 		try{
	 			conn = Util.getConnection();
	 			String sql ="select max(custno)+1 from member_tbl_02";
	 			pstmt = conn.prepareStatement(sql);
	 			ResultSet rs = pstmt.executeQuery();
	 			rs.next();
	 		%>
	 		
	 		
	 	
	 
	 	<form name="register_frm" method="post" action="action.jsp" style="display:flex; align-items:center; justify-content:center; text-align:center">
	 	<input type="hidden" name="mode" value="insert">	
	 		<table border="1">
	 			<tr>
	 				<td><b>회원번호(자동발생)</b></td>
	 				<td><input type="text" name="custno" value="<%=rs.getString(1)%>"></td>
	 			</tr>
	 			<tr>
	 				<td><b>회원성명</b></td>
	 				<td><input type="text" name="custname"></td>
	 			</tr>
	 			<tr>
	 				<td><b>회원전화</b></td>
	 				<td><input type="text" name="phone"></td>
	 			</tr>
	 			<tr>
	 				<td><b>회원주소</b></td>
	 				<td><input type="text" name="address"></td>
	 			</tr>
	 			<tr>
	 				<td><b>가입일자</b></td>
	 				<td><input type="text" name="joindate"></td>
	 			</tr>
	 			<tr>
	 				<td><b>고객등급(A:VIP,B:일반,C:직원)</b></td>
	 				<td><input type="text" name="grade"></td>
	 			</tr>
	 			<tr>
	 				<td><b>도시코드</b></td>
	 				<td><input type="text" name="city"></td>
	 			</tr>
	 			<tr>
	 				<td colspan="2">
	 				<input type="submit" value="등록" onclick="return chk_register()">
	 				<input type="button" value="조회" onclick="return search()">
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	 
	 </section>
	 
		<%	
	 	
	 		}
	 		catch(Exception e){
	 			e.printStackTrace();
	 		}
	 	%>
	 	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>