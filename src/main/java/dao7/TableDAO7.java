package dao7;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import model7.Reservation7;
import model7.Table7;

/**
 * Lớp TableDAO7 - truy cập bảng tblTable7.
 */
public class TableDAO7 extends DAO7 {

    public TableDAO7() {
        super();
    }

    /**
     * Tìm các bàn còn trống tại ngày, giờ khách muốn đến.
     * Một bàn bị coi là bận nếu đã có phiếu đặt (chưa hủy) cùng ngày mà giờ đến cách
     * giờ khách chọn chưa đủ ReservationDAO7.BOOKING_DURATION_MINUTES phút.
     */
    public Table7[] getAvailableTables(Date date, Time time) {
        List<Table7> list = new ArrayList<Table7>();
        Time[] range = ReservationDAO7.busyRange(time);
        String sql = "SELECT id, name, location, capacity, description FROM tblTable7 WHERE id NOT IN ("
                + "SELECT r.tblTable7id FROM tblReservation7 r WHERE r.bookingDate = ? AND r.status <> ? "
                + "AND r.arrivalTime > ? AND r.arrivalTime < ?) ORDER BY name";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, new java.sql.Date(date.getTime()));
            ps.setString(2, Reservation7.STATUS_CANCELLED);
            ps.setTime(3, range[0]);
            ps.setTime(4, range[1]);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Table7(rs.getInt("id"), rs.getString("name"), rs.getString("location"),
                            rs.getInt("capacity"), rs.getString("description")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new Table7[0]);
    }
}
