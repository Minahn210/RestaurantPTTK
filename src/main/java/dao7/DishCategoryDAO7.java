package dao7;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model7.DishCategory7;

/**
 * Lớp DishCategoryDAO7 - truy cập bảng tblDishCategory7.
 */
public class DishCategoryDAO7 extends DAO7 {

    public DishCategoryDAO7() {
        super();
    }

    /**
     * Lấy toàn bộ loại món ăn (để hiển thị trong ô chọn loại món của AddDishFrm7.jsp).
     */
    public DishCategory7[] getAllCategories() {
        List<DishCategory7> list = new ArrayList<DishCategory7>();
        String sql = "SELECT id, name, description FROM tblDishCategory7 ORDER BY name";
        try (PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new DishCategory7(rs.getInt("id"), rs.getString("name"), rs.getString("description")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new DishCategory7[0]);
    }
}
