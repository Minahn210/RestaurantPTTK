<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model7.Manager7,dao7.DishDAO7"%><%
    Object o = session.getAttribute("staff");
    if (!(o instanceof Manager7)) {
        response.sendRedirect(request.getContextPath() + "/view7/member7/LoginFrm7.jsp?err=timeout");
        return;
    }
    Manager7 manager = (Manager7) o;
    // Lấy danh sách món ăn để hiển thị (DishDAO7: getAllDishes())
    DishDAO7 dishDAO = new DishDAO7();
    Dish7[] listDish = dishDAO.getAllDishes();
    String newId = request.getParameter("newId");   // món vừa thêm (được tô sáng)
    String title7 = "Quản lý món ăn";
%><%@ include file="/view7/top7.jspf" %>
<div class="head7"><div><h1>Quản lý món ăn</h1></div></div>
<div class="btns7 left7" style="margin:0 0 14px">
    <a class="btn7" href="AddDishFrm7.jsp">Thêm món ăn</a>
    <a class="btn7 off">Sửa thông tin món ăn</a>
    <a class="btn7 off">Xóa món ăn</a>
</div>
<div class="tblbox7"><table class="tbl7">
    <tr><th>TT</th><th>Tên món ăn</th><th>Loại món</th><th>Đơn giá</th><th>Đơn vị</th><th>Trạng thái</th></tr>
    <% for (int i = 0; i < listDish.length; i++) { Dish7 d = listDish[i]; %>
    <tr<%= String.valueOf(d.getId()).equals(newId) ? " class=\"new7\" id=\"new7\"" : "" %>>
        <td><%= i + 1 %></td>
        <td><b><%= h7(d.getName()) %></b></td>
        <td><%= h7(d.getCategory().getName()) %></td>
        <td class="num"><%= money7(d.getPrice()) %></td>
        <td><%= h7(d.getUnit()) %></td>
        <td><span class="tag7 <%= h7(d.getStatus()) %>"><%= h7(status7(d.getStatus())) %></span></td>
    </tr>
    <% } %>
    <% if (listDish.length == 0) { %><tr><td colspan="6" class="empty7">Chưa có món ăn nào.</td></tr><% } %>
</table></div>
<div class="btns7 left7"><a class="btn7 ghost" href="ManagerHomeFrm7.jsp">Quay lại</a></div>
<%@ include file="/view7/bottom7.jspf" %>
