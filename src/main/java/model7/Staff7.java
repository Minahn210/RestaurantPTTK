package model7;

/**
 * Lớp thực thể Staff7 (lớp trừu tượng) - nhân viên, kế thừa Member7.
 * Ánh xạ bảng tblStaff7 (khóa chính tblMember7id).
 */
public abstract class Staff7 extends Member7 {
    private static final long serialVersionUID = 1L;

    private String position;

    public Staff7() {
        super();
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
