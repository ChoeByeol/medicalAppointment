<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<form action="<%=request.getContextPath()%>/reservation/test.txt" method="post">
		<div class="container-400 container-center">
			<div class="row center">
				<h1>�׽�Ʈ�ϱ�</h1>
			</div>

			<div class="row">
				<label>������ȣ</label> 
				<input type="text" name="clinicNo" class="form-input">
			</div>

			<div class="row">
				<label>��Ź�ȣ</label> 
				<input type="text" name="vaccineNo" class="form-input">
			</div>

			<div class="row right">
				<input type="submit" value="�׽�Ʈ" class="link-btn">
			</div>
		</div>

	</form>

</body>
</html>