<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model7.Manager7"%><%
    Object o = session.getAttribute("staff");
    if (!(o instanceof Manager7)) {
        response.sendRedirect(request.getContextPath() + "/view7/member7/LoginFrm7.jsp?err=timeout");
        return;
    }
    Manager7 manager = (Manager7) o;
    String title7 = "Trang chủ nhân viên quản lý";
%><%@ include file="/view7/top7.jspf" %>
<div class="head7"><div><h1>Xin chào, <%= h7(manager.getFullName()) %></h1>
    <p>Trang chủ nhân viên quản lý – chọn chức năng cần thực hiện.</p></div></div>
<div class="grid7">
    <a class="tile7" href="ManageDishFrm7.jsp"><div class="ic7">🍲</div><b>Quản lý món ăn</b><span>Xem danh sách, thêm món ăn mới</span></a>
    <a class="tile7 off"><div class="ic7">🍱</div><b>Tạo combo món ăn</b><span>Ghép nhiều món thành combo</span></a>
    <a class="tile7 off"><div class="ic7">📊</div><b>Xem thống kê</b><span>Món ăn, khách hàng, nguyên liệu</span></a>
    <a class="tile7" href="<%= ctx %>/view7/member7/doLogout7.jsp"><div class="ic7">🚪</div><b>Đăng xuất</b><span>Thoát khỏi hệ thống</span></a>
</div>
<%@ include file="/view7/bottom7.jspf" %>
