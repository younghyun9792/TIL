<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section style="position:fixed; top:80px; left:0; width:100%; height:100%; background:beige">
		<h3 style="text-align:center; margin-left:20px">성적조회목록</h3>
		<form style="display:flex; align-items:center; justify-content:center; align-text:center">
			<table border="1">
				<tr>
					<td style="text-align:center; width:60px">학년</td>
					<td style="text-align:center; width:60px">반</td>
					<td style="text-align:center; width:60px">번호</td>
					<td style="text-align:center; width:100px">성명</td>
					<td style="text-align:center; width:70px">국어</td>
					<td style="text-align:center; width:70px">영어</td>
					<td style="text-align:center; width:70px">수학</td>
					<td style="text-align:center; width:70px">역사</td>
					<td style="text-align:center; width:70px">총점</td>
					<td style="text-align:center; width:70px">평균</td>
				</tr>
				
				<%
				Connection conn = null;
				PreparedStatement pstmt = null;
				request.setCharacterEncoding("UTF-8");
				try{
					Class.forName("oracle.jdbc.OracleDriver");
					conn = DriverManager.getConnection
							("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
					String sql = "select sNo, sName, kor, eng, math, hist, kor+eng+math+hist, (kor+eng+math+hist)/4 from examtbl order by sNo";
					pstmt = conn.prepareStatement(sql);	
					ResultSet rs = pstmt.executeQuery();
					while(rs.next()){	
					%>
					<tr>
						<td style="text-align:center"><%=rs.getString(1).substring(0,1) %></td>
						<td style="text-align:center"><%=rs.getString(1).substring(1,3) %></td>
						<td style="text-align:center"><%=rs.getString(1).substring(3,5) %></td>
						<td style="text-align:center"><%=rs.getString(2) %></td>
						<td style="text-align:right"><%=rs.getString(3) %></td>
						<td style="text-align:right"><%=rs.getString(4) %></td>
						<td style="text-align:right"><%=rs.getString(5) %></td>
						<td style="text-align:right"><%=rs.getString(6) %></td>
						<td style="text-align:right"><%=rs.getString(7) %></td>
						<td style="text-align:right"><%=rs.getString(8) %></td>
					</tr>
					<%
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}  %>
				
			</table>
		</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>