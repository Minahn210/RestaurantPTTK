<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date,java.util.Calendar,java.sql.Time,dao7.ReservationDAO7,dao7.CustomerDAO7"%><%
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("SearchTableFrm7.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    Date bookingDate = (Date) session.getAttribute("bookingDate");
    Time arrivalTime = (Time) session.getAttribute("arrivalTime");
    Table7 table = (Table7) session.getAttribute("table");
    if (bookingDate == null || arrivalTime == null || table == null) {
        response.sendRedirect("SearchTableFrm7.jsp");
        return;
    }
    // 1. Nhận thông tin đặt bàn
    String fullName = p7(request.getParameter("inFullName"));
    String phone = p7(request.getParameter("inPhone"));
    String email = p7(request.getParameter("inEmail"));
    String note = p7(request.getParameter("inNote"));
    int numberOfGuests = 0;
    try {
        numberOfGuests = Integer.parseInt(p7(request.getParameter("inNumberOfGuests")));
    } catch (NumberFormatException e) {
    }
    Calendar t = Calendar.getInstance(), when = Calendar.getInstance();
    t.setTime(arrivalTime);
    when.setTime(bookingDate);
    when.set(Calendar.HOUR_OF_DAY, t.get(Calendar.HOUR_OF_DAY));
    when.set(Calendar.MINUTE, t.get(Calendar.MINUTE));

    String kind = "invalid";   // ok | taken | invalid | error
    String message;
    Reservation7 reservation = null;
    if (fullName.isEmpty() || fullName.length() > 255) {
        message = "Vui lòng nhập họ tên.";
    } else if (!phone.matches("0[0-9]{9}")) {
        message = "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0.";
    } else if (!email.isEmpty() && !email.matches("[^@\\s]+@[^@\\s]+\\.[^@\\s]+")) {
        message = "Email không hợp lệ.";
    } else if (numberOfGuests < 1 || numberOfGuests > table.getCapacity()) {
        message = "Số người phải từ 1 đến " + table.getCapacity() + " (sức chứa của bàn " + table.getName() + ").";
    } else if (note.length() > 255) {
        message = "Ghi chú tối đa 255 ký tự.";
    } else if (when.getTime().before(new Date())) {
        message = "Thời gian đến đã qua, vui lòng tìm bàn lại.";
    } else {
        // 2. Đóng gói thông tin phiếu đặt bàn (Reservation7)
        reservation = new Reservation7();
        reservation.setCreatedTime(new Date());
        reservation.setBookingDate(bookingDate);
        reservation.setArrivalTime(arrivalTime);
        reservation.setNumberOfGuests(numberOfGuests);
        reservation.setNote(note.isEmpty() ? null : note);
        reservation.setStatus(Reservation7.STATUS_PENDING);
        reservation.setTable(table);
        // 3. Kiểm tra bàn còn trống (ReservationDAO7: checkTableAvailable())
        ReservationDAO7 reservationDAO = new ReservationDAO7();
        if (!reservationDAO.checkTableAvailable(reservation)) {
            kind = "taken";
            message = "Bàn " + table.getName() + " vừa được người khác đặt. Vui lòng chọn bàn khác!";
        } else {
            // 4. Tìm khách theo SĐT (CustomerDAO7: getCustomerByPhone()), chưa có thì thêm mới (addCustomer())
            CustomerDAO7 customerDAO = new CustomerDAO7();
            Customer7 customer = customerDAO.getCustomerByPhone(phone);
            boolean customerOk = true;
            if (customer == null) {
                customer = new Customer7(fullName, phone, email.isEmpty() ? null : email, null, null);
                customerOk = customerDAO.addCustomer(customer);
            }
            reservation.setCustomer(customer);
            // 5. Lưu phiếu đặt bàn (ReservationDAO7: addReservation())
            if (customerOk && reservationDAO.addReservation(reservation)) {
                kind = "ok";
                message = "Đặt bàn thành công!";
                session.removeAttribute("listTable");
                session.removeAttribute("table");
                session.removeAttribute("bookingDate");
                session.removeAttribute("arrivalTime");
            } else {
                kind = "error";
                message = "Lỗi khi lưu phiếu đặt bàn. Vui lòng thử lại!";
            }
        }
    }
    String title7 = "Thông báo";
%><%@ include file="/view7/top7.jspf" %>
<div class="mask7"><div class="pop7">
    <h2>Thông báo</h2>
    <% if ("ok".equals(kind)) { %>
        <div class="big7">🎉</div>
        <p class="ok"><%= h7(message) %></p>
        <p>Mã phiếu đặt bàn</p><div class="code7"><%= String.format("%04d", reservation.getId()) %></div>
        <p>Bàn <b><%= h7(table.getName()) %></b>, <%= time7(arrivalTime) %> ngày <%= date7(bookingDate) %>, <%= reservation.getNumberOfGuests() %> người.<br>
           Nhà hàng sẽ liên hệ số <b><%= h7(phone) %></b> để xác nhận.</p>
        <div class="btns7"><a class="btn7" href="CustomerHomeFrm7.jsp">OK</a></div>
    <% } else { %>
        <div class="big7">⚠️</div>
        <p class="bad"><%= h7(message) %></p>
        <div class="btns7"><% if ("taken".equals(kind)) { %><a class="btn7" href="AvailableTableFrm7.jsp">OK</a>
            <% } else { %><button type="button" class="btn7" onclick="history.back()">OK</button><% } %></div>
    <% } %>
</div></div>
<%@ include file="/view7/bottom7.jspf" %>
