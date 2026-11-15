package model7;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

/**
 * Lớp thực thể Reservation7 - phiếu đặt bàn. Ánh xạ bảng tblReservation7.
 * Thuộc tính đối tượng: customer (Customer7), table (Table7),
 * staff (SaleStaff7 - nhân viên xác nhận, null khi khách tự đặt online).
 */
public class Reservation7 implements Serializable {
    private static final long serialVersionUID = 1L;

    /** Trạng thái phiếu mới đặt online, chờ nhân viên bán hàng xác nhận. */
    public static final String STATUS_PENDING = "pending";
    /** Trạng thái phiếu đã hủy (không chiếm bàn). */
    public static final String STATUS_CANCELLED = "cancelled";

    private int id;
    private Date createdTime;
    private Date bookingDate;
    private Time arrivalTime;
    private int numberOfGuests;
    private String note;
    private String status;
    private Customer7 customer;
    private Table7 table;
    private SaleStaff7 staff;

    public Reservation7() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Time getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Time arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public int getNumberOfGuests() {
        return numberOfGuests;
    }

    public void setNumberOfGuests(int numberOfGuests) {
        this.numberOfGuests = numberOfGuests;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Customer7 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer7 customer) {
        this.customer = customer;
    }

    public Table7 getTable() {
        return table;
    }

    public void setTable(Table7 table) {
        this.table = table;
    }

    public SaleStaff7 getStaff() {
        return staff;
    }

    public void setStaff(SaleStaff7 staff) {
        this.staff = staff;
    }
}
