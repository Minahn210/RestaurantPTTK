<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
    String err = request.getParameter("err");
    String msg = "fail".equals(err) ? "Sai tên đăng nhập hoặc mật khẩu!"
            : "timeout".equals(err) ? "Vui lòng đăng nhập để tiếp tục." : null;
    String title7 = "Đăng nhập";
%><%@ include file="/view7/top7.jspf" %>
<div class="card7 frm7 sm">
    <h2>Đăng nhập nhân viên</h2>
    <p style="color:var(--muted);margin-top:0">Dành cho nhân viên quản lý, bán hàng và kho của nhà hàng.</p>
    <% if (msg != null) { %><div class="msg7 err"><%= msg %></div><% } %>
    <form action="doLogin7.jsp" method="post">
        <div class="row7"><label for="inUsername">Tên đăng nhập</label>
            <input type="text" id="inUsername" name="inUsername" required maxlength="255" autofocus></div>
        <div class="row7"><label for="inPassword">Mật khẩu</label>
            <input type="password" id="inPassword" name="inPassword" required maxlength="255"></div>
        <div class="btns7">
            <a class="btn7 ghost" href="<%= ctx %>/">Quay lại</a>
            <button type="submit" class="btn7">Đăng nhập</button>
        </div>
    </form>
</div>
<%@ include file="/view7/bottom7.jspf" %>
