<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	request.setCharacterEncoding("UTF-8");
	try{
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection
				("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		String sql = "insert into examtbl values(?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,request.getParameter("sNo"));
		pstmt.setString(2,request.getParameter("sName"));
		pstmt.setString(3,request.getParameter("kor"));
		pstmt.setString(4,request.getParameter("eng"));
		pstmt.setString(5,request.getParameter("math"));
		pstmt.setString(6,request.getParameter("hist"));
		
		pstmt.executeUpdate();
		
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}
	catch(Exception e){
		e.printStackTrace();
	}
%>