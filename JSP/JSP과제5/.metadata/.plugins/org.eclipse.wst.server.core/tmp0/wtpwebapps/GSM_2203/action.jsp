<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%
	request.setCharacterEncoding("UTF-8");
	String mode = request.getParameter("mode");
	Connection conn = null;
	PreparedStatement pstmt = null;
	conn = Util.getConnection();
	if(mode.equals("borrow")){
		String bor_no = request.getParameter("bor_no");
		String m_no = request.getParameter("m_no");
		String m_name = request.getParameter("m_name");
		String bookno = request.getParameter("bookno");
		String bookname = request.getParameter("bookname");
		String bor_date = request.getParameter("bor_date");
		String re_book = "대여";
		String sql = "insert into borrow_tbl values(?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,bor_no);
		pstmt.setString(2,m_no);
		pstmt.setString(3,m_name);
		pstmt.setString(4,bookno);
		pstmt.setString(5,bookname);
		pstmt.setString(6,bor_date);
		pstmt.setString(7,re_book);
		
		pstmt.executeUpdate();
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}
	else if(mode.equals("return")){
		String bor_no = request.getParameter("bor_no");
		String sql2 = "update borrow_tbl set re_book = '반납' where bor_no= ? ";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1,bor_no);
		pstmt.executeUpdate();
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}
%>