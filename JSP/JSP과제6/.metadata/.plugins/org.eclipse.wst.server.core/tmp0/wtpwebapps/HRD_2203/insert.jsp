<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript" src="check.js"></script>
	<jsp:include page="header.jsp"></jsp:include>
	<section style="position:fixed; top:80px; left:0; width:100%; height:100%; background:beige">
		<h3 style="text-align:center; margin-left:20px">학생 성적 입력</h3>
			<form name="insert_frm" method="post" action="action.jsp" style="display:flex; align-items:center; justify-content:center; text-align:center">
				<table border="1">
					<tr>
						<td style="width:100px"><b>학번</b></td>
						<td><input type="text" name="sNo"></td>
					</tr>
					<tr>
						<td><b>성명</b></td>
						<td><input type="text" name="sName"></td>
					</tr>
					<tr>
						<td><b>국어</b></td>
						<td><input type="text" name="kor"></td>
					</tr>
					<tr>
						<td><b>영어</b></td>
						<td><input type="text" name="eng"></td>
					</tr>
					<tr>
						<td><b>수학</b></td>
						<td><input type="text" name="math"></td>
					</tr>
					<tr>
						<td><b>역사</b></td>
						<td><input type="text" name="hist"></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="성적저장" onclick="return chk_insert()">
						</td>
					</tr>
				</table>
			</form>
	</section>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>