import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Main {
  private static void ETLArchivo1(SQLServerConnection db, Connection conn) 
      throws FileNotFoundException, IOException, SQLException {
    Extractor extractor = new Extractor("ExtraccionLimpiezaCarga/Datos/ImportacionAutos111.csv");
    extractor.nextTuple();

    System.out.println("Extractor 1 creado");
    
    ResultSet rs = conn.createStatement().executeQuery("SELECT numero FROM Auxiliar.Cuenta2022");
    rs.next();
    Integer cnt = rs.getInt(1);

    String insertStatement = "INSERT INTO OLTP.Importaciones" +
                            "(estado, ciudad, marca, modelo, año, fecha, precio, medioDeTransporte, paisDeOrigen)" +
                              " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement ps = conn.prepareStatement(insertStatement);
    // ARCHIVO -> ESTADO,CIUDAD,MARCA,MODELO,AÑO,FECHA,PRECIO
    while (extractor.hasNextTuple()) {
      String tuple[] = extractor.nextTuple();
      for (int i = 0; i < tuple.length; i++) {
        tuple[i] = Rutinas.normalizarAtributo(tuple[i]);
      }
      String paisOrigen = Rutinas.getPaisOrigen(tuple[2]);
      String estadoNormalizado = Rutinas.normalizarEstado(tuple[0]);
      ps.setString(1, estadoNormalizado);
      ps.setString(2, Rutinas.normalizarCiudad(tuple[1]));
      ps.setString(3, tuple[2]);
      ps.setString(4, tuple[3]);
      ps.setString(5, tuple[4]);
      ps.setString(6, Rutinas.normalizarFecha(tuple[5]));
      ps.setString(7, Rutinas.convertirDivisaAMXN(paisOrigen, Double.parseDouble(tuple[6]))); 
      ps.setString(8, Rutinas.getModoDeTransporte(Integer.parseInt(tuple[4]), estadoNormalizado, cnt));
      ps.setString(9, paisOrigen);
      ps.executeUpdate();
    }
    conn.createStatement().executeUpdate("UPDATE Auxiliar.Cuenta2022 set numero = " + cnt);
    System.out.println("Terminamos con el archivo 1");
  }

  private static void ETLArchivo2(SQLServerConnection db, Connection conn) 
      throws FileNotFoundException, IOException, SQLException {
    Extractor extractor = new Extractor("ExtraccionLimpiezaCarga/Datos/synergy_logistics_database111.csv");
    extractor.nextTuple();
    
    System.out.println("Extractor 2 creado");

    ResultSet rs = conn.createStatement().executeQuery("SELECT numero FROM Auxiliar.Cuenta2022");
    rs.next();
  
    String insertStatement = "INSERT INTO OLTP.Importaciones" +
                            "(estado, ciudad, marca, modelo, año, fecha, precio, medioDeTransporte, paisDeOrigen)" +
                              " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement ps = conn.prepareStatement(insertStatement);
    // 1 - direction, 2 - origin, 3 - destination, 4 - year, 5 - date, 6 -product,
    // 7 - transport_mode, 8 - company_name, 9 - total_value
    while (extractor.hasNextTuple()) {
      String tuple[] = extractor.nextTuple();
      if (!tuple[3].equals("Mexico")) {
        continue;
      }

      for (int i = 0; i < tuple.length; i++) {
        tuple[i] = Rutinas.normalizarAtributo(tuple[i]);
      }
  
      String[] destino = Rutinas.generarDestinoAleatoriamente();
      ps.setString(1, destino[0]);
      ps.setString(2, destino[1]);
      ps.setString(3, tuple[8]);
      ps.setString(4, tuple[6]);
      ps.setString(5, tuple[4]);
      ps.setString(6, Rutinas.normalizarFecha(tuple[5]));
      ps.setString(7, Rutinas.convertirDivisaAMXN(tuple[2], Double.parseDouble(tuple[9]))); 
      ps.setString(8, tuple[7]);
      ps.setString(9, tuple[2]);
      ps.executeUpdate();
    }
    System.out.println("Terminamos con el archivo 2");
  }

  public static void main(String[] args) {
    SQLServerConnection db;
    Connection conn;
    try {
      db = new SQLServerConnection("localhost", "Importaciones", "sa", "Aa252328");
      conn = db.getConnection();
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return;
    }

    db.beginTran();
    System.out.println("Se inicia la transaccion");
    
    try {
      ETLArchivo1(db, conn);
      ETLArchivo2(db, conn);
      db.commitTran();
      System.out.println("COMMIT");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      System.out.println("Rollback");
      db.rollbackTran();
    }
  }
}