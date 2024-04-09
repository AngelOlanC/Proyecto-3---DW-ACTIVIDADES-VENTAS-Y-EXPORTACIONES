import java.util.ArrayList;
import java.util.HashSet;
import java.util.Random;

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

  private static String getModoDeTransporte(int year, String estado) {
    return switch (year) {
      case 2020 -> esEstadoDelNorte(estado) ? "Carretera" : "Tren";
      case 2021 -> getMedioDeTransporteRandom();
      case 2022 -> "a";
      default -> "Externo";
    };
  }

  private static boolean esEstadoDelNorte(String estado) {
    return estado.equals("Baja California") || 
           estado.equals("Baja California Sur") || estado.equals("Sonora") || 
           estado.equals("Sinaloa") || estado.equals("Nuevo Leon") || 
           estado.equals("Coahuila") || estado.equals("Tamaulipas") || 
           estado.equals("Durango") || estado.equals("Chihuahua");
  }

  private static String getMedioDeTransporteRandom() {
    Random o = new Random();
    int random = o.nextInt(4);
    return switch (random) {
      case 0 -> "Carretera";
      case 1 -> "Maritimo";
      case 2 -> "Aereo";
      case 3 -> "Tren";
      default -> "?";
    };
  }


  public static void main(String[] args) {
    try {
      SQLServerConnection db = new SQLServerConnection("localhost", "Importaciones", "sa", "Aa252328");

      // ARCHIVO 1
      Extractor extractor = new Extractor("ExtraccionLimpiezaCarga/Datos/ImportacionAutos111.csv");
      extractor.nextTuple();
      
      // ESTADO,CIUDAD,MARCA,MODELO,AÑO,FECHA,PRECIO

      int cnt = 0;
      HashSet<String> hs = new HashSet<>();
      while (extractor.hasNextTuple()) {
        String tuple[] = extractor.nextTuple();
        for (String attribute : tuple) {
          attribute = attribute.trim().toLowerCase();
        }
        if (tuple[tuple.length - 2].contains("2022")) {
          cnt++; // 1665889 y faltan de contar las del segundo archivo 
        }
        // meter tupla
      }
      System.out.println(cnt);

      // ARCHIVO 2
    } catch (Exception e) {
      System.out.println(e.getMessage());
    }
  }
}