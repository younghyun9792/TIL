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
	
	<h2 style="display:fixed; text-align:center;">주문 수정하기 </h2>
		
		<form name="modify_frm" method="post" action="action2.jsp" style="display:flex; align-items:center; justify-content:center; text-align:center;">
		<table border="1">
			<tr>
				<td>주문번호</td>
				
				<%
					request.setCharacterEncoding("UTF-8");
					String orderno = request.getParameter("orderno");
					String sql = "select * from order_tbl where orderno = ? ";
					PreparedStatement pstmt = null;
					String max_custno = "";
					String custno = "";
					String custname = "";
					String menu = "";
					String amount = "";
					Date custdate = null;
					try{
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1,orderno);
						ResultSet rs = pstmt.executeQuery();
						rs.next();
						orderno = rs.getString(1);
						custno = rs.getString(2);
						custname = rs.getString(3);
						menu = rs.getString(4);
						amount = rs.getString(5);
						custdate = rs.getDate(6);
					}
					catch(Exception e){
						e.printStackTrace();
					}
				%>
				
				<td><input type="text" value="<%=orderno %>" name = "order_no"></td>
			</tr>
			<tr>
				<td>고객번호</td>
				<td><input type="text" name="custno" value="<%=custno%>"></td>
			</tr>
			<tr>
				<td>고객이름</td>
				<td><input type="text" name="custname" value="<%=custname%>"></td>
			</tr>
			<tr>
				<td>메뉴번호</td>
				
				<td>
				<input type="radio" value="10001" name="menu" <%if(menu.equals("10001")) out.println("checked"); %>>아메리카노 
				<input type="radio" value="10002" name="menu" <%if(menu.equals("10002")) out.println("checked"); %>>카페 라떼 
				<input type="radio" value="10003" name="menu" <%if(menu.equals("10003")) out.println("checked"); %>>카페 모카 
				<input type="radio" value="10004" name="menu" <%if(menu.equals("10004")) out.println("checked"); %>>돌체 라떼 
				<input type="radio" value="10005" name="menu" <%if(menu.equals("10005")) out.println("checked"); %>>콜드 브루
				</td>
			</tr>
			<tr>
				<td>수량</td>
				<td><select name="amount">
					<option value="1" <%if(amount.equals("1")) out.println("selected"); %>>1개(추가 주문 시 선택)</option>
					<option value="2" <%if(amount.equals("2")) out.println("selected"); %>>2</option>
					<option value="3" <%if(amount.equals("3")) out.println("selected"); %>>3</option>
					<option value="4" <%if(amount.equals("4")) out.println("selected"); %>>4</option>
					<option value="5" <%if(amount.equals("5")) out.println("selected"); %>>5</option>
					<option value="6" <%if(amount.equals("6")) out.println("selected"); %>>6</option>
					<option value="7" <%if(amount.equals("7")) out.println("selected"); %>>7</option>
					<option value="8" <%if(amount.equals("8")) out.println("selected"); %>>8</option>
					<option value="9" <%if(amount.equals("9")) out.println("selected"); %>>9</option>
					<option value="10" <%if(amount.equals("10")) out.println("selected"); %>>10</option>
				</select></td>
			</tr>
			<tr>
				<td>주문일자</td>
				<td><input type="text" placeholder="예)20220106" name="custdate" value="<%=custdate%>"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type = "submit" value="수정하기" onclick="return rere_modify()">&nbsp;&nbsp;&nbsp;
				<input type = "reset" value="다시하기" onclick="return rere_reset()">
				<input type="hidden" name="mode" value="update">
					</td>
			</tr>
			
		</table>
		</form>
	
	</section>
	<script>
	document.modify_frm.menu[<%=menu%>].checked();
	var amount = document.modify_frm.amount
	for(var i = 0; i != amount.length; i ++){
		if amount[i].value == <%=amount%>){
			amount[i].selected = true;
		}
	}</script>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>