<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao7.ReservationDAO7"%><%
    String phone = p7(request.getParameter("inPhone"));
    boolean valid = phone.matches("0[0-9]{9}");
    Reservation7[] listReservation = valid ? new ReservationDAO7().getReservations(phone, null) : new Reservation7[0];
    String title7 = "Tra cứu đặt bàn";
%><%@ include file="/view7/top7.jspf" %>
<div class="head7"><div><h1>Tra cứu đặt bàn</h1><p>Nhập số điện thoại đã dùng khi đặt bàn để xem lại các phiếu đặt.</p></div></div>
<form class="inline7" method="get">
    <input type="tel" name="inPhone" value="<%= h7(phone) %>" required pattern="0[0-9]{9}" placeholder="Số điện thoại (10 số)" title="Số điện thoại gồm 10 chữ số, bắt đầu bằng 0">
    <button class="btn7" type="submit">Tra cứu</button>
</form>
<% if (!phone.isEmpty() && !valid) { %><div class="msg7 err">Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0.</div><% } %>
<% if (valid) { %>
<div class="tblbox7"><table class="tbl7">
    <tr><th>Mã phiếu</th><th>Ngày đến</th><th>Giờ</th><th>Bàn</th><th>Số người</th><th>Ghi chú</th><th>Trạng thái</th></tr>
    <% for (Reservation7 r : listReservation) { %>
    <tr><td><b><%= String.format("%04d", r.getId()) %></b></td><td><%= date7(r.getBookingDate()) %></td><td><%= time7(r.getArrivalTime()) %></td>
        <td><%= h7(r.getTable().getName()) %> – <%= h7(r.getTable().getLocation()) %></td><td class="num"><%= r.getNumberOfGuests() %></td>
        <td><%= h7(r.getNote()) %></td><td><span class="tag7 <%= h7(r.getStatus()) %>"><%= h7(status7(r.getStatus())) %></span></td></tr>
    <% } %>
    <% if (listReservation.length == 0) { %><tr><td colspan="7" class="empty7">Không có phiếu đặt bàn nào với số điện thoại này.</td></tr><% } %>
</table></div>
<% } %>
<%@ include file="/view7/bottom7.jspf" %>
