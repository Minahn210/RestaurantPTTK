package dao7;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model7.Manager7;
import model7.Member7;
import model7.SaleStaff7;
import model7.Staff7;
import model7.WarehouseStaff7;

/**
 * Lớp MemberDAO7 - phục vụ đăng nhập của nhân viên (các trang trong gói view7/member7).
 */
public class MemberDAO7 extends DAO7 {

    public MemberDAO7() {
        super();
    }

    /**
     * Kiểm tra đăng nhập của nhân viên.
     *
     * @return đối tượng nhân viên theo vai trò (Manager7, SaleStaff7, WarehouseStaff7) nếu đúng
     *         tên đăng nhập / mật khẩu, null nếu sai.
     */
    public Staff7 checkLogin(String username, String password) {
        String sql = "SELECT m.id, m.username, m.fullName, m.dateOfBirth, m.address, m.email, m.phone, m.role, m.note, "
                + "s.position FROM tblMember7 m INNER JOIN tblStaff7 s ON s.tblMember7id = m.id "
                + "WHERE m.username = ? AND m.password = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String role = rs.getString("role");
                    Staff7 staff;
                    if ("manager".equalsIgnoreCase(role)) {
                        staff = new Manager7();
                    } else if ("sale".equalsIgnoreCase(role)) {
                        staff = new SaleStaff7();
                    } else {
                        staff = new WarehouseStaff7();
                    }
                    fill(staff, rs);
                    staff.setPosition(rs.getString("position"));
                    return staff;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void fill(Member7 m, ResultSet rs) throws Exception {
        m.setId(rs.getInt("id"));
        m.setUsername(rs.getString("username"));
        m.setFullName(rs.getString("fullName"));
        m.setDateOfBirth(rs.getDate("dateOfBirth"));
        m.setAddress(rs.getString("address"));
        m.setEmail(rs.getString("email"));
        m.setPhone(rs.getString("phone"));
        m.setRole(rs.getString("role"));
        m.setNote(rs.getString("note"));
    }
}
