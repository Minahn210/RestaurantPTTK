-- =====================================================================
-- CSDL hệ thống quản lý nhà hàng - Đoàn Minh Hoàng - B23DCVT167
-- Tạo theo sơ đồ thiết kế CSDL (Hình 12): 18 bảng tbl...7
-- Chạy bằng MySQL Workbench hoặc: mysql -u root -p < restaurant7_db.sql
-- =====================================================================
DROP DATABASE IF EXISTS restaurant7_db;
CREATE DATABASE restaurant7_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restaurant7_db;

-- ---------- Thành viên, nhân viên ----------
CREATE TABLE tblMember7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  fullName VARCHAR(255) NOT NULL,
  dateOfBirth DATE,
  address VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(255),
  role VARCHAR(255) NOT NULL,
  note VARCHAR(255),
  PRIMARY KEY (id),
  UNIQUE KEY uq_member7_username (username)
) ENGINE=InnoDB;

CREATE TABLE tblStaff7 (
  tblMember7id INT(10) NOT NULL,
  position VARCHAR(255),
  PRIMARY KEY (tblMember7id),
  CONSTRAINT fk_staff7_member7 FOREIGN KEY (tblMember7id) REFERENCES tblMember7 (id)
) ENGINE=InnoDB;

-- ---------- Khách hàng, thẻ thành viên ----------
CREATE TABLE tblCustomer7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  fullName VARCHAR(255) NOT NULL,
  phone VARCHAR(255),
  email VARCHAR(255),
  address VARCHAR(255),
  note VARCHAR(255),
  PRIMARY KEY (id),
  UNIQUE KEY uq_customer7_phone (phone)
) ENGINE=InnoDB;

CREATE TABLE tblMembershipCard7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  cardCode VARCHAR(255) NOT NULL,
  issueDate DATE,
  points INT(10) NOT NULL DEFAULT 0,
  tblCustomer7id INT(10) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_card7_customer (tblCustomer7id),
  CONSTRAINT fk_card7_customer7 FOREIGN KEY (tblCustomer7id) REFERENCES tblCustomer7 (id)
) ENGINE=InnoDB;

-- ---------- Nhà cung cấp, nguyên liệu, phiếu nhập ----------
CREATE TABLE tblSupplier7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  phone VARCHAR(255),
  email VARCHAR(255),
  description VARCHAR(255),
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE tblIngredient7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  unit VARCHAR(255),
  stockQuantity FLOAT NOT NULL DEFAULT 0,
  description VARCHAR(255),
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE tblImportInvoice7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  importDate DATE NOT NULL,
  note VARCHAR(255),
  tblSupplier7id INT(10) NOT NULL,
  tblStaff7id INT(10) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_import7_supplier7 FOREIGN KEY (tblSupplier7id) REFERENCES tblSupplier7 (id),
  CONSTRAINT fk_import7_staff7 FOREIGN KEY (tblStaff7id) REFERENCES tblStaff7 (tblMember7id)
) ENGINE=InnoDB;

CREATE TABLE tblImportedIngredient7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  quantity FLOAT NOT NULL,
  unitPrice FLOAT NOT NULL,
  tblImportInvoice7id INT(10) NOT NULL,
  tblIngredient7id INT(10) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_imported7_invoice7 FOREIGN KEY (tblImportInvoice7id) REFERENCES tblImportInvoice7 (id),
  CONSTRAINT fk_imported7_ingredient7 FOREIGN KEY (tblIngredient7id) REFERENCES tblIngredient7 (id)
) ENGINE=InnoDB;

-- ---------- Thực đơn ----------
CREATE TABLE tblDishCategory7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE tblDish7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  unit VARCHAR(255),
  description VARCHAR(255),
  image VARCHAR(255),
  status VARCHAR(255),
  tblDishCategory7id INT(10) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_dish7_category7 FOREIGN KEY (tblDishCategory7id) REFERENCES tblDishCategory7 (id)
) ENGINE=InnoDB;

CREATE TABLE tblCombo7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  description VARCHAR(255),
  status VARCHAR(255),
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE tblComboDish7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  quantity INT(10) NOT NULL,
  tblCombo7id INT(10) NOT NULL,
  tblDish7id INT(10) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_combodish7_combo7 FOREIGN KEY (tblCombo7id) REFERENCES tblCombo7 (id),
  CONSTRAINT fk_combodish7_dish7 FOREIGN KEY (tblDish7id) REFERENCES tblDish7 (id)
) ENGINE=InnoDB;

