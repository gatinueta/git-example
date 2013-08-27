

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class TestJdbc {
    private static Connection connect() throws Exception {
        String jdbcURL = "jdbc:oracle:thin:@localhost:1521:DUPLEX11";
        String user = "DUC" ;
        String passwd ="CU3";

        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
        return DriverManager.getConnection(jdbcURL,user,passwd);
    }
    
    public static void main(String[] args) throws Exception {
        Connection conn = connect();
        PreparedStatement stServer = conn.prepareStatement("SELECT 'server' FROM DUAL@PST_SERVER");
        PreparedStatement stClient = conn.prepareStatement("SELECT 'client' FROM DUAL");
        PreparedStatement stClose = conn.prepareStatement("ALTER SESSION CLOSE DATABASE LINK PST_SERVER");
        ResultSet resultSet;
        
        try {
            stServer.execute();
            resultSet = stServer.getResultSet();
            if (resultSet.next()) {
                System.out.println("server: " + resultSet.getString(1));
            }
        } catch (SQLException e) {
            System.out.println("exception on server link: " + e);
            stClose.execute();
            System.out.println("server link closed.");
        }
        BufferedReader lineOfText = new BufferedReader(new InputStreamReader(System.in));
        lineOfText.readLine();
        
        try {
            stServer.execute();
            resultSet = stServer.getResultSet();
            if (resultSet.next()) {
                System.out.println("server: " + resultSet.getString(1));
            }
        } catch (SQLException e) {
            System.out.println("exception on server link: " + e);
            stClose.execute();
            System.out.println("server link closed.");
        }
        lineOfText.readLine();
        
        try {
            stClient.execute();
            resultSet = stClient.getResultSet();
            if (resultSet.next()) {
                System.out.println("client: " + resultSet.getString(1));
            }
        } catch (SQLException e) {
            System.out.println("exception on client connection: " + e);
        }
        
        stServer.close();
        stClient.close();
    }
    
}
