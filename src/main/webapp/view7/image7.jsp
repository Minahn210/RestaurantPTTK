<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%><%@ include file="/view7/common7.jspf" %><%
    // Trả về ảnh món ăn đã tải lên (lưu ngoài thư mục web, xem dir7())
    String name = p7(request.getParameter("name"));
    File f = new File(dir7(application.getRealPath("/")), name);
    if (name.isEmpty() || !f.getName().equals(name) || !f.isFile()) {
        response.sendRedirect(request.getContextPath() + "/images/no-image7.svg");
        return;
    }
    response.setContentType(application.getMimeType(name) == null ? "application/octet-stream" : application.getMimeType(name));
    response.setHeader("Cache-Control", "max-age=86400");
    out.clear();
    java.nio.file.Files.copy(f.toPath(), response.getOutputStream());
    response.getOutputStream().flush();
    out = pageContext.pushBody();
%>
