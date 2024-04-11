
import java.sql.*;

public class SQLServerConnection {
  private Connection connection;

  public SQLServerConnection(String server, String bd, String user, String password) throws SQLException{
    String url = "jdbc:sqlserver://" + server + ":1433;database=" + bd
            + ";trustServerCertificate=true;loginTimeout=30";
    connection = DriverManager.getConnection(url, user, password);
    System.out.println("SQL Configuration connection established successfully");
  }

  public Connection getConnection() {
    return connection;
  }

  public boolean beginTran() {
    try {
      connection.createStatement().execute("BEGIN TRAN");
      return true;
    } catch(SQLException e) {
      return false;
    } 
  }

  public boolean commitTran() {
    try {
      connection.createStatement().execute("COMMIT TRAN");
      return true;
    } catch(SQLException e) {
      return false;
    }
  }

  public boolean rollbackTran() {
    try {
      connection.createStatement().execute("ROLLBACK TRAN");
      return true;
    } catch(SQLException e) {
      return false;
    }
  }
}
