
package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    private static final String DRIVER =
            "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    private static final String URL =
            "jdbc:sqlserver://localhost:1433;"
                    + "databaseName=ComputerStoreEnterpriseDB;"
                    + "encrypt=true;"
                    + "trustServerCertificate=true;";

    private static final String USER = "sa";
    private static final String PASSWORD = "0948557931Vn@";

    public static Connection getConnection() throws Exception {

        Class.forName(DRIVER);

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }

    public static void main(String[] args) {

        try {

            Connection con = getConnection();

            if (con != null) {
                System.out.println("Kết nối thành công!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
