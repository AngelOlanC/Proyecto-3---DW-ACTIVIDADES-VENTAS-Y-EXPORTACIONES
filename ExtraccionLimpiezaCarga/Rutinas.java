import java.util.Random;

public class Rutinas {
  private static double valorDivisaMXN(String paisOrigen) {
    return switch(paisOrigen) {
      case "Canada" -> 12.01;
      case "Usa" -> 16.44;
      case "South Korea" -> 0.012;
      case "Netherlands", "Spain", "Germany", "Italy" -> 17.63;
      case "China" -> 2.27;
      case "Japan" -> 0.11;
      case "Brazil" -> 3.23;
      case "Australia" -> 10.75;
      default -> 1;
    };
  }

  public static String convertirDivisaAMXN(String paisOrigen, double valor) {        
    double convertido = valor * valorDivisaMXN(paisOrigen);
    return String.format("%.4f", convertido);
  }

  public static String normalizarAtributo(String atributo) {
    atributo = atributo.trim().toLowerCase();
    StringBuilder cd = new StringBuilder(atributo);
    for (int i = 0; i < cd.length(); i++) {
      if (cd.charAt(i) == ' ') {
        cd.setCharAt(i + 1, Character.toUpperCase(cd.charAt(i + 1)));
      }
    }
    cd.setCharAt(0, Character.toUpperCase(cd.charAt(0)));
    return cd.toString();
  }

