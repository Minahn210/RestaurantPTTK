<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao7.DishDAO7,dao7.DishCategoryDAO7"%><%
    request.setCharacterEncoding("UTF-8");
    String keyword = p7(request.getParameter("q"));
    String cat = p7(request.getParameter("cat"));
    DishCategory7[] listCategory = new DishCategoryDAO7().getAllCategories();
    Dish7[] listDish = new DishDAO7().getAllDishes();
    String title7 = "Thực đơn";
%><%@ include file="/view7/top7.jspf" %>
<div class="head7">
    <div><h1>Thực đơn</h1><p>Các món ăn đang phục vụ tại nhà hàng.</p></div>
    <form class="inline7" style="margin:0" method="get">
        <input type="hidden" name="cat" value="<%= h7(cat) %>">
        <input type="search" name="q" value="<%= h7(keyword) %>" placeholder="Tìm tên món...">
        <button class="btn7" type="submit">Tìm</button>
    </form>
</div>
<div class="chips7">
    <a class="<%= cat.isEmpty() ? "on" : "" %>" href="MenuFrm7.jsp?q=<%= java.net.URLEncoder.encode(keyword, "UTF-8") %>">Tất cả</a>
    <% for (DishCategory7 c : listCategory) { %>
    <a class="<%= String.valueOf(c.getId()).equals(cat) ? "on" : "" %>" href="MenuFrm7.jsp?cat=<%= c.getId() %>&q=<%= java.net.URLEncoder.encode(keyword, "UTF-8") %>"><%= h7(c.getName()) %></a>
    <% } %>
</div>
<div class="grid7">
<% int count = 0;
   for (Dish7 d : listDish) {
       if (!"active".equals(d.getStatus())) continue;
       if (!cat.isEmpty() && !String.valueOf(d.getCategory().getId()).equals(cat)) continue;
       if (!keyword.isEmpty() && !d.getName().toLowerCase().contains(keyword.toLowerCase())) continue;
       count++; %>
    <div class="dish7"><img src="<%= img7(ctx, d) %>" alt="<%= h7(d.getName()) %>">
        <div><b><%= h7(d.getName()) %></b><small><%= h7(d.getCategory().getName()) %></small>
        <p style="margin:6px 0"><%= h7(d.getDescription()) %></p>
        <span class="price7"><%= money7(d.getPrice()) %></span> <small>/ <%= h7(d.getUnit()) %></small></div></div>
<% } %>
</div>
<% if (count == 0) { %><p class="empty7">Không tìm thấy món ăn phù hợp.</p><% } %>
<%@ include file="/view7/bottom7.jspf" %>
