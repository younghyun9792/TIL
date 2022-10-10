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
	
		<h2 style="text-align:center">투표검수조회</h2>
		
		<form style="display:flex; align-items:center; justify-content:center; text-align:center">
			<table border="1">
				<tr>
					<td>성명</td>
					<td>생년월일</td>
					<td>나이</td>
					<td>성별</td>
					<td>후보번호</td>
					<td>투표시간</td>
					<td>유권자확인</td>
				</tr>
				
				<%
				
					Connection conn = null;
					PreparedStatement pstmt = null;
					
					try{
						conn = Util.getConnection();
						String sql = "select V_NAME, V_JUMIN, M_NO, V_TIME, V_CONFIRM from tbl_vote_202005 where V_AREA = '제1투표장'";
						pstmt = conn.prepareStatement(sql);
						ResultSet rs = pstmt.executeQuery();
						while(rs.next()){
							
					
				%>
				
					<tr>
						<td><%=rs.getString(1) %></td>
						<td>19<%=rs.getString(2).substring(0,2)+"년"+rs.getString(2).substring(2,4)+"월"+rs.getString(2).substring(4,6)+"일생"%></td>
						<td>만 <%=2020-Integer.parseInt("19"+rs.getString(2).substring(0,2)) %>세</td>
						<td><%if((rs.getString(2).substring(6,7)).equals("1"))out.println("남자");else if((rs.getString(2).substring(6,7)).equals("2"))out.println("여자");%></td>
						<td><%=rs.getString(3)%></td>
						<td><%=rs.getString(4).substring(0,2)+":"+rs.getString(4).substring(2,4) %></td>
						<td><%if(rs.getString(5).equals("Y"))out.println("확인");else if(rs.getString(5).equals("N"))out.println("미확인");%></td>
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