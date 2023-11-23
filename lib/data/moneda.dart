double obtenerTasaDeCambio(String monedaOrigen, String monedaDestino) {
  switch ("$monedaOrigen-$monedaDestino") {
    case "cop-dolar":
      return 1 / 4067.81;
    case "cop-euro":
      return 1 / 4428.38;
    case "dolar-cop":
      return 4067.81;
    case "dolar-euro":
      return 4067.81 / 4428.38;
    case "euro-cop":
      return 4428.38;
    case "euro-dolar":
      return 4428.38 / 4067.81;
    default:
      return 1; // Mismo tipo de moneda, tasa de cambio 1:1
  }
}

double convertirMoneda(double valor, String monedaActual, String monedaCambio) {
  double tasaDeCambio = obtenerTasaDeCambio(monedaActual, monedaCambio);
  double valorCambio = valor * tasaDeCambio;
  print('valor cambiado: $valorCambio');
  return valorCambio;
}
