<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
    String title7 = "Trang chủ";
%><%@ include file="/view7/top7.jspf" %>
<section class="hero7">
    <h1>Hương vị Việt giữa lòng Hà Nội</h1>
    <p>Nhà hàng ABC – xin chào quý khách! Đặt bàn trực tuyến chỉ trong một phút, bàn được giữ sẵn khi quý khách đến.</p>
    <div class="btns7">
        <a class="btn7" href="SearchTableFrm7.jsp">Đặt bàn trực tuyến</a>
        <a class="btn7 light" href="MenuFrm7.jsp">Xem thực đơn</a>
    </div>
</section>
<div class="grid7">
    <a class="tile7" href="MenuFrm7.jsp"><div class="ic7">🔎</div><b>Tìm kiếm món ăn</b><span>Xem thực đơn, tìm món theo tên, loại</span></a>
    <a class="tile7" href="SearchTableFrm7.jsp"><div class="ic7">📅</div><b>Đặt bàn trực tuyến</b><span>Chọn ngày giờ, chọn bàn còn trống</span></a>
    <a class="tile7 off"><div class="ic7">🛵</div><b>Đặt món trực tuyến</b><span>Đặt món mang về, giao tận nơi</span></a>
    <a class="tile7" href="ReservationLookupFrm7.jsp"><div class="ic7">🧾</div><b>Tra cứu đặt bàn</b><span>Xem lại phiếu đã đặt bằng số điện thoại</span></a>
</div>
<div class="info7">
    <div><b>📍 Địa chỉ</b><br>96A Trần Phú, Hà Đông, Hà Nội</div>
    <div><b>🕗 Giờ mở cửa</b><br>08:00 – 22:30 (nhận khách đến tới 21:00)</div>
    <div><b>☎️ Hotline</b><br>0243 777 7777</div>
</div>
<%@ include file="/view7/bottom7.jspf" %>
