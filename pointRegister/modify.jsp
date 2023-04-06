<%@page import="java.time.temporal.WeekFields"%>
<%@page
	import="org.apache.catalina.valves.rewrite.InternalRewriteMap.Escape"%>
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
<title>modify</title>
</head>
<body>

	<script type="text/javascript" src="check.js"></script>
	<jsp:include page="header.jsp" />

	<section
		style="position: fixed; background-color: yellowgreen; width: 100%; height: 100%; top: 70px; left: 0px;">
		<h2 style="text-align: center;">교과목 수정</h2>

		<form method="post" action="action.jsp" name="frm" style="display: flex; align-items: center; justify-content: center;">
			<input type="hidden" name="mode" value="modify">

			<table border="1" style="text-align: center;">

				<%
				request.setCharacterEncoding("UTF-8");
				String id = request.getParameter("id");
				try {
					Connection con = Util.getConnection();
					String sql = "select * from course_tbl where id = ?";
					PreparedStatement pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					ResultSet rs = pstmt.executeQuery();
					rs.next();
					String lecturer = rs.getString(4);
					String week = rs.getString(5);
					String start_hour = rs.getString(6);
					while (start_hour.length() < 4) {
						start_hour = "0" + start_hour;
					}
					String end_hour = rs.getString(7);
					while (end_hour.length() < 4) {
						end_hour = "0" + end_hour;
					}
				%>
				<tr>
					<td>과목코드</td>
					<td><input type="text" name="id" style="width: 100%"
						value="<%=id%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td>과목명</td>
					<td><input type="text" name="name" style="width: 100%"
						value="<%=rs.getString(2)%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td><input type="text" name="credit" style="width: 100%"
						value="<%=rs.getString(3)%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td>담당강사</td>
					<td><select name="lecturer" style="width: 100%">
							<option value="">담당강사</option>
							<option value="1"
								<%if (lecturer.equals("1"))

	out.println("selected");%>>김교수</option>
							<option value="2"
								<%if (lecturer.equals("1"))
	out.println("selected");%>>이교수</option>
							<option value="3"
								<%if (lecturer.equals("1"))
	out.println("selected");%>>박교수</option>
							<option value="4"
								<%if (lecturer.equals("1"))
	out.println("selected");%>>유교수</option>
							<option value="5"
								<%if (lecturer.equals("1"))
	out.println("selected");%>>최교수</option>
							<option value="6"
								<%if (lecturer.equals("1"))
	out.println("selected");%>>임교수</option>
					</select></td>
				</tr>
				<tr>
					<td>요일</td>
					<td><input type="radio" name="week" value="1"
						<%if (week.equals("1"))
	out.println("checked");%>>월 <input
						type="radio" name="week" value="2"
						<%if (week.equals("2"))
	out.println("checked");%>>화 <input
						type="radio" name="week" value="3"
						<%if (week.equals("3"))
	out.println("checked");%>>수 <input
						type="radio" name="week" value="4"
						<%if (week.equals("4"))
	out.println("checked");%>>목 <input
						type="radio" name="week" value="5"
						<%if (week.equals("5"))
	out.println("checked");%>>금</td>
				</tr>
				<tr>
					<td>시작시간</td>
					<td><input type="text" name="start_hour" style="width: 100%"
						value="<%=start_hour%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td>끝</td>
					<td><input type="text" name="end_hour" style="width: 100%" value="<%=end_hour%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td colspan="2 "><input type="button" value="수정"
						onclick="modify()"> <input type="button" value="취소"
						onclick="res()"></td>
				</tr>
				<%
				} catch (Exception e) {
				e.printStackTrace();
				}
				%>
			</table>
		</form>
	</section>

	<jsp:include page="footer.jsp" />
</body>
</html>