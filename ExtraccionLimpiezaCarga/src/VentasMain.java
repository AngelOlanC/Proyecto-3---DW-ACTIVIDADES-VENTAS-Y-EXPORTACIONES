import java.io.FileNotFoundException;
import java.io.IOError;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class VentasMain {
  private static void insertarRegistros(SQLServerConnection db) 
      throws SQLException, FileNotFoundException, IOException {
    Extractor extractorTicketH = new Extractor("ExtraccionLimpiezaCarga/Datos/TicketH.csv");
    extractorTicketH.nextTuple();
    String query = "INSERT INTO OLTP.TicketsH VALUES (?,?,?,?,?,?)";
    PreparedStatement st;
    Connection conexion = db.getConnection();
    
    st = conexion.prepareStatement(query);
      
    System.out.println("Empezamos con TicketsH");
    while (extractorTicketH.hasNextTuple()) {
      String[] tupla = extractorTicketH.nextTuple();
      tupla[1] = Rutinas.corregirFecha(tupla[1]);
      for (int i = 0; i < 6; i++) {
        st.setString(i + 1, tupla[i]);
      }
      st.executeUpdate();
    }
    
    Extractor extractorTicketD = new Extractor("ExtraccionLimpiezaCarga/Datos/TicketD.csv");
    extractorTicketD.nextTuple();

    query = "IF EXISTS(SELECT TICKET FROM OLTP.TICKETSD WHERE TICKET = ? AND producto = ?) " +
            "UPDATE OLTP.TICKETSD SET UNIDADES = UNIDADES + ? WHERE TICKET = ? AND producto = ? " +
            "ELSE " +
            "INSERT INTO OLTP.TICKETSD VALUES(?,?,?,?)";
    
    st = conexion.prepareStatement(query);
    System.out.println("Empezamos con TicketsD");
    while (extractorTicketD.hasNextTuple()) {
      String[] tupla = extractorTicketD.nextTuple();
      for (int i = 0; i < 5; i++) {
        tupla[i] = Rutinas.limpiarCampo(tupla[i]);
      }
      tupla[3] = String.valueOf(Integer.parseInt(tupla[4]) / Integer.parseInt(tupla[2]));
      
      st.setString(1, tupla[0]);
      st.setString(2, tupla[1]);
      st.setString(3, tupla[2]);
      st.setString(4, tupla[0]);
      st.setString(5, tupla[1]);
      for (int i = 0; i < 4; i++) {
        st.setString(i + 6, tupla[i]);
      }
      st.executeUpdate();
    }
}
  public static void main(String[] args) {
    SQLServerConnection db;
    Connection conn;
    try {
      db = new SQLServerConnection("localhost", "Proyecto", "sa", "Aa252328");
      conn = db.getConnection();
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return;
    }

    db.beginTran();

    try {
      insertarRegistros(db);
      db.commitTran();
      System.out.println("COMMIT");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      System.out.println("Rollback");
      db.rollbackTran();
    }
  }
}
