<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	  request.setCharacterEncoding("EUC-KR");
	  String id = (String)session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.member_id.value == "") {
			alert("���̵� �Է��� �ּ���.");
			document.loginFrm.member_id.focus();
			return;
		}
		if (document.loginFrm.member_pwd.value == "") {
			alert("��й�ȣ�� �Է��� �ּ���.");
			document.loginFrm.member_pwd.focus();
			return;
		}
		document.loginFrm.submit();
	}
</script>



<title>�α���</title>
</head>
<body>
	<div class="login_containers"> 
		<h2> 
			�α���
		 </h2> 
		 <%if (id != null) {%>
			<script>	
				location.href="MainForm.jsp?contentPage=Home/home.jsp";
			</script>
		<%} else {%>
		<form name="loginFrm" method="post" action="MainForm.jsp?contentPage=JoinLogin/loginProc.jsp"> 
		<h3>
			���̵�
		</h3> 
		<div class="loginID"> 
			<input type="text" class="input" placeholder="���̵�" name="member_id" maxlength="20"> 
		</div> 
		<h3>
			��й�ȣ
		</h3> 
		<div class="loginPassword"> 
			<input type="password" class="input" placeholder="��й�ȣ" name="member_pwd" maxlength="20"> 
		</div> 
		<input type="button" class="bt_login" value="�α���" onclick="loginCheck()">&nbsp;
		<input type="button" class="bt_join" value="ȸ������" onclick="location.href='MainForm.jsp?contentPage=JoinLogin/JoinForm.jsp&title=JOIN'">
		</form> 
		<%}%>
	</div>
</body>
</html>