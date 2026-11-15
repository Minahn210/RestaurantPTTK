<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao7.MemberDAO7"%><%@ include file="/view7/common7.jspf" %><%
    request.setCharacterEncoding("UTF-8");
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("LoginFrm7.jsp");
        return;
    }
    String password = request.getParameter("inPassword");
    Staff7 staff = new MemberDAO7().checkLogin(p7(request.getParameter("inUsername")), password == null ? "" : password);
    if (staff == null) {
        response.sendRedirect("LoginFrm7.jsp?err=fail");
        return;
    }
    session.setAttribute("staff", staff);
    response.sendRedirect(request.getContextPath() + home7(staff));
%>
