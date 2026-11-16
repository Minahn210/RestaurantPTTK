# Restaurant7 – Web cho 2 module (Đoàn Minh Hoàng – B23DCVT167)

Công nghệ theo giáo trình và tài liệu J2EE của cô: **JSP + JDBC + MySQL + DAO**, chạy trên **Apache Tomcat 8.5, JDK 1.8**.
Code bám đúng thiết kế trong báo cáo (biểu đồ lớp thiết kế Hình 15, 16; package diagram Hình 21; CSDL Hình 12).

- **Module 1 – NV quản lý thêm món ăn:** Đăng nhập → Trang chủ quản lý → Quản lý món ăn → Thêm món ăn mới → Thông báo.
- **Module 2 – Khách hàng đặt bàn online:** Trang chủ khách hàng → Tìm bàn trống (ngày, giờ) → Danh sách bàn trống → Thông tin đặt bàn → Thông báo (kèm mã phiếu).

## 1. Cấu trúc thư mục

```
Restaurant7/
├── database/restaurant7_db.sql      CSDL 18 bảng tbl...7 + dữ liệu mẫu
├── build7.bat / build7.sh           build nhanh ra target/restaurant7.war
├── pom.xml                          (nếu dùng Maven)
└── src/main/
    ├── java/
    │   ├── model7/  Member7, Staff7, Manager7, SaleStaff7, WarehouseStaff7, DishCategory7, Dish7,
    │   │            Table7, Customer7, MembershipCard7, Reservation7
    │   └── dao7/    DAO7, DishCategoryDAO7, DishDAO7, TableDAO7, ReservationDAO7, CustomerDAO7, MemberDAO7
    └── webapp/      (jsp)
        ├── index.jsp                 chuyển tới trang chủ nhà hàng
        ├── css/style7.css, images/no-image7.svg, WEB-INF/web.xml
        └── view7/
            ├── common7.jspf, top7.jspf, bottom7.jspf   hàm dùng chung, đầu trang, chân trang
            ├── image7.jsp            trả ảnh món ăn đã tải lên
            ├── member7/    LoginFrm7, doLogin7, doLogout7
            ├── manager7/   ManagerHomeFrm7, ManageDishFrm7, AddDishFrm7, doAddDish7      (module 1)
            ├── customer7/  CustomerHomeFrm7, SearchTableFrm7, AvailableTableFrm7,
            │               BookingInfoFrm7, doBooking7                                   (module 2)
            │               MenuFrm7 (thực đơn), ReservationLookupFrm7 (tra cứu đặt bàn)
            ├── sale7/      SaleHomeFrm7, ReservationListFrm7 (NV bán hàng xem phiếu đặt bàn)
            └── warehouse7/ WarehouseHomeFrm7
```

Tài khoản mẫu (mật khẩu đều là **123456**): `manager7` (NV quản lý), `sale7` (NV bán hàng), `kho7` (NV kho).
Ảnh món ăn tải lên được lưu ở thư mục `restaurant7_images` nằm trong thư mục cài Tomcat
(ví dụ `C:\apache-tomcat-9.0.xx\restaurant7_images`) nên build/deploy lại không bị mất ảnh.

## 2. Tạo CSDL

1. Cài MySQL 8.0, mở MySQL Workbench (hoặc dòng lệnh).
2. Chạy toàn bộ file `database/restaurant7_db.sql` → tạo CSDL `restaurant7_db` cùng dữ liệu mẫu.
3. Tài khoản mẫu: manager7 / sale7 / kho7, mật khẩu 123456.

Mặc định code kết nối `localhost:3306`, user **root**, mật khẩu **123456**.
Nếu MySQL của bạn dùng mật khẩu khác, sửa hằng `DEFAULT_PASSWORD` trong `src/main/java/dao7/DAO7.java`
(hoặc thêm tham số JVM cho Tomcat: `-Ddb7.password=matkhau`).

## 3a. Chạy bằng Eclipse 

1. File → New → Dynamic Web Project, tên `restaurant7`, Target runtime: Apache Tomcat v8.5.
2. Chép nội dung `src/main/java` vào thư mục `src` (Java Resources) của project.
3. Chép nội dung `src/main/webapp` vào thư mục `WebContent` (Eclipse mới: `src/main/webapp`).
4. Tải `mysql-connector-java-8.0.13.jar` chép vào `WEB-INF/lib`.
5. Chuột phải project → Run As → Run on Server → mở `http://localhost:8080/restaurant7/`.

**Cách khác:** dùng Maven (Eclipse/IntelliJ/NetBeans đều mở được `pom.xml`). Chạy `mvn package` để ra `target/restaurant7.war`, rồi chép vào thư mục `webapps` của Tomcat.

## 3b. Chạy bằng VS Code

1. Cài 2 extension: **Extension Pack for Java** (Microsoft) và **Community Server Connectors** (Red Hat).
2. File → Open Folder → chọn thư mục `Restaurant7`.
3. Terminal → New Terminal, chạy `.\build7.bat` (macOS/Linux: `sh build7.sh`).
   Script tự tải driver MySQL, biên dịch `model7`, `dao7` và tạo `target/restaurant7.war`.
4. Tab **SERVERS** (góc dưới thanh bên trái) → Community Server Connector → chuột phải → **Create New Server**
   → chọn tải Tomcat 8.5 về hoặc trỏ tới thư mục Tomcat 8.5 có sẵn.
5. Chuột phải server Tomcat → **Start Server**.
6. Chuột phải server → **Add Deployment** → chọn file `target/restaurant7.war` → chuột phải server → **Publish Server (Full)**.
7. Mở `http://localhost:8080/restaurant7/`.

Sửa code xong: chạy lại `build7.bat` rồi **Publish Server (Full)**.
Không dùng extension: chép `target/restaurant7.war` vào thư mục `webapps` của Tomcat rồi chạy `bin/startup.bat`.

## 4. Một số quy ước trong code

- Mỗi lần đặt bàn giữ bàn **2 tiếng** (`ReservationDAO7.BOOKING_DURATION_MINUTES = 120`). Bàn bị coi là bận nếu đã có phiếu chưa hủy cùng ngày, giờ đến cách nhau dưới 2 tiếng.
- Nhà hàng nhận khách đến từ **08:00 đến 21:00**. Không đặt được giờ đã qua.
- Phiếu đặt online có trạng thái `pending` (chờ NV bán hàng xác nhận), `tblStaff7id` để trống.
- Khách đặt bàn được tìm theo số điện thoại. Nếu chưa có thì thêm khách hàng mới.
- Tên món ăn bị trùng nếu giống hệt sau khi bỏ khoảng trắng đầu cuối, không phân biệt hoa thường nhưng **có** phân biệt dấu: "Bún chả" ≠ "Bun cha".
- Ảnh món ăn: .jpg/.jpeg/.png/.gif/.webp, tối đa 5 MB, lưu vào thư mục `restaurant7_images` trong thư mục cài Tomcat.
- Các mục trong menu ngoài 2 module (Tạo combo, Thống kê, Sửa/Xóa món, Đặt món) chỉ hiển thị mờ, chưa làm.
