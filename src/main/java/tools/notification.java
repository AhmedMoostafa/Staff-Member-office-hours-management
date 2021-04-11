package tools;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class notification {

    public  static int getNumberOfUnRead(String userName) throws SQLException {
        String x="true";
        Connection con ;
        ResultSet RS=null;

        con= Database.getConnection();
        Statement stmt = con.createStatement();
        RS = stmt.executeQuery("select count(*) from message where status=" + "'" + x + "' and toMember=" + "'" + userName + "'");
        RS.next();

        int count= RS.getInt(1);
        return count;

    }
}
