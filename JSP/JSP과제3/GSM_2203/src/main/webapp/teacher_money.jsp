<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
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
		<h3 style="text-align:center"><b>강사매출조회</b></h3>
	
		<form style="display:flex; align-items:center; justify-content:center; text-align:center">
			<table border="1">
				<tr>
					<td>강사코드</td>
					<td>강의명</td>
					<td>강사명</td>
					<td>총매출</td>
				</tr>
				
				
		<% 
		Connection conn = null;
		PreparedStatement pstmt = null;
		try{
			String sql = "select t.teacher_code, t.class_name, t.teacher_name, sum(c.tuition) from tbl_teacher_202201 t, tbl_class_202201 c where t.teacher_code = c.teacher_code group by t.teacher_code, t.class_name, t.teacher_name order by t.teacher_code";
			conn = Util.getConnection();
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
		%>
		
			<tr>
			<td><%=rs.getString(1) %></td>
			<td><%=rs.getString(2) %></td>
			<td><%=rs.getString(3) %></td>
			<td>\<%=String.format("%,d", rs.getInt(4))%></td>
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