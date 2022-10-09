<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.Util"%>

<%
try{
	request.setCharacterEncoding("UTF-8");
	String mode = request.getParameter("mode");
	Connection conn = null;
	PreparedStatement pstmt = null;
	conn = Util.getConnection();
	
	if(mode.equals("register")){
		String regist_month = request.getParameter("regist_month");
		String c_no = request.getParameter("c_no");
		String class_area = request.getParameter("class_area");
		String class_price = request.getParameter("class_price");
		String class_no = request.getParameter("class_name");
		
		String sql = "insert into tbl_class_202201 values (?,?,?,?,?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,regist_month);
		pstmt.setString(2,c_no);
		pstmt.setString(3,class_area);
		pstmt.setString(4,class_price);
		pstmt.setString(5,class_no);
		pstmt.executeUpdate();
		
		%>
		<jsp:forward page="index.jsp"/>
		<%
		
	}
}
catch(Exception e){
	e.printStackTrace();
}
%>