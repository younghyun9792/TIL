<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "dbCon.jsp"%>
<%@page import="java.lang.*"%>


<%
	request.setCharacterEncoding("UTF-8");
	//PreparedStatement pstmt = null;
	String mode = request.getParameter("mode");
	
	String order_no = request.getParameter("order_no");
	String custno = request.getParameter("custno");
	String custname = request.getParameter("custname");
	String menu = request.getParameter("menu");
	String amount = request.getParameter("amount");
	String custdate = request.getParameter("custdate");

	String sql = "";
	
	try{
		switch(mode){
		case "insert" :
			sql="insert into order_tbl values(?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_no);
			pstmt.setString(2, custno);
			pstmt.setString(3, custname);
			pstmt.setString(4, menu);
			pstmt.setString(5, amount);
			pstmt.setString(6, custdate);
			
			pstmt.executeUpdate();
			%>
			<jsp:forward page="orderlist.jsp"/>
			<%
			break;

		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	%>