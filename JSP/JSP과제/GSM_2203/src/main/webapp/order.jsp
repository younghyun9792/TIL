<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="dbCon.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp" ></jsp:include>
	<script type="text/javascript" src = "check.js"></script>
	<section style="position:fixed; width:100%; height:100%; top:70px; background-color:gray; left:0'">
	
	<h2 style="display:fixed; text-align:center;">카페 메뉴 주문하기 </h2>
		
		<form name="order_frm" method="post" action="action2.jsp" style="display:flex; align-items:center; justify-content:center; text-align:center">
		
		<table border="1">
			<tr>
				<td>주문번호</td>
				
				<%
					request.setCharacterEncoding("UTF-8");
					String sql = "select max(orderno)+1 from order_tbl";
					PreparedStatement pstmt = null;
					String max_custno = "";
					try{
						pstmt = conn.prepareStatement(sql);
						ResultSet rs = pstmt.executeQuery();
						rs.next();
						max_custno = rs.getString(1);
					}
					catch(Exception e){
						e.printStackTrace();
					}
				%>
				
				<td><input type="text" value="<%=max_custno %>" name="order_no"></td>
			</tr>
			<tr>
				<td>고객번호</td>
				<td><input type="text" name="custno"></td>
			</tr>
			<tr>
				<td>고객이름</td>
				<td><input type="text" name="custname"></td>
			</tr>
			<tr>
				<td>메뉴번호</td>
				<td><input type="radio" value="10001" name="menu">아메리카노 
				<input type="radio" value="10002" name="menu">카페 라떼 
				<input type="radio" value="10003" name="menu">카페 모카 
				<input type="radio" value="10004" name="menu">돌체 라떼 
				<input type="radio" value="10005" name="menu">콜드 브루</td>
			</tr>
			<tr>
				<td>수량</td>
				<td><select name="amount">
					<option value="1" selected>1개(추가 주문 시 선택)</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select></td>
			</tr>
			<tr>
				<td>주문일자</td>
				<td><input type="text" placeholder="예)20220106" name="custdate"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type = "submit" value="주문하기" onclick="return rere_order()">&nbsp;&nbsp;&nbsp;
				<input type = "reset" value="다시하기" onclick="return rere_reset()">
				<input type="hidden" name="mode" value="insert">
				</td>
			</tr>
			
		</table>
		</form>
	
	</section>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>