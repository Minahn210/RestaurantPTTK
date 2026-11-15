<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.Part,dao7.DishDAO7"%><%
    if (!(session.getAttribute("staff") instanceof Manager7)) {
        response.sendRedirect(request.getContextPath() + "/view7/member7/LoginFrm7.jsp?err=timeout");
        return;
    }
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("AddDishFrm7.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    boolean success = false;
    String message;
    Dish7 dish = null;
    try {
        // 1. Nhận thông tin món ăn
        String name = p7(request.getParameter("inName"));
        String categoryId = p7(request.getParameter("inoutCategory"));
        String unit = p7(request.getParameter("inUnit"));
        String description = p7(request.getParameter("inDescription"));
        Part image = request.getPart("inImage");
        DishCategory7 category = null;
        DishCategory7[] listCategory = (DishCategory7[]) session.getAttribute("listCategory");
        for (int i = 0; listCategory != null && i < listCategory.length; i++) {
            if (String.valueOf(listCategory[i].getId()).equals(categoryId)) {
                category = listCategory[i];
            }
        }
        float price = -1;
        try {
            price = Float.parseFloat(p7(request.getParameter("inPrice")));
        } catch (NumberFormatException e) {
        }
        String ext = "";
        if (image != null && image.getSize() > 0) {
            String f = image.getSubmittedFileName() == null ? "" : image.getSubmittedFileName().toLowerCase();
            ext = f.matches(".*\\.(jpg|jpeg|png|gif|webp)$") ? f.substring(f.lastIndexOf('.')) : "?";
        }
        // 2. Kiểm tra dữ liệu nhập
        if (name.isEmpty() || name.length() > 255) {
            message = "Tên món ăn không được để trống (tối đa 255 ký tự).";
        } else if (category == null) {
            message = "Vui lòng chọn loại món.";
        } else if (price <= 0 || price > 100000000) {
            message = "Đơn giá phải là số lớn hơn 0.";
        } else if (unit.isEmpty() || unit.length() > 255) {
            message = "Đơn vị tính không được để trống.";
        } else if (description.length() > 255) {
            message = "Mô tả tối đa 255 ký tự.";
        } else if ("?".equals(ext)) {
            message = "Ảnh món ăn chỉ nhận tệp .jpg, .jpeg, .png, .gif, .webp.";
        } else {
            // 3. Đóng gói thông tin món ăn mới (Dish7)
            dish = new Dish7(name, price, unit, description.isEmpty() ? null : description, null, "active", category);
            // 4. Kiểm tra tên món (DishDAO7: checkDishName())
            DishDAO7 dishDAO = new DishDAO7();
            if (dishDAO.checkDishName(dish.getName())) {
                message = "Tên món ăn đã tồn tại. Vui lòng nhập tên khác!";
            } else {
                // 5. Lưu ảnh (nếu có) và lưu món ăn mới (DishDAO7: addDish())
                if (!ext.isEmpty()) {
                    String file = "dish7_" + new java.util.Date().getTime() + ext;
                    image.write(new File(dir7(application.getRealPath("/")), file).getAbsolutePath());
                    dish.setImage(file);
                }
                success = dishDAO.addDish(dish);
                message = success ? "Thêm món ăn mới thành công!" : "Lỗi khi lưu món ăn vào CSDL. Vui lòng thử lại!";
            }
        }
    } catch (IllegalStateException e) {
        message = "Ảnh món ăn quá lớn (tối đa 5 MB).";
    }
    String title7 = "Thông báo";
%><%@ include file="/view7/top7.jspf" %>
<div class="mask7"><div class="pop7">
    <h2>Thông báo</h2>
    <% if (success) { %>
        <div class="big7">✅</div>
        <p class="ok"><%= h7(message) %></p>
        <p>Món <b><%= h7(dish.getName()) %></b> (mã <%= dish.getId() %>) – <%= h7(dish.getCategory().getName()) %>, <%= money7(dish.getPrice()) %>/<%= h7(dish.getUnit()) %></p>
        <div class="btns7"><a class="btn7" href="ManageDishFrm7.jsp?newId=<%= dish.getId() %>#new7">OK</a></div>
    <% } else { %>
        <div class="big7">⚠️</div>
        <p class="bad"><%= h7(message) %></p>
        <div class="btns7"><button type="button" class="btn7" onclick="history.back()">OK</button></div>
    <% } %>
</div></div>
<%@ include file="/view7/bottom7.jspf" %>
