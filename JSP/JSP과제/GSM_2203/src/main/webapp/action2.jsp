<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="dbCon.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	PreparedStatement pstmt = null;
	String mode = request.getParameter("mode");

	String order_no = request.getParameter("order_no");
	String custno = request.getParameter("custno");
	String custname = request.getParameter("custname");
	String menu = request.getParameter("menu");
	String amount = request.getParameter("amount");
	String custdate = request.getParameter("custdate");
	
	try{
		String sql = "";
		switch(mode){
		case "insert":
			sql = "insert into order_tbl values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_no);
			pstmt.setString(2, custno);
			pstmt.setString(3, custname);
			pstmt.setString(4, menu);
			pstmt.setString(5, amount);
			pstmt.setString(6, custdate);
			
			pstmt.executeUpdate();
			
			%>
			<jsp:forward page="orderlist.jsp"></jsp:forward>
			<%
			break;
		case "update":
			
			sql = "update order_tbl set custno = ?, custname = ?, menuno = ?, amount = ?, orderdate = ? where orderno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,custno);
			pstmt.setString(2,custname);
			pstmt.setString(3,menu);
			pstmt.setString(4,amount);
			pstmt.setString(5,custdate);
			pstmt.setString(6,order_no);
	
			pstmt.executeUpdate();
			
			%>
			<jsp:forward page="orderlist.jsp"></jsp:forward>
			<%
			
			break;

		case "delete":
			sql = "delete from order_tbl where orderno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,order_no);
			
			pstmt.executeUpdate();
			%>
			<jsp:forward page="orderlist.jsp"></jsp:forward>
			<%
		}
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	%>

</body>
</html>