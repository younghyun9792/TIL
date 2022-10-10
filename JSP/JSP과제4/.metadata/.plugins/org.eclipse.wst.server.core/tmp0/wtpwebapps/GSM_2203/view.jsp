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
	
	<section style="position:fixed; top:95px; left:0; background:gray; width:100%; height:100%; padding-left:15px">
	
		<h2 style="text-align:center">후보조회</h2>
		
		<form style="display:flex; align-items:center; justify-content:center; text-align:center">
			<table border="1">
				<tr>
					<td>후보번호</td>
					<td>성명</td>
					<td>소속정당</td>
					<td>학력</td>
					<td>주민번호</td>
					<td>지역구</td>
					<td>대표전화</td>
				</tr>
				
				<%
				
					Connection conn = null;
					PreparedStatement pstmt = null;
					
					try{
						conn = Util.getConnection();
						String sql = "select M_NO, M_NAME, P_NAME, P_SCHOOL, M_JUMIN, M_CITY, P_TEL1, P_TEL2, P_TEL3 from tbl_member_202005 m, tbl_party_202005 t where m.P_CODE = t.P_CODE order by M_NO";
						pstmt = conn.prepareStatement(sql);
						ResultSet rs = pstmt.executeQuery();
						while(rs.next()){
							
					
				%>
				
					<tr>
						<td><%=rs.getString(1) %></td>
						<td><%=rs.getString(2) %></td>
						<td><%=rs.getString(3) %></td>
						<td><%if(rs.getString(4).equals("1")) out.println("고졸");else if(rs.getString(4).equals("2")) out.println("학사"); else if(rs.getString(4).equals("3")) out.println("석사");else if(rs.getString(4).equals("4")) out.println("박사");%></td>
						<td><%=rs.getString(5).substring(0,6)+"-"+rs.getString(5).substring(6,13) %></td>
						<td><%=rs.getString(6) %></td>
						<td><%=rs.getString(7)%>-<%=rs.getString(8)%>-<%=rs.getString(9) %></td>
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