<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model7.SaleStaff7"%><%
    Object o = session.getAttribute("staff");
    if (!(o instanceof SaleStaff7)) {
        response.sendRedirect(request.getContextPath() + "/view7/member7/LoginFrm7.jsp?err=timeout");
        return;
    }
    SaleStaff7 saleStaff = (SaleStaff7) o;
    String title7 = "Trang chủ nhân viên bán hàng";
%><%@ include file="/view7/top7.jspf" %>
<div class="head7"><div><h1>Xin chào, <%= h7(saleStaff.getFullName()) %></h1>
    <p>Trang chủ nhân viên bán hàng – chọn chức năng cần thực hiện.</p></div></div>
<div class="grid7">
    <a class="tile7" href="ReservationListFrm7.jsp"><div class="ic7">📅</div><b>Danh sách đặt bàn</b><span>Xem các phiếu khách đã đặt</span></a>
    <a class="tile7 off"><div class="ic7">✔️</div><b>Xác nhận đặt bàn, đơn online</b><span>Duyệt phiếu chờ xác nhận</span></a>
    <a class="tile7 off"><div class="ic7">🍽️</div><b>Nhận khách, gọi món</b><span>Mở bàn và ghi món</span></a>
    <a class="tile7 off"><div class="ic7">💳</div><b>Thanh toán</b><span>Lập hóa đơn cho khách</span></a>
    <a class="tile7 off"><div class="ic7">🎫</div><b>Làm thẻ thành viên</b><span>Đăng ký thẻ cho khách</span></a>
    <a class="tile7" href="<%= ctx %>/view7/member7/doLogout7.jsp"><div class="ic7">🚪</div><b>Đăng xuất</b><span>Thoát khỏi hệ thống</span></a>
</div>
<%@ include file="/view7/bottom7.jspf" %>
