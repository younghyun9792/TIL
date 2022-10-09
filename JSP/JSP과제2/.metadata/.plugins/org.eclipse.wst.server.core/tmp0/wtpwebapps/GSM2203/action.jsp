<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>

<%
request.setCharacterEncoding("UTF-8");
String mode = request.getParameter("mode");
String custno = request.getParameter("custno");
String custname = request.getParameter("custname");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String joindate = request.getParameter("joindate");
String grade= request.getParameter("grade");
String city = request.getParameter("city");

Connection conn = Util.getConnection();
PreparedStatement pstmt = null;

try{
	if(mode.equals("modify")){
		String sql = "update member_tbl_02 set custname = ?, phone = ?, address = ?, joindate = ?, grade = ?, city = ? where custno = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,custname);
		pstmt.setString(2,phone);
		pstmt.setString(3,address);
		pstmt.setString(4,joindate);
		pstmt.setString(5,grade);
		pstmt.setString(6,city);
		pstmt.setString(7,custno);
		pstmt.executeUpdate();
		%>
		<jsp:forward page="list.jsp"></jsp:forward>
		<%
	}
	else if(mode.equals("insert")){
		String sql = "insert into member_tbl_02 values(?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,custno);
		pstmt.setString(2,custname);
		pstmt.setString(3,phone);
		pstmt.setString(4,address);
		pstmt.setString(5,joindate);
		pstmt.setString(6,grade);
		pstmt.setString(7,city);
		pstmt.executeUpdate();
		%>
		<jsp:forward page="list.jsp"></jsp:forward>
		<%
	}
}
catch(Exception e){
	e.printStackTrace();
}
	

%>