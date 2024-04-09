
import javax.swing.*;
import java.sql.*;
import java.util.ArrayList;

public class SQLServerConnection {
  private Connection connection;
  private String tableName;
  private String[] attributes;

  public SQLServerConnection(String server, String bd, String user, String password) throws SQLException{
    String url = "jdbc:sqlserver://" + server + ":1433;database=" + bd
            + ";trustServerCertificate=true;loginTimeout=30";
    connection = DriverManager.getConnection(url, user, password);
    System.out.println("SQL Configuration connection established successfully");
  }
}
