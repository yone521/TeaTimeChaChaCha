<%@ page contentType="text/html; charset=EUC-KR" %>
<%@page import="Community.BoardBean"%>
<%@page import="java.util.Vector"%>

<jsp:useBean id="bMgr" class="Community.BoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");
    
	String title = "후기게시판";
	String t = request.getParameter("title");
    if (t != null) {
    	title = new String(t.getBytes("8859_1"), "UTF-8");   	
    }
%>
<%	
	  request.setCharacterEncoding("EUC-KR");
	  
      int totalRecord=0; //전체레코드수
	  int numPerPage=20; // 페이지당 레코드 수 
	  int pagePerBlock=15; //블럭당 페이지수 
	  
	  int totalPage=0; //전체 페이지 수
	  int totalBlock=0;  //전체 블럭수 

	  int nowPage=1; // 현재페이지
	  int nowBlock=1;  //현재블럭
	  
	  int start=0; //디비의 select 시작번호
	  int end=10; //시작번호로 부터 가져올 select 갯수
	  
	  int listSize=0; //현재 읽어온 게시물의 수

	String keyWord = "", keyField = "";
	Vector<BoardBean> vlist = null;
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if (request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	 start = (nowPage * numPerPage)-numPerPage;
	 end = numPerPage;
	 
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	  
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
%>
<html>
<head>
<title>후기 게시판</title>
<style>
td{
border-right:none;
border-left:none;
border-top:none
}
</style>
<link href="style.css" rel="stylesheet" type="text/css">
<link href="../communityStyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list() {
		document.listFrm.action = "community.jsp";
		document.listFrm.submit();
	}
	
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(value){
		 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		 document.readFrm.submit();
	} 
	
	function read(com_num){
		document.readFrm.com_num.value=com_num;
		document.readFrm.action="read.jsp";
		document.readFrm.submit();
	}
	
	function check() {
	     if (document.searchFrm.keyWord.value == "") {
	   alert("검색어를 입력하세요.");
	   document.searchFrm.keyWord.focus();
	   return;
	     }
	  document.searchFrm.submit();
	 }
</script>
</head>
<body bgcolor="#CCD5AE">
<div id="wrap">
<div class="header">
        <div id="header" >
            <jsp:include page="menubar.jsp" />
        </div>
       <div id="header">
            <h2 id="headerTitle">COMMUNITY</h2> 
       </div>
</div>
  <div align="center" style="background:white;height:600px;padding:20px;">
	
	<div id="searchBar"  style="width:500px;float:right;">
	<form  name="searchFrm"  method="get" action="community.jsp">
	<table width="600" cellpadding="4" cellspacing="0" >
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="com_name"> 이 름</option>
    				<option value="com_subject"> 제 목</option>
    				<option value="com_content"> 내 용</option>
   				</select>
   				<input size="16" name="keyWord" >
   				<input type="button"  value="찾기" onClick="javascript:check()" >
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
	</form>
	</div>
	
	<table align="center" width="600" >
			<tr>
				<td>Total : <%=totalRecord%>Articles(<font color="red">
				<%=nowPage%>/<%=totalPage%>Pages</font>)</td>
			</tr>
	</table>
	</br>
	<table align="center" width="100%" cellpadding="3"  >
		<tr>
			<td align="center" colspan="2">
			<%
				  vlist = bMgr.getBoardList(keyField, keyWord, start, end);
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" >
					<tr align="center" bgcolor="#E9EDC9" height="120%" >
						<td>번 호</td>
						<td>제 목</td>
						<td>이 름</td>
						<td>날 짜</td>
						<td>조회수</td>
					</tr>
					<%
						  for (int i = 0;i<numPerPage; i++) {
							if (i == listSize) break;
							BoardBean bean = vlist.get(i);
							int com_num = bean.getCom_num();
							String com_name = bean.getCom_name();
							String com_subject = bean.getCom_subject();
							String com_regdate = bean.getCom_regdate();
							int com_depth = bean.getCom_depth();
							int com_count = bean.getCom_count();
					%>
					<tr>
						<td align="center">
							<%=totalRecord-((nowPage-1)*numPerPage)-i%>
						</td>
						<td>
						<%
							  if(com_depth>0){
								for(int j=0;j<com_depth;j++){
									out.println("&nbsp;&nbsp;");
									}
								}
						%>
						  <a style="text-decoration-line:none;color:black"href="javascript:read('<%=com_num%>')"><%=com_subject%></a>
						</td>
						<td align="center"><%=com_name%></td>
						<td align="center"><%=com_regdate%></td>
						<td align="center"><%=com_count%></td>
						</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
		<tr>
			<td colspan="2"><br /><br /></td>
		</tr>
		<tr>
			<td>
			<!-- 페이징 및 블럭 처리 Start--> 
			<%
   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
   				  int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
   				  //하단 페이지 끝번호
   				  if(totalPage !=0){
    			  	if (nowBlock > 1) {%>
    			  		<a style="text-decoration-line:none;color:black"href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%>&nbsp; 
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>     <!-- javascript:pageing('<%=pageStart %>') -->
     			     	<a style="text-decoration-line:none;color:black"href="community.jsp?&nowPage=<%=pageStart %>"> 
     					<%if(pageStart==nowPage) {%> <%}%>
     					[<%=pageStart %>] 
     					<%if(pageStart==nowPage) {%> <%}%></a> 
    					<%}//for%>&nbsp; 
    					<%if (totalBlock > nowBlock ) {%>
    					<a style="text-decoration-line:none;color:black"href="javascript:block('<%=nowBlock+1%>')">.....next</a>
    				<%}%>&nbsp;  
   				<%}%>
 				<!-- 페이징 및 블럭 처리 End-->
				</td>
				<td align="right" >
					<a  style="text-decoration-line:none;color:black"href="post.jsp">[글쓰기]</a> 
					<a  style="text-decoration-line:none;color:black"href="javascript:list()">[처음으로]</a>
				</td>
			</tr>
		</table>
	<hr width="600"/>
	
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
	<form name="readFrm" method="get">
		<input type="hidden" name="com_num"> 
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="keyField" value="<%=keyField%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
	</form>
</div>
  
         <div id="footer"> 
       		티타임 차차차 <br/>
        	Developers 하나의 이변 from 성신여자대학교 
        </div>
 </div>

</body>
</html>