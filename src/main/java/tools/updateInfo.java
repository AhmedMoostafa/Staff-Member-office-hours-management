package tools;

import java.sql.*;

public class updateInfo {

    public  static member update(String name,String email,String password,String user) throws SQLException {
        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        boolean flag=true;
        member person=new member();
        Con = Database.getConnection();
        Stmt = Con.createStatement();
        System.out.println(email);
        RS = Stmt.executeQuery("SELECT userName FROM member where  email="+ "'" + email + "'");
        System.out.println(name+"  "+email+" "+password+" "+user);
        if(RS.isBeforeFirst()){
            while(RS.next())
            {
                if(user.equals(RS.getString("userName")))
                {
                    System.out.println("1");

                    flag=true;
                }
                else
                {   flag=  false;
                }
            }

        }
        else {

            flag=  true;

        }
            if(flag==true)
            {

                person.name=name;
                person.password=password;
                person.email=email;
                String sql4 = "UPDATE member SET name =?,password=?,email=? WHERE  userName='"+user+"';";
                PreparedStatement ps1 = Con.prepareStatement(sql4);
                ps1.setString(1, name);
                ps1.setString(2, password);
                ps1.setString(3, email);
                int y=  ps1.executeUpdate();
                return person;
            }
            else
            {

                return  null;
            }



    }
}
