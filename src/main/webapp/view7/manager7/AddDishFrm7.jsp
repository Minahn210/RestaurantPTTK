<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model7.Manager7,dao7.DishCategoryDAO7"%><%
    if (!(session.getAttribute("staff") instanceof Manager7)) {
        response.sendRedirect(request.getContextPath() + "/view7/member7/LoginFrm7.jsp?err=timeout");
        return;
    }
    // Lấy danh sách loại món (DishCategoryDAO7: getAllCategories())
    DishCategoryDAO7 dishCategoryDAO = new DishCategoryDAO7();
    DishCategory7[] listCategory = dishCategoryDAO.getAllCategories();
    session.setAttribute("listCategory", listCategory);
    String title7 = "Thêm món ăn mới";
%><%@ include file="/view7/top7.jspf" %>
<div class="card7 frm7">
    <h2>Thêm món ăn mới</h2>
    <form action="doAddDish7.jsp" method="post" enctype="multipart/form-data">
        <div class="row7"><label for="inName">Tên món ăn <span class="req">*</span></label>
            <input type="text" id="inName" name="inName" required maxlength="255"></div>
        <div class="row7"><label for="inoutCategory">Loại món <span class="req">*</span></label>
            <select id="inoutCategory" name="inoutCategory" required>
                <option value="">-- Chọn loại món --</option>
                <% for (DishCategory7 c : listCategory) { %><option value="<%= c.getId() %>"><%= h7(c.getName()) %></option><% } %>
            </select></div>
        <div class="row7"><label for="inPrice">Đơn giá (VNĐ) <span class="req">*</span></label>
            <input type="number" id="inPrice" name="inPrice" required min="1000" max="100000000" step="500"></div>
        <div class="row7"><label for="inUnit">Đơn vị tính <span class="req">*</span></label>
            <input type="text" id="inUnit" name="inUnit" required maxlength="255" placeholder="Đĩa, Bát, Nồi, Cốc..."></div>
        <div class="row7"><label for="inDescription">Mô tả</label>
            <textarea id="inDescription" name="inDescription" maxlength="255"></textarea></div>
        <div class="row7"><label for="inImage">Ảnh món ăn</label>
            <div><input type="file" id="inImage" name="inImage" accept=".jpg,.jpeg,.png,.gif,.webp">
            <img id="preview7" class="preview7" alt=""></div></div>
        <div class="btns7">
            <a class="btn7 ghost" href="ManageDishFrm7.jsp">Quay lại</a>
            <button type="submit" class="btn7" name="subAdd">Thêm</button>
        </div>
    </form>
</div>
<script>
document.getElementById('inImage').onchange = function () {
    var p = document.getElementById('preview7');
    if (this.files[0]) { p.src = URL.createObjectURL(this.files[0]); p.style.display = 'block'; } else { p.style.display = 'none'; }
};
</script>
<%@ include file="/view7/bottom7.jspf" %>
