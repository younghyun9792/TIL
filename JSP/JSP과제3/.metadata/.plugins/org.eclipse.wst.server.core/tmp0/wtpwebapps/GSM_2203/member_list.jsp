<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util" %>
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


		<h3 style="text-align:center"><b>회원정보조회</b></h3>

		<form style="display:flex; align-items:center; justify-content:center; text-align:center;">
			<table border="1">
				<tr>
					<td>수강월</td>
					<td>회원번호</td>
					<td>회원명</td>
					<td>강의명</td>
					<td>강의장소</td>
					<td>수강료</td>
					<td>등급</td>
				</tr>
				
				
				<%
					Connection conn = null;
					PreparedStatement pstmt = null;
					try{
						String sql = "select regist_month, m.c_no, t.class_name, c_name, class_area, tuition, grade from tbl_member_202201 m, tbl_class_202201 c, tbl_teacher_202201 t where m.c_no = c.c_no and c.teacher_code = t.teacher_code";
						conn = Util.getConnection();
						pstmt = conn.prepareStatement(sql);
						ResultSet rs = pstmt.executeQuery();
						while(rs.next()){
				%>
				
				<tr>
					<td><%=rs.getString(1).substring(0,4)+"년"+rs.getString(1).substring(4,6)+"월"%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td>\<%=String.format("%,d",rs.getInt(6))%></td>
					<td><%=rs.getString(7)%></td>
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