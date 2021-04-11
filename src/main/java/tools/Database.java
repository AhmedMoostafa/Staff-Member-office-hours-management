package tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

    private static String url = "jdbc:mysql://localhost:3306/classmanagement";
    private static String username = "root";
    private static String password = "root";
    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }



    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

}