<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
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
<jsp:include page="header.jsp"></jsp:include>
	
	<section style="position:fixed; width:100%; height:100%; top:70px; background-color:gray; left:0'">
	
	<h2 style="display:fixed; text-align:center;">주문 조회 페이지 </h2>
	<form name="frm" style="display:flex; align-items:center; justify-content:center; text-align:center;">
		<table border="1" style="border-collapse: collapse">
			<tr>
			<td colspan="9" style="text-align:right; border-left: hidden; border-top: hidden; border-right: hidden"><a href="order.jsp">주문하기</a></td>
			</tr>
			<tr>
				<td>주문번호</td>
				<td>고객번호</td>
				<td>고객이름</td>
				<td>메뉴이름</td>
				<td>수량</td>
				<td>지불금액</td>
				<td>주문일자</td>
				<td>수정</td>
				<td>삭제</td>
			</tr>
			
			<%
				request.setCharacterEncoding("UTF-8");
				PreparedStatement pstmt = null;
			
				try{
					String sql="select o.orderno, o.custno, o.custname, m.menuname, o.amount, o.amount*m.price, o.orderdate from order_tbl o ,menu_tbl m where o.menuno = m.menuno";
					pstmt = conn.prepareStatement(sql);
					ResultSet rs = pstmt.executeQuery();
					int hello=0;
					while(rs.next()){
						hello=Integer.valueOf(rs.getString(6));
						DecimalFormat DF = new DecimalFormat("###,###");
						String price = DF.format(hello);
						
						%>
						
						<tr>
							<td><%=rs.getString(1)%></td>
							<td><%=rs.getString(2)%></td>
							<td><%=rs.getString(3)%></td>
							<td><%=rs.getString(4)%></td>
							<td><%=rs.getString(5)%></td>
							<td><%=price%>원</td>
							<td><%=rs.getDate(7)%></td>
							<td><a href="modify.jsp?orderno=<%=rs.getString(1)%>">주문 수정</a></td>
							<td><a href="action2.jsp?order_no=<%=rs.getString(1)%>&mode=delete">주문 삭제</a></td>
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