<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBPKG.Util"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp"/>

<section style="position:fixed; background-color: yellowgreen; width: 100%; height: 100%; top: 70px; left: 0px;">
<h2 style="text-align: center;">교과목 목록 조회/수정</h2>

<form action="action.jsp" style="display: flex; align-items: center; justify-content: center;">
	<table border="1">
		<tr>
			<td>과목코드</td>
			<td>과목명</td>
			<td>학점</td>
			<td>담당강사</td>
			<td>요일</td>
			<td>시작시간</td>
			<td>종료시간</td>
			<td>삭제</td>
		</tr>
<%
request.setCharacterEncoding("UTF-8");

try{
	Connection con = Util.getConnection();
	String sql = "select id, co.name cname, credit, le.name  lname, week, start_hour, end_hour "+
	"from course_tbl co, lecturer_tbl le " +
	"where co.lecturer = le.idx " +
	"order by id";
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()){

		String week = rs.getString(5);
		switch(week){
		case "1" : week ="월";break;
		case "2" : week ="화";break;
		case "3" : week ="수";break;
		case "4" : week ="목";break;
		case "5" : week ="금";break;
		}
	
	
%>
<tr>
		<td><a href="modify.jsp?id=<%=rs.getString(1)%>"><%=rs.getString(1) %></a></td>
		<td><%=rs.getString(2) %></td>
		<td><%=rs.getString(3) %></td>
		<td><%=rs.getString(4) %></td>
		<td><%=week %></td>
		<td><%=rs.getString(6) %></td>
		<td><%=rs.getString(7) %></td> 
		<td><a href="action.jsp?id=<%=rs.getString(1)%>&mode=delete">삭제</a></td>
		
	
</tr>
<%
}
}catch(Exception e){
	e.printStackTrace();
}
%>
	</table>
</form>
</section>

<jsp:include page="footer.jsp"/>
</body>
</html>