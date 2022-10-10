<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	String mode = request.getParameter("mode");
	
	try{
		if(mode.equals("vote")){
			String V_JUMIN = request.getParameter("V_JUMIN");
			String V_NAME = request.getParameter("V_NAME");
			String M_NO = request.getParameter("M_NO");
			String V_TIME = request.getParameter("V_TIME");
			String V_AREA = request.getParameter("V_AREA");
			String V_CONFIRM = request.getParameter("V_CONFIRM");
			
			conn = Util.getConnection();
			String sql = "insert into tbl_vote_202005 values (?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,V_JUMIN);
			pstmt.setString(2,V_NAME);
			pstmt.setString(3,M_NO);
			pstmt.setString(4,V_TIME);
			pstmt.setString(5,V_AREA);
			pstmt.setString(6,V_CONFIRM);
			pstmt.executeUpdate();
			%>
			<jsp:forward page="index.jsp"></jsp:forward>
			<%
		}
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
%>