-- ---------- Bàn, đặt bàn, gọi món, hóa đơn ----------
CREATE TABLE tblTable7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255),
  capacity INT(10) NOT NULL,
  description VARCHAR(255),
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE tblReservation7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  createdTime DATETIME NOT NULL,
  bookingDate DATE NOT NULL,
  arrivalTime TIME NOT NULL,
  numberOfGuests INT(10) NOT NULL,
  note VARCHAR(255),
  status VARCHAR(255) NOT NULL,
  tblCustomer7id INT(10) NOT NULL,
  tblTable7id INT(10) NOT NULL,
  tblStaff7id INT(10),
  PRIMARY KEY (id),
  CONSTRAINT fk_reservation7_customer7 FOREIGN KEY (tblCustomer7id) REFERENCES tblCustomer7 (id),
  CONSTRAINT fk_reservation7_table7 FOREIGN KEY (tblTable7id) REFERENCES tblTable7 (id),
  CONSTRAINT fk_reservation7_staff7 FOREIGN KEY (tblStaff7id) REFERENCES tblStaff7 (tblMember7id)
) ENGINE=InnoDB;

CREATE TABLE tblOrder7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  createdTime DATETIME NOT NULL,
  orderType VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL,
  note VARCHAR(255),
  tblTable7id INT(10),
  tblCustomer7id INT(10),
  tblReservation7id INT(10),
  tblStaff7id INT(10),
  PRIMARY KEY (id),
  CONSTRAINT fk_order7_table7 FOREIGN KEY (tblTable7id) REFERENCES tblTable7 (id),
  CONSTRAINT fk_order7_customer7 FOREIGN KEY (tblCustomer7id) REFERENCES tblCustomer7 (id),
  CONSTRAINT fk_order7_reservation7 FOREIGN KEY (tblReservation7id) REFERENCES tblReservation7 (id),
  CONSTRAINT fk_order7_staff7 FOREIGN KEY (tblStaff7id) REFERENCES tblStaff7 (tblMember7id)
) ENGINE=InnoDB;

CREATE TABLE tblOrderedDish7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  quantity INT(10) NOT NULL,
  unitPrice FLOAT NOT NULL,
  tblOrder7id INT(10) NOT NULL,
  tblDish7id INT(10) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_ordereddish7_order7 FOREIGN KEY (tblOrder7id) REFERENCES tblOrder7 (id),
  CONSTRAINT fk_ordereddish7_dish7 FOREIGN KEY (tblDish7id) REFERENCES tblDish7 (id)
) ENGINE=InnoDB;

CREATE TABLE tblOrderedCombo7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  quantity INT(10) NOT NULL,
  unitPrice FLOAT NOT NULL,
  tblOrder7id INT(10) NOT NULL,
  tblCombo7id INT(10) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_orderedcombo7_order7 FOREIGN KEY (tblOrder7id) REFERENCES tblOrder7 (id),
  CONSTRAINT fk_orderedcombo7_combo7 FOREIGN KEY (tblCombo7id) REFERENCES tblCombo7 (id)
) ENGINE=InnoDB;

CREATE TABLE tblBill7 (
  id INT(10) NOT NULL AUTO_INCREMENT,
  paymentTime DATETIME NOT NULL,
  discount FLOAT NOT NULL DEFAULT 0,
  pointsUsed INT(10) NOT NULL DEFAULT 0,
  pointsEarned INT(10) NOT NULL DEFAULT 0,
  paymentMethod VARCHAR(255),
  tblOrder7id INT(10) NOT NULL,
  tblCustomer7id INT(10),
  tblStaff7id INT(10) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_bill7_order (tblOrder7id),
  CONSTRAINT fk_bill7_order7 FOREIGN KEY (tblOrder7id) REFERENCES tblOrder7 (id),
  CONSTRAINT fk_bill7_customer7 FOREIGN KEY (tblCustomer7id) REFERENCES tblCustomer7 (id),
  CONSTRAINT fk_bill7_staff7 FOREIGN KEY (tblStaff7id) REFERENCES tblStaff7 (tblMember7id)
) ENGINE=InnoDB;

-- =====================================================================
-- Dữ liệu mẫu
-- =====================================================================
-- Tài khoản đăng nhập: manager7 / 123456 (NV quản lý), sale7 / 123456 (NV bán hàng), kho7 / 123456 (NV kho)
INSERT INTO tblMember7 (id, username, password, fullName, dateOfBirth, address, email, phone, role, note) VALUES
(1, 'manager7', '123456', 'Nguyễn Văn A', '1990-05-12', 'Hà Đông, Hà Nội', 'manager7@restaurant7.vn', '0912000001', 'manager', NULL),
(2, 'sale7', '123456', 'Trần Thị B', '1998-09-20', 'Thanh Xuân, Hà Nội', 'sale7@restaurant7.vn', '0912000002', 'sale', NULL),
(3, 'kho7', '123456', 'Lê Văn C', '1995-03-02', 'Cầu Giấy, Hà Nội', 'kho7@restaurant7.vn', '0912000003', 'warehouse', NULL);

INSERT INTO tblStaff7 (tblMember7id, position) VALUES
(1, 'Quản lý'),
(2, 'Nhân viên bán hàng'),
(3, 'Nhân viên kho');