  public static String normalizarCiudad(String ciudad) {
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

  public static String normalizarEstado(String estado) {
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

  public static String getPaisOrigen(String marcaVehiculo) {
    return switch (marcaVehiculo) {
      case "Ford", "Dodge", "Chevrolet" -> "USA";
      case "Dina", "Vw" -> "Japan";
      default -> "??";
    };
  }

  public static String getModoDeTransporte(int year, String estado, int cnt) {
    return switch (year) {
      case 2020 -> esEstadoDelNorte(estado) ? "Road" : "Rail";
      case 2021 -> getMedioDeTransporteRandom();
      case 2022 -> getMedioDeTransporteEquilibrado(cnt);
      default -> "?";
    };
  }

  public static boolean esEstadoDelNorte(String estado) {
    return estado.equals("Baja California") || 
           estado.equals("Baja California Sur") || estado.equals("Sonora") || 
           estado.equals("Sinaloa") || estado.equals("Nuevo Leon") || 
           estado.equals("Coahuila") || estado.equals("Tamaulipas") || 
           estado.equals("Durango") || estado.equals("Chihuahua");
  }


  public static String getMedioDeTransporteRandom() {
    Random o = new Random();
    int i = o.nextInt(4);
    String[] medios = {"Road", "Sea", "Air", "Rail"};
    return medios[i];
  }
  
  public static String getMedioDeTransporteEquilibrado(Integer cnt) {
    String[] medios = {"Road", "Sea", "Air", "Rail"};
    String medio = medios[cnt];
    cnt = (cnt + 1) % 4;
    return medio;
  }

  public static String normalizarFecha(String fecha) {
    String[] separado = fecha.split("/");
    
    if (separado[0].length() == 1) {
      separado[0] = "0" + separado[0];
    }
    if (separado[1].length() == 1) {
      separado[1] = "0" + separado[1];
    }
    if (separado[2].length() == 2) {
      separado[2] = "20" + separado[2];
    }
    
    if (separado[1].equals("02") && Integer.parseInt(separado[0]) > 28) {
      separado[0] = "28";
    }

    if ((separado[1].equals("04") || separado[1].equals("06") || 
        separado[1].equals("09") || separado[1].equals("11")) && separado[0].equals("31")) {
          separado[0] = "30";
        }

    return separado[2] + separado[1] + separado[0];
  }

  public static String[] generarDestinoAleatoriamente() {
    String[] estados = {
      "Aguascalientes", "Baja California", "Baja California Sur", "Campeche",
      "Chiapas", "Chihuahua", "Coahuila", "Colima", "Durango", "Guanajuato",
      "Guerrero", "Hidalgo", "Jalisco", "Mexico", "Michoacan", "Morelos",
      "Nayarit", "Nuevo Leon", "Oaxaca", "Puebla", "Queretaro", "Quintana Roo",
      "San Luis Potosi", "Sinaloa", "Sonora", "Tabasco", "Tamaulipas",
      "Tlaxcala", "Veracruz", "Yucatan", "Zacatecas", "Ciudad de Mexico"
   };

    String[][] ciudades = {
      { "Aguascalientes", "Calvillo", "Jesus Maria", "Pabellon de Arteaga" },
      { "Mexicali", "Tijuana", "Ensenada", "Tecate" },
      { "La Paz", "Los Cabos", "Loreto", "Santa Rosalia" },
      { "San Francisco de Campeche", "Ciudad del Carmen", "Champoton", "Calkiní" },
      { "Tuxtla Gutierrez", "San Cristobal de las Casas", "Tapachula", "Comitan" },
      { "Chihuahua", "Ciudad Juarez", "Parral", "Cuauhtemoc" },
      { "Saltillo", "Torreon", "Monclova", "Piedras Negras" },
      { "Colima", "Manzanillo", "Tecoman", "Villa de Alvarez" },
      { "Victoria de Durango", "Gomez Palacio", "Lerdo", "Durango" },
      { "Guanajuato", "Leon", "Celaya", "Irapuato" },
      { "Chilpancingo de los Bravo", "Acapulco", "Iguala", "Taxco" },
      { "Pachuca de Soto", "Tulancingo", "Tizayuca", "Tepeapulco" },
      { "Guadalajara", "Zapopan", "Tlaquepaque", "Tlajomulco de Zuniga" },
      { "Toluca de Lerdo", "Ecatepec de Morelos", "Nezahualcoyotl", "Naucalpan de Juarez" },
      { "Morelia", "Uruapan", "Zamora", "Lázaro Cárdenas" },
      { "Cuernavaca", "Cuautla", "Jiutepec", "Temixco" },
      { "Tepic", "Xalisco", "Compostela", "Nayarit" },
      { "Monterrey", "Guadalupe", "San Nicolas de los Garza", "Apodaca" },
      { "Oaxaca de Juarez", "Santa Cruz Xoxocotlan", "San Bartolo Coyotepec", "Tlacolula" },
      { "Puebla de Zaragoza", "Cholula", "Tehuacan", "Atlixco" },
      { "Santiago de Queretaro", "Corregidora", "El Marques", "San Juan del Rio" },
      { "Chetumal", "Cancun", "Playa del Carmen", "Cozumel" },
      { "San Luis Potosi", "Soledad de Graciano Sanchez", "Matehuala", "Ciudad Valles" },
      { "Culiacan", "Mazatlan", "Los Mochis", "Guasave" },
      { "Hermosillo", "Nogales", "Ciudad Obregon", "Guaymas" },
      { "Villahermosa", "Cardenas", "Comalcalco", "Paraiso" },
      { "Ciudad Victoria", "Reynosa", "Matamoros", "Nuevo Laredo" },
      { "Tlaxcala de Xicohtencatl", "Apizaco", "Huamantla", "Calpulalpan" },
      { "Xalapa-Enriquez", "Veracruz", "Boca del Rio", "Orizaba" },
      { "Merida", "Valladolid", "Progreso", "Tizimin" },
      { "Zacatecas", "Guadalupe", "Fresnillo", "Jerez de Garcia Salinas" },
      { "Ciudad de Mexico", "Iztapalapa", "Gustavo A. Madero", "Venustiano Carranza" }
    };

    Random rnd = new Random();
    int i = rnd.nextInt(32), j = rnd.nextInt(3);

    String[] destino = {estados[i], ciudades[i][j]};
    return destino;
  }
  
	public static String corregirFecha(String fecha) {
		String[] separacion = fecha.split("/");
		String mesCorregido;
		switch (separacion[1]) {
			case "ene":
				mesCorregido = "01";
				break;
			case "feb":
				mesCorregido = "02";
				if (separacion[0].equals("31") || separacion[0].equals("30") || separacion[0].equals("29")) {
					separacion[0] = (Integer.parseInt(separacion[2]) % 4 == 0 ? "29" : "28");
				}
				break;
			case "mar":
				mesCorregido = "03";
				break;
			case "abr":
				mesCorregido = "04";
				separacion[0] = (separacion[0].equals("31") ? "30" : separacion[0]);
				break;
			case "may":
				mesCorregido = "05";
				break;
			case "jun":
				mesCorregido = "06";
				separacion[0] = (separacion[0].equals("31") ? "30" : separacion[0]);
				break;
			case "jul":
				mesCorregido = "07";
				break;
			case "ago":
				mesCorregido = "08";
				break;
			case "sep":
				mesCorregido = "09";
				separacion[0] = (separacion[0].equals("31") ? "30" : separacion[0]);
				break;
			case "oct":
				mesCorregido = "10";
				break;
			case "nov":
				mesCorregido = "11";
				separacion[0] = (separacion[0].equals("31") ? "30" : separacion[0]);
				break;
			case "dic":
				mesCorregido = "12";
				break;
			default:
				mesCorregido = "01";
				break;
		}
		return "20" + separacion[2] + "/" + mesCorregido + "/" + separacion[0];
	}
}