<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="DBPKG.Util"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
	<script type="text/javascript" src="check.js"></script>
	<jsp:include page="header.jsp"></jsp:include>
	
	<section style="position:fixed; top:135px; width:100%; height:100%; left:0; background: gray;">
		<h3 style="text-align:center"><b>수강신청</b></h3>
	
	
	<form method="post" action="action.jsp" name="register_frm" style="display:flex; align-items:center; justify-content:center;">
	<input type="hidden" name="mode" value="register">
	<table border="1">
		<tr>
			<td style="text-align:center">수강월</td>
			<td><input type="text" name="regist_month"> 2022년2월2얼 예)20220202</td>
		</tr>
		<tr>
			<td style="text-align:center">회원명</td>
			<td>
				<select name="c_name" onchange="return chg_name(this)">
					<%
						request.setCharacterEncoding("UTF-8");
						Connection conn = null;
						PreparedStatement pstmt = null;
						try{
							conn=Util.getConnection();
							String sql = "select c_name,c_no from TBL_MEMBER_202201";
							pstmt = conn.prepareStatement(sql);
							ResultSet rs = pstmt.executeQuery();
							while(rs.next()){

						%>
					<option id="<%=rs.getString(2)%>"><%=rs.getString(1) %></option>
				
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
			<td style="text-align:center">회원번호</td>
			<td><input type = "text" name="c_no"> 예)10013</td>
		</tr>
		<tr>
			<td style="text-align:center">강의장소</td>
			<td>
			<select name="class_area">
				<option value="서울분원">서울본원</option>
				<option value="성남분원">성남분원</option>
				<option value="대전분원">대전분원</option>
				<option value="부산분원">부산분원</option>
				<option value="대구분원">대구분원</option>
			</select>
			</td>	
		</tr>
		<tr>
			<td style="text-align:center">강의명</td>
			<td>
				<select name="class_name" onchange="chg_class_name(this);">
				
				<%
					try{
						String sql2 = "select class_name, teacher_code, class_price from tbl_teacher_202201";
						pstmt = conn.prepareStatement(sql2);
						ResultSet rs2 = pstmt.executeQuery();
						while(rs2.next()){
					
				%>
				
					<option value="<%=rs2.getString(2)%>" id="<%=rs2.getString(3)%>"><%=rs2.getString(1) %></option>
			
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
			<td style="text-align:center">수강료</td>
			<td><input type="text" name="class_price"></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center">
				<input type="submit" value="수강하기" onclick="return chk_register()">
				<input type="reset" value="다시쓰기">
			</td>
		</tr>
	</table>
	</form>
	
	</section>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>