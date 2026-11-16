<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date,java.sql.Time"%><%
    Date bookingDate = (Date) session.getAttribute("bookingDate");
    Time arrivalTime = (Time) session.getAttribute("arrivalTime");
    Table7[] listTable = (Table7[]) session.getAttribute("listTable");
    String idTable = p7(request.getParameter("idTable"));
    // Lấy bàn khách vừa chọn trong danh sách bàn trống
    Table7 table = idTable.isEmpty() ? (Table7) session.getAttribute("table") : null;
    for (int i = 0; listTable != null && i < listTable.length; i++) {
        if (String.valueOf(listTable[i].getId()).equals(idTable)) {
            table = listTable[i];
        }
    }
    if (bookingDate == null || arrivalTime == null || table == null) {
        response.sendRedirect("SearchTableFrm7.jsp");
        return;
    }
    session.setAttribute("table", table);
    String title7 = "Thông tin đặt bàn";
%><%@ include file="/view7/top7.jspf" %>
<div class="card7 frm7">
    <h2>Thông tin đặt bàn</h2>
    <div class="sum7">
        <p><b>Bàn:</b> <%= h7(table.getName()) %> – <%= h7(table.getLocation()) %> – <%= table.getCapacity() %> chỗ</p>
        <p><b>Thời gian:</b> <%= time7(arrivalTime) %> ngày <%= date7(bookingDate) %></p>
    </div>
    <form action="doBooking7.jsp" method="post">
        <div class="row7"><label for="inFullName">Họ tên <span class="req">*</span></label>
            <input type="text" id="inFullName" name="inFullName" required maxlength="255"></div>
        <div class="row7"><label for="inPhone">Số điện thoại <span class="req">*</span></label>
            <input type="tel" id="inPhone" name="inPhone" required pattern="0[0-9]{9}" title="Số điện thoại gồm 10 chữ số, bắt đầu bằng 0"></div>
        <div class="row7"><label for="inEmail">Email</label>
            <input type="email" id="inEmail" name="inEmail" maxlength="255"></div>
        <div class="row7"><label for="inNumberOfGuests">Số người <span class="req">*</span></label>
            <input type="number" id="inNumberOfGuests" name="inNumberOfGuests" required min="1" max="<%= table.getCapacity() %>"></div>
        <div class="row7"><label for="inNote">Ghi chú</label>
            <textarea id="inNote" name="inNote" maxlength="255"></textarea></div>
        <div class="btns7 left7">
            <button type="submit" class="btn7" name="subConfirm">Xác nhận</button>
            <a class="btn7 ghost" href="AvailableTableFrm7.jsp">Quay lại</a>
        </div>
    </form>
</div>
<%@ include file="/view7/bottom7.jspf" %>
