<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date,java.util.Calendar,java.sql.Time,dao7.TableDAO7"%><%
    // 1. Nhận ngày, giờ đến (từ form tìm bàn, hoặc lấy lại trong session khi quay lại trang này)
    String dateText = p7(request.getParameter("inDate"));
    String timeText = p7(request.getParameter("inTime"));
    Date bookingDate = (Date) session.getAttribute("bookingDate");
    Time arrivalTime = (Time) session.getAttribute("arrivalTime");
    String error = null;
    if (!dateText.isEmpty() || !timeText.isEmpty()) {
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd"), tf = new SimpleDateFormat("HH:mm");
            df.setLenient(false);
            tf.setLenient(false);
            bookingDate = df.parse(dateText);
            arrivalTime = new Time(tf.parse(timeText).getTime());
        } catch (Exception e) {
            error = "Ngày hoặc giờ đến không hợp lệ.";
        }
    } else if (bookingDate == null || arrivalTime == null) {
        response.sendRedirect("SearchTableFrm7.jsp");
        return;
    }
    if (error == null) {
        Calendar t = Calendar.getInstance(), when = Calendar.getInstance();
        t.setTime(arrivalTime);
        when.setTime(bookingDate);
        when.set(Calendar.HOUR_OF_DAY, t.get(Calendar.HOUR_OF_DAY));
        when.set(Calendar.MINUTE, t.get(Calendar.MINUTE));
        int minutes = t.get(Calendar.HOUR_OF_DAY) * 60 + t.get(Calendar.MINUTE);
        if (minutes < 8 * 60 || minutes > 21 * 60) {
            error = "Nhà hàng chỉ nhận khách đến trong khoảng 08:00 - 21:00.";
        } else if (when.getTime().before(new Date())) {
            error = "Thời gian đến phải sau thời điểm hiện tại.";
        }
    }
    Table7[] listTable = new Table7[0];
    if (error == null) {
        session.setAttribute("bookingDate", bookingDate);
        session.setAttribute("arrivalTime", arrivalTime);
        // 2. Lấy danh sách bàn trống (TableDAO7: getAvailableTables())
        TableDAO7 tableDAO = new TableDAO7();
        listTable = tableDAO.getAvailableTables(bookingDate, arrivalTime);
        session.setAttribute("listTable", listTable);
    }
    String title7 = "Danh sách bàn trống";
%><%@ include file="/view7/top7.jspf" %>
<div class="head7">
    <div><h1>Danh sách bàn trống</h1>
    <% if (error == null) { %><p>Ngày đến: <b><%= date7(bookingDate) %></b> &nbsp;·&nbsp; Giờ đến: <b><%= time7(arrivalTime) %></b> &nbsp;·&nbsp; còn <b><%= listTable.length %></b> bàn trống</p><% } %></div>
    <a class="btn7 ghost" href="SearchTableFrm7.jsp">Quay lại</a>
</div>
<% if (error != null) { %>
    <div class="msg7 err"><%= h7(error) %></div>
<% } else if (listTable.length == 0) { %>
    <div class="msg7 err">Rất tiếc, không còn bàn trống vào thời gian này. Quý khách vui lòng chọn thời gian khác.</div>
<% } else { %>
<div class="tblbox7"><table class="tbl7">
    <tr><th>TT</th><th>Tên bàn</th><th>Vị trí</th><th>Số chỗ</th><th>Mô tả</th><th>Chọn</th></tr>
    <% for (int i = 0; i < listTable.length; i++) { Table7 tb = listTable[i]; %>
    <tr><td><%= i + 1 %></td><td><b><%= h7(tb.getName()) %></b></td><td><%= h7(tb.getLocation()) %></td>
        <td class="num"><%= tb.getCapacity() %></td><td><%= h7(tb.getDescription()) %></td>
        <td><a class="link7" href="BookingInfoFrm7.jsp?idTable=<%= tb.getId() %>">Chọn</a></td></tr>
    <% } %>
</table></div>
<% } %>
<%@ include file="/view7/bottom7.jspf" %>
