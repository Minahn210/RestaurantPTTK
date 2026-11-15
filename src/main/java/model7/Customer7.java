package model7;

import java.io.Serializable;

/**
 * Lớp thực thể Customer7 - khách hàng. Ánh xạ bảng tblCustomer7.
 * Thuộc tính đối tượng card: MembershipCard7 (có thể null nếu khách chưa có thẻ).
 */
public class Customer7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String fullName;
    private String phone;
    private String email;
    private String address;
    private String note;
    private MembershipCard7 card;

    public Customer7() {
    }

    public Customer7(String fullName, String phone, String email, String address, String note) {
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public MembershipCard7 getCard() {
        return card;
    }

    public void setCard(MembershipCard7 card) {
        this.card = card;
    }
}