INSERT INTO tblDishCategory7 (id, name, description) VALUES
(1, 'Khai vị', 'Món ăn nhẹ dùng trước bữa chính'),
(2, 'Món chính', 'Các món ăn chính'),
(3, 'Lẩu', 'Các loại lẩu dùng theo nồi'),
(4, 'Đồ uống', 'Nước giải khát, đồ uống'),
(5, 'Tráng miệng', 'Món ngọt, hoa quả sau bữa ăn');

INSERT INTO tblDish7 (id, name, price, unit, description, image, status, tblDishCategory7id) VALUES
(1, 'Gỏi cuốn tôm thịt', 45000, 'Đĩa', 'Gỏi cuốn tôm, thịt ba chỉ, rau sống, chấm tương', NULL, 'active', 1),
(2, 'Nem rán Hà Nội', 60000, 'Đĩa', 'Nem rán giòn nhân thịt, mộc nhĩ, miến', NULL, 'active', 1),
(3, 'Phở bò tái', 55000, 'Bát', 'Phở bò tái truyền thống, nước dùng hầm xương', NULL, 'active', 2),
(4, 'Cơm rang dưa bò', 60000, 'Đĩa', 'Cơm rang với dưa chua và thịt bò', NULL, 'active', 2),
(5, 'Cá kho tộ', 120000, 'Nồi', 'Cá basa kho tộ đậm vị, ăn kèm cơm trắng', NULL, 'active', 2),
(6, 'Lẩu thái hải sản', 350000, 'Nồi', 'Lẩu chua cay hải sản cho 3-4 người', NULL, 'active', 3),
(7, 'Lẩu gà lá é', 320000, 'Nồi', 'Lẩu gà ta nấu lá é cho 3-4 người', NULL, 'active', 3),
(8, 'Trà đá', 5000, 'Cốc', NULL, NULL, 'active', 4),
(9, 'Nước cam ép', 35000, 'Cốc', 'Cam tươi ép nguyên chất', NULL, 'active', 4),
(10, 'Chè khúc bạch', 30000, 'Cốc', 'Chè khúc bạch hạnh nhân', NULL, 'active', 5);

INSERT INTO tblTable7 (id, name, location, capacity, description) VALUES
(1, 'B01', 'Tầng 1 - cạnh cửa sổ', 4, 'Bàn tròn'),
(2, 'B02', 'Tầng 1 - giữa sảnh', 4, 'Bàn vuông'),
(3, 'B03', 'Tầng 1 - gần quầy', 2, 'Bàn đôi'),
(4, 'B04', 'Tầng 1 - giữa sảnh', 6, 'Bàn dài'),
(5, 'B05', 'Tầng 2 - phòng VIP', 8, 'Có điều hòa, karaoke'),
(6, 'B06', 'Tầng 2 - ban công', 4, 'Không gian ngoài trời'),
(7, 'B07', 'Tầng 2 - ban công', 2, 'Bàn đôi ngoài trời'),
(8, 'B08', 'Tầng 2 - phòng VIP', 12, 'Phòng tiệc lớn');

INSERT INTO tblCustomer7 (id, fullName, phone, email, address, note) VALUES
(1, 'Phạm Thị D', '0987000001', 'phamd@gmail.com', 'Hà Đông, Hà Nội', NULL),
(2, 'Hoàng Văn E', '0987000002', NULL, 'Thanh Xuân, Hà Nội', NULL);

INSERT INTO tblMembershipCard7 (id, cardCode, issueDate, points, tblCustomer7id) VALUES
(1, 'TV7-0001', '2026-01-15', 120, 1);

-- Phiếu đặt bàn mẫu (ngày đến tính theo ngày chạy script)
INSERT INTO tblReservation7 (id, createdTime, bookingDate, arrivalTime, numberOfGuests, note, status, tblCustomer7id, tblTable7id, tblStaff7id) VALUES
(1, NOW(), DATE_ADD(CURDATE(), INTERVAL 1 DAY), '18:30:00', 4, 'Sinh nhật, cần bánh kem', 'confirmed', 1, 1, 2),
(2, NOW(), DATE_ADD(CURDATE(), INTERVAL 2 DAY), '12:00:00', 6, NULL, 'pending', 2, 4, NULL);

INSERT INTO tblSupplier7 (id, name, address, phone, email, description) VALUES
(1, 'Công ty Thực phẩm Sạch Hà Nội', 'Long Biên, Hà Nội', '0243000111', 'lienhe@thucphamsach.vn', 'Cung cấp thịt, rau củ');

INSERT INTO tblIngredient7 (id, name, unit, stockQuantity, description) VALUES
(1, 'Thịt bò', 'kg', 20, NULL),
(2, 'Bánh phở', 'kg', 30, NULL);
