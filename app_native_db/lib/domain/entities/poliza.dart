class Poliza {
  final String propietario;
  final double valorAuto;
  final String modelo; // 'A', 'B', 'C'
  final String edadRango; // '18-23', '23-55', '55+'
  final int numAccidentes;
  final double? costoTotal;

  Poliza({
    required this.propietario,
    required this.valorAuto,
    required this.modelo,
    required this.edadRango,
    required this.numAccidentes,
    this.costoTotal,
  });
}
