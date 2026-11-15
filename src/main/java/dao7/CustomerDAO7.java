package dao7;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model7.Customer7;
import model7.MembershipCard7;

/**
 * Lớp CustomerDAO7 - truy cập bảng tblCustomer7 (kèm thẻ thành viên tblMembershipCard7).
 */
public class CustomerDAO7 extends DAO7 {

    public CustomerDAO7() {
        super();
    }

    /**
     * Tìm khách hàng theo số điện thoại.
     *
     * @return Customer7 (kèm thẻ thành viên nếu có) hoặc null nếu chưa có khách hàng này.
     */
    public Customer7 getCustomerByPhone(String phone) {
        String sql = "SELECT c.id, c.fullName, c.phone, c.email, c.address, c.note, "
                + "m.id AS cardId, m.cardCode, m.issueDate, m.points "
                + "FROM tblCustomer7 c LEFT JOIN tblMembershipCard7 m ON m.tblCustomer7id = c.id "
                + "WHERE c.phone = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer7 c = new Customer7(rs.getString("fullName"), rs.getString("phone"),
                            rs.getString("email"), rs.getString("address"), rs.getString("note"));
                    c.setId(rs.getInt("id"));
                    int cardId = rs.getInt("cardId");
                    if (!rs.wasNull()) {
                        MembershipCard7 card = new MembershipCard7();
                        card.setId(cardId);
                        card.setCardCode(rs.getString("cardCode"));
                        card.setIssueDate(rs.getDate("issueDate"));
                        card.setPoints(rs.getInt("points"));
                        c.setCard(card);
                    }
                    return c;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Thêm khách hàng mới; nếu thành công gán id vừa sinh cho c.
     *
     * @return true nếu thêm thành công.
     */
    public boolean addCustomer(Customer7 c) {
        String sql = "INSERT INTO tblCustomer7 (fullName, phone, email, address, note) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getFullName());
            ps.setString(2, c.getPhone());
            ps.setString(3, c.getEmail());
            ps.setString(4, c.getAddress());
            ps.setString(5, c.getNote());
            if (ps.executeUpdate() > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        c.setId(keys.getInt(1));
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
