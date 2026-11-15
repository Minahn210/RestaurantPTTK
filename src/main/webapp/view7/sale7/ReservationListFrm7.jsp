<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date,model7.SaleStaff7,dao7.ReservationDAO7"%><%
    if (!(session.getAttribute("staff") instanceof SaleStaff7)) {
        response.sendRedirect(request.getContextPath() + "/view7/member7/LoginFrm7.jsp?err=timeout");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String fromText = request.getParameter("inFromDate");
    if (fromText == null) {
        fromText = new SimpleDateFormat("yyyy-MM-dd").format(new Date());   // mặc định: từ hôm nay
    }
    String phone = p7(request.getParameter("inPhone"));
    Date fromDate = null;
    try {
        fromDate = fromText.isEmpty() ? null : new SimpleDateFormat("yyyy-MM-dd").parse(fromText);
    } catch (Exception e) {
    }
    Reservation7[] listReservation = new ReservationDAO7().getReservations(phone, fromDate);
    String title7 = "Danh sách đặt bàn";
%><%@ include file="/view7/top7.jspf" %>
<div class="head7">
    <div><h1>Danh sách đặt bàn</h1><p>Tìm thấy <b><%= listReservation.length %></b> phiếu đặt bàn.</p></div>
    <a class="btn7 ghost" href="SaleHomeFrm7.jsp">Quay lại</a>
</div>
<form class="inline7" method="get">
    <label for="inFromDate">Từ ngày</label><input type="date" id="inFromDate" name="inFromDate" value="<%= h7(fromText) %>">
    <label for="inPhone">SĐT khách</label><input type="tel" id="inPhone" name="inPhone" value="<%= h7(phone) %>" placeholder="Tất cả">
    <button class="btn7" type="submit">Lọc</button>
    <a href="ReservationListFrm7.jsp?inFromDate=">Xem tất cả</a>
</form>
<div class="tblbox7"><table class="tbl7">
    <tr><th>Mã phiếu</th><th>Ngày đến</th><th>Giờ</th><th>Bàn</th><th>Khách hàng</th><th>SĐT</th><th>Số người</th><th>Ghi chú</th><th>Thời gian đặt</th><th>Trạng thái</th></tr>
    <% for (Reservation7 r : listReservation) { %>
    <tr>
        <td><b><%= String.format("%04d", r.getId()) %></b></td>
        <td><%= date7(r.getBookingDate()) %></td>
        <td><%= time7(r.getArrivalTime()) %></td>
        <td><%= h7(r.getTable().getName()) %> <small>(<%= h7(r.getTable().getLocation()) %>)</small></td>
        <td><%= h7(r.getCustomer().getFullName()) %></td>
        <td><%= h7(r.getCustomer().getPhone()) %></td>
        <td class="num"><%= r.getNumberOfGuests() %></td>
        <td><%= h7(r.getNote()) %></td>
        <td><%= new SimpleDateFormat("HH:mm dd/MM/yyyy").format(r.getCreatedTime()) %></td>
        <td><span class="tag7 <%= h7(r.getStatus()) %>"><%= h7(status7(r.getStatus())) %></span></td>
    </tr>
    <% } %>
    <% if (listReservation.length == 0) { %><tr><td colspan="10" class="empty7">Không có phiếu đặt bàn nào.</td></tr><% } %>
</table></div>
<%@ include file="/view7/bottom7.jspf" %>
