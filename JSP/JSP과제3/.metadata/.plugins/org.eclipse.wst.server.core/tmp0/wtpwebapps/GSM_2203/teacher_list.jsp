<%@page import="DBPKG.Util"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
	<section style="position:fixed; top:135px; width:100%; height:100%; left:0; background: gray;">
	
		<h3 style="text-align:center"><b>강사조회</b></h3>
	
		<form style="display:flex; align-items:center; justify-content:center; text-align:center">
			<table border="1">
				<tr>
					<td>강사코드</td>
					<td>강사명</td>
					<td>강의명</td>
					<td>수강료</td>
					<td>강사자격취득일</td>
				</tr>
				
				<%
				request.setCharacterEncoding("UTF-8");
				Connection conn = null;
				PreparedStatement pstmt = null;
				
				try{
					conn = Util.getConnection();
					String sql = "select * from TBL_TEACHER_202201";
					pstmt = conn.prepareStatement(sql);
					ResultSet rs = pstmt.executeQuery();
					
					while(rs.next()){
				%>
				<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td>₩<%=String.format("%,d",rs.getInt(4))%></td>
					<td><%=rs.getString(5).substring(0,4)+"년"+rs.getString(5).substring(4,6)+"월"+rs.getString(5).substring(6,8)+"일"%></td>
				</tr>
					
				<%
					}
				}
				catch(Exception e){
					e.printStackTrace();				}
				%>
			</table>
		</form>
	
	</section>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>