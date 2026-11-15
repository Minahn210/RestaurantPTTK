<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model7.WarehouseStaff7"%><%
    Object o = session.getAttribute("staff");
    if (!(o instanceof WarehouseStaff7)) {
        response.sendRedirect(request.getContextPath() + "/view7/member7/LoginFrm7.jsp?err=timeout");
        return;
    }
    WarehouseStaff7 warehouseStaff = (WarehouseStaff7) o;
    String title7 = "Trang chủ nhân viên kho";
%><%@ include file="/view7/top7.jspf" %>
<div class="head7"><div><h1>Xin chào, <%= h7(warehouseStaff.getFullName()) %></h1>
    <p>Trang chủ nhân viên kho – các chức năng kho chưa nằm trong phạm vi 2 module được cài đặt.</p></div></div>
<div class="grid7">
    <a class="tile7 off"><div class="ic7">📦</div><b>Nhập nguyên liệu</b><span>Lập phiếu nhập từ nhà cung cấp</span></a>
    <a class="tile7 off"><div class="ic7">🏭</div><b>Quản lý nhà cung cấp</b><span>Thêm, sửa nhà cung cấp</span></a>
    <a class="tile7" href="<%= ctx %>/view7/member7/doLogout7.jsp"><div class="ic7">🚪</div><b>Đăng xuất</b><span>Thoát khỏi hệ thống</span></a>
</div>
<%@ include file="/view7/bottom7.jspf" %>
