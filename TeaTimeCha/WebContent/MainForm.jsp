<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="headerStyle.css" type="text/css">
<link rel="stylesheet" href="ChaStyle.css" type="text/css">

<%
	request.setCharacterEncoding("UTF-8");
    String contentPage = "Home/home.jsp";
    String a = request.getParameter("contentPage");
    if (a != null) {
         contentPage = a;
    }
	String title = "TEA TIME, CHA CHA CHA";
	String t = request.getParameter("title");
    if (t != null) {
    	title = new String(t.getBytes("8859_1"), "UTF-8");   	
    }
%>

<title>Main</title>
</head>
<body>
<div id="wrap">
	<div class="header">
        <div id="header" >
            <jsp:include page="menubar.jsp" />
        </div>
        <div id="header">
            <h2 id="headerTitle"><%=title%></h2> 
        </div>
    </div>
    <div id="main">
        <jsp:include page="<%=contentPage%>" />
    </div>
    <div id="footer"> 
       	티타임 차차차 <br/>
        Developers 하나의 이변 from 성신여자대학교 
    </div>
 </div>

</body>
</html>
<!-- 출처: https://all-record.tistory.com/116 [세상의 모든 기록] -->