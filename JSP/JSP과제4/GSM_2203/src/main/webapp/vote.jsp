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
	<script type="text/javascript" src="check.js"></script>
	<jsp:include page="header.jsp"></jsp:include>
	
	<section style="position:fixed; top:95px; left:0; background:gray; width:100%; height:100%; padding-left:15px">
	
		<h2 style="text-align:center">투표하기</h2>
		
		<form name="vote_frm" method="post" action="action.jsp" style="display:flex; align-items:center; justify-content:center;">
			<input type="hidden" name="mode" value="vote">
			<table border="1">
				<tr>
					<td style="text-align:center">주민번호</td>
					<td><input type="text" name="V_JUMIN"> 예 : 8906153154726</td>
				</tr>
				<tr>
					<td style="text-align:center">성명</td>
					<td><input type="text" name="V_NAME"></td>
				</tr>
				<tr>
					<td style="text-align:center">투표번호</td>
					<td>
					<select name="M_NO">
						<%
							Connection conn = null;
							PreparedStatement pstmt = null;
							try{
								conn = Util.getConnection();
								String sql = "select M_NO from tbl_member_202005";
								pstmt = conn.prepareStatement(sql);
								ResultSet rs = pstmt.executeQuery();
								while(rs.next()){
									
							
						%>
							<option><%=rs.getString(1) %></option>
						<%
								}
							}
							catch(Exception e){
								e.printStackTrace();
							}
						%>
					</select>
					</td>
				</tr>
				<tr>
					<td style="text-align:center">투표시간</td>
					<td><input type="text" name="V_TIME"></td>
				</tr>
				<tr>
					<td style="text-align:center">투표장소</td>
					<td><input type="text" name="V_AREA"></td>
				</tr>
				<tr>
					<td style="text-align:center">유권자확인</td>
					<td>
						<input type="radio" name="V_CONFIRM" value="Y"> 확인&nbsp;
						<input type="radio" name="V_CONFIRM" value="N"> 미확인
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center;">
					<input type="submit" value="투표하기" onclick="return chk_vote()">
					<input type="reset" value="다시하기" onclick="return chk_reset()">
					</td>
				</tr>
			</table>
		</form>
		
	</section>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>