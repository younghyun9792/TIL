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
	
		<h2 style="text-align:center">후보자등수</h2>
		
		<form style="display:flex; align-items:center; justify-content:center; text-align:center">
			<table border="1">
				<tr>
					<td>후보번호</td>
					<td>성명</td>
					<td>총투표건수</td>
				</tr>
				
				<%
				
					Connection conn = null;
					PreparedStatement pstmt = null;
					
					try{
						conn = Util.getConnection();
						String sql = "select m.m_no, m.m_name, count(v.m_no)  from TBL_MEMBER_202005 m, TBL_VOTE_202005 v where m.m_no = v.m_no and v.V_CONFIRM = 'Y' group by m.m_name, m.m_no, v.m_no order by count(v.M_NO) desc";
						pstmt = conn.prepareStatement(sql);
						ResultSet rs = pstmt.executeQuery();
						while(rs.next()){
							
					
				%>
				
					<tr>
						<td><%=rs.getString(1) %></td>
						<td><%=rs.getString(2) %></td>
						<td><%=rs.getString(3) %></td>
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