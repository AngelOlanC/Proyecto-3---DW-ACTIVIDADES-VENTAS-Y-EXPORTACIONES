import java.util.HashSet;

public class Main {
  private static String normalizarCiudad(String ciudad) {
    StringBuilder cd = new StringBuilder(ciudad);
    for (int i = 0; i < cd.length(); i++) {
      if (cd.charAt(i) == ' ') {
        cd.setCharAt(i + 1, Character.toUpperCase(cd.charAt(i + 1)));
      }
    }
    cd.setCharAt(0, Character.toUpperCase(cd.charAt(0)));

    ciudad = cd.toString();
    return switch (ciudad) {
      case "Mztl" -> "Mazatlan";
      case "Cln" -> "Culiacan";
      case "Chi" -> "Chiapas";
      case "Gve" -> "Guasave";
      case "Ixtlan Dle Rio" -> "Ixtlan Del Rio";
      case "Cd. Guzman" -> "Ciudad Guzman";
      default -> ciudad;
    };
  }

  private static String normalizarEstado(String estado) {
    estado = Character.toUpperCase(estado.charAt(0)) + estado.substring(1);
    return switch (estado) {
      case "Dur" -> "Durango";
      case "Bc" -> "Baja California";
      case "Bcs" -> "Baja California Sur";
      case "Son" -> "Sonora";
      case "Sin" -> "Sinaloa";
      case "Nay" -> "Nayarit";
      case "Chi" -> "Chiapas";
      case "Nl" -> "Nuevo Leon";
      default -> estado;
    };
  }

  private static String getPaisOrigen(String marcaVehiculo) {
    return switch (marcaVehiculo) {
      case "ford", "dodge", "chevrolet" -> "USA";
      case "dina", "vw" -> "Japon";
      default -> "Externo";
    };
  }

  public static void main(String[] args) {
    try {
      SQLServerConnection db = new SQLServerConnection("localhost", "Importaciones", "sa", "Aa252328");
      Extractor extractor = new Extractor("ExtraccionLimpiezaCarga/Datos/ImportacionAutos111.csv");
      extractor.nextTuple();
      
      // ESTADO,CIUDAD,MARCA,MODELO,AÑO,FECHA,PRECIO

      HashSet<String> hs = new HashSet<>();
      while (extractor.hasNextTuple()) {
        String tuple[] = extractor.nextTuple();
        for (String attribute : tuple) {
          attribute = attribute.trim().toLowerCase();
        }
        // meter tupla
      }
    } catch (Exception e) {
      System.out.println(e.getMessage());
    }
  }
}