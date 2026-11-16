<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date"%><%
    // Điền sẵn ngày, giờ đã chọn trước đó (khi khách quay lại trang này)
    Date bookingDate = (Date) session.getAttribute("bookingDate");
    Date arrivalTime = (Date) session.getAttribute("arrivalTime");
    String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    String title7 = "Tìm bàn trống";
%><%@ include file="/view7/top7.jspf" %>
<div class="card7 frm7">
    <h2>Tìm bàn trống</h2>
    <p style="color:var(--muted);margin-top:0">Nhà hàng nhận khách đến từ 08:00 đến 21:00. Mỗi lượt đặt giữ bàn trong 2 tiếng.</p>
    <form action="AvailableTableFrm7.jsp" method="get">
        <div class="row7"><label for="inDate">Ngày đến <span class="req">*</span></label>
            <input type="date" id="inDate" name="inDate" required min="<%= today %>"
                   value="<%= bookingDate == null ? "" : new SimpleDateFormat("yyyy-MM-dd").format(bookingDate) %>"></div>
        <div class="row7"><label for="inTime">Giờ đến <span class="req">*</span></label>
            <input type="time" id="inTime" name="inTime" required min="08:00" max="21:00" value="<%= time7(arrivalTime) %>"></div>
        <div class="btns7 left7">
            <button type="submit" class="btn7" name="subSearch">Tìm bàn</button>
            <a class="btn7 ghost" href="CustomerHomeFrm7.jsp">Quay lại</a>
        </div>
    </form>
</div>
<%@ include file="/view7/bottom7.jspf" %>
