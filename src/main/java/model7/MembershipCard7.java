package model7;

import java.io.Serializable;
import java.util.Date;

/**
 * Lớp thực thể MembershipCard7 - thẻ thành viên của khách hàng.
 * Ánh xạ bảng tblMembershipCard7.
 */
public class MembershipCard7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String cardCode;
    private Date issueDate;
    private int points;

    public MembershipCard7() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCardCode() {
        return cardCode;
    }

    public void setCardCode(String cardCode) {
        this.cardCode = cardCode;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }
}
