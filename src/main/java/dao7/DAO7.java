package dao7;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp DAO7 - lớp cha của mọi lớp DAO, giữ kết nối CSDL dùng chung (con: Connection).
 *
 * Mặc định kết nối MySQL: jdbc:mysql://localhost:3306/restaurant7_db, tài khoản root / 123456.
 * Có thể đổi mà không sửa code bằng tham số JVM khi chạy Tomcat, ví dụ:
 *   -Ddb7.url=jdbc:mysql://localhost:3306/restaurant7_db?... -Ddb7.user=root -Ddb7.password=matkhau
 */
public class DAO7 {
    private static final String DEFAULT_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/restaurant7_db"
            + "?useUnicode=true&characterEncoding=UTF-8&useSSL=false"
            + "&serverTimezone=Asia/Ho_Chi_Minh&allowPublicKeyRetrieval=true";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "123456";

    protected static Connection con;

    public DAO7() {
        openConnection();
    }

    private static synchronized void openConnection() {
        try {
            if (con != null && !con.isClosed() && con.isValid(2)) {
                return;
            }
            Class.forName(System.getProperty("db7.driver", DEFAULT_DRIVER));
            con = DriverManager.getConnection(
                    System.getProperty("db7.url", DEFAULT_URL),
                    System.getProperty("db7.user", DEFAULT_USER),
                    System.getProperty("db7.password", DEFAULT_PASSWORD));
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("Không tìm thấy JDBC driver. Hãy chép mysql-connector-java vào WEB-INF/lib.", e);
        } catch (SQLException e) {
            throw new IllegalStateException("Không kết nối được CSDL restaurant7_db: " + e.getMessage(), e);
        }
    }
}
