package dao7;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model7.Dish7;
import model7.DishCategory7;

/**
 * Lớp DishDAO7 - truy cập bảng tblDish7.
 */
public class DishDAO7 extends DAO7 {

    public DishDAO7() {
        super();
    }

    /**
     * Lấy toàn bộ món ăn (kèm loại món), món mới thêm đứng đầu danh sách.
     * Dùng cho trang ManageDishFrm7.jsp (hiển thị danh sách món ăn).
     */
    public Dish7[] getAllDishes() {
        List<Dish7> list = new ArrayList<Dish7>();
        String sql = "SELECT d.id, d.name, d.price, d.unit, d.description, d.image, d.status, "
                + "c.id AS cid, c.name AS cname, c.description AS cdesc "
                + "FROM tblDish7 d INNER JOIN tblDishCategory7 c ON c.id = d.tblDishCategory7id ORDER BY d.id DESC";
        try (PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DishCategory7 c = new DishCategory7(rs.getInt("cid"), rs.getString("cname"), rs.getString("cdesc"));
                Dish7 d = new Dish7(rs.getString("name"), rs.getFloat("price"), rs.getString("unit"),
                        rs.getString("description"), rs.getString("image"), rs.getString("status"), c);
                d.setId(rs.getInt("id"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new Dish7[0]);
    }

    /**
     * Kiểm tra tên món ăn đã tồn tại chưa (không phân biệt hoa thường, phân biệt dấu tiếng Việt).
     *
     * @return true nếu tên món đã tồn tại, false nếu chưa có.
     */
    public boolean checkDishName(String name) {
        if (name == null) {
            return false;
        }
        String key = name.trim();
        String sql = "SELECT name FROM tblDish7 WHERE LOWER(name) = LOWER(?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, key);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String existing = rs.getString("name");
                    if (existing != null && existing.trim().equalsIgnoreCase(key)) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Thêm món ăn mới vào CSDL; nếu thành công gán id vừa sinh cho đối tượng dish.
     *
     * @return true nếu thêm thành công.
     */
    public boolean addDish(Dish7 dish) {
        String sql = "INSERT INTO tblDish7 (name, price, unit, description, image, status, tblDishCategory7id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, dish.getName());
            ps.setFloat(2, dish.getPrice());
            ps.setString(3, dish.getUnit());
            ps.setString(4, dish.getDescription());
            ps.setString(5, dish.getImage());
            ps.setString(6, dish.getStatus());
            ps.setInt(7, dish.getCategory().getId());
            if (ps.executeUpdate() > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        dish.setId(keys.getInt(1));
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
