<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<section style="position:fixed; top:80px; left:0; width:100%; height:100%; background:beige">
		<h3 style="text-align:center; margin-left:20px">고등학교 성적 조회 프로그램</h3>
		<p style="margin-left:10px">
		<b>고등학교 성적을 조회하는 프로그램을 작성한다.</b><br><br>
		1. 학생성적정보 테이블을 생성한다.<br>
		2. 학생성적정보 테이블에 생성데이터를 SQL문을 사용하여 데이터를 추가생성한다.<br>
		3. 주어진 화면디자인을 이용하여 화면을 디자인한다.<br>
		4. 업무요건에 따라 프로그램을 작성한다.
		</p>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>