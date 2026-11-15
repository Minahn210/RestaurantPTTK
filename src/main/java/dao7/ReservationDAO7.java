package dao7;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import model7.Customer7;
import model7.Reservation7;
import model7.Table7;

/**
 * Lớp ReservationDAO7 - truy cập bảng tblReservation7.
 */
public class ReservationDAO7 extends DAO7 {

    /** Thời gian giữ bàn cho một lượt đặt (phút). Hai lượt đặt cùng bàn phải cách nhau ít nhất chừng này. */
    public static final int BOOKING_DURATION_MINUTES = 120;

    public ReservationDAO7() {
        super();
    }

    /**
     * Khoảng giờ đến bị coi là trùng với giờ t: từ (t - 120 phút) đến (t + 120 phút), không tính hai đầu mút.
     * Khoảng được cắt trong một ngày (00:00:00 - 23:59:59). Nhà hàng chỉ nhận khách 08:00 - 21:00 nên
     * không có phiếu nào vắt qua nửa đêm.
     */
    static Time[] busyRange(Time t) {
        Calendar c = Calendar.getInstance();
        c.setTime(t);
        int minutes = c.get(Calendar.HOUR_OF_DAY) * 60 + c.get(Calendar.MINUTE);
        int low = Math.max(0, minutes - BOOKING_DURATION_MINUTES);
        int high = Math.min(24 * 60 - 1, minutes + BOOKING_DURATION_MINUTES);
        return new Time[] { toTime(low), toTime(high) };
    }

    private static Time toTime(int minutesOfDay) {
        return Time.valueOf(String.format("%02d:%02d:00", minutesOfDay / 60, minutesOfDay % 60));
    }

    /**
     * Kiểm tra bàn của phiếu r còn trống vào ngày, giờ của phiếu hay không.
     *
     * @return true nếu bàn còn trống (chưa ai đặt trùng giờ).
     */
    public boolean checkTableAvailable(Reservation7 r) {
        Time[] range = busyRange(r.getArrivalTime());
        String sql = "SELECT COUNT(*) FROM tblReservation7 WHERE tblTable7id = ? AND bookingDate = ? "
                + "AND status <> ? AND arrivalTime > ? AND arrivalTime < ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, r.getTable().getId());
            ps.setDate(2, new java.sql.Date(r.getBookingDate().getTime()));
            ps.setString(3, Reservation7.STATUS_CANCELLED);
            ps.setTime(4, range[0]);
            ps.setTime(5, range[1]);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lưu phiếu đặt bàn; nếu thành công gán id (mã phiếu) vừa sinh cho r.
     *
     * @return true nếu lưu thành công.
     */
    public boolean addReservation(Reservation7 r) {
        String sql = "INSERT INTO tblReservation7 (createdTime, bookingDate, arrivalTime, numberOfGuests, note, status, "
                + "tblCustomer7id, tblTable7id, tblStaff7id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setTimestamp(1, new Timestamp(r.getCreatedTime().getTime()));
            ps.setDate(2, new java.sql.Date(r.getBookingDate().getTime()));
            ps.setTime(3, r.getArrivalTime());
            ps.setInt(4, r.getNumberOfGuests());
            ps.setString(5, r.getNote());
            ps.setString(6, r.getStatus());
            ps.setInt(7, r.getCustomer().getId());
            ps.setInt(8, r.getTable().getId());
            if (r.getStaff() != null) {
                ps.setInt(9, r.getStaff().getId());
            } else {
                ps.setNull(9, Types.INTEGER);
            }
            if (ps.executeUpdate() > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        r.setId(keys.getInt(1));
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy danh sách phiếu đặt bàn (kèm khách hàng, bàn) để tra cứu.
     * Dùng cho trang ReservationListFrm7.jsp (NV bán hàng) và ReservationLookupFrm7.jsp (khách hàng).
     *
     * @param phone    số điện thoại khách (null/rỗng: không lọc)
     * @param fromDate chỉ lấy phiếu có ngày đến từ ngày này (null: không lọc)
     */
    public Reservation7[] getReservations(String phone, Date fromDate) {
        List<Reservation7> list = new ArrayList<Reservation7>();
        String p = phone == null ? "" : phone.trim();
        String sql = "SELECT r.id, r.createdTime, r.bookingDate, r.arrivalTime, r.numberOfGuests, r.note, r.status, "
                + "c.id AS cid, c.fullName, c.phone, c.email, t.id AS tid, t.name, t.location, t.capacity, t.description "
                + "FROM tblReservation7 r INNER JOIN tblCustomer7 c ON c.id = r.tblCustomer7id "
                + "INNER JOIN tblTable7 t ON t.id = r.tblTable7id WHERE 1 = 1"
                + (p.isEmpty() ? "" : " AND c.phone = ?") + (fromDate == null ? "" : " AND r.bookingDate >= ?")
                + " ORDER BY r.bookingDate, r.arrivalTime, r.id";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            if (!p.isEmpty()) {
                ps.setString(i++, p);
            }
            if (fromDate != null) {
                ps.setDate(i, new java.sql.Date(fromDate.getTime()));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Customer7 c = new Customer7(rs.getString("fullName"), rs.getString("phone"), rs.getString("email"), null, null);
                    c.setId(rs.getInt("cid"));
                    Reservation7 r = new Reservation7();
                    r.setId(rs.getInt("id"));
                    r.setCreatedTime(rs.getTimestamp("createdTime"));
                    r.setBookingDate(rs.getDate("bookingDate"));
                    r.setArrivalTime(rs.getTime("arrivalTime"));
                    r.setNumberOfGuests(rs.getInt("numberOfGuests"));
                    r.setNote(rs.getString("note"));
                    r.setStatus(rs.getString("status"));
                    r.setCustomer(c);
                    r.setTable(new Table7(rs.getInt("tid"), rs.getString("name"), rs.getString("location"),
                            rs.getInt("capacity"), rs.getString("description")));
                    list.add(r);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new Reservation7[0]);
    }
}
