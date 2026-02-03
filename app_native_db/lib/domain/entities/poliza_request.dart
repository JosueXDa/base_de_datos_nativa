class PolizaRequest {
  final String propietario;
  final int edadPropietario;
  final String modeloAuto;
  final double valorSeguroAuto;
  final int accidentes;

  PolizaRequest({
    required this.propietario,
    required this.edadPropietario,
    required this.modeloAuto,
    required this.valorSeguroAuto,
    required this.accidentes,
  });

  Map<String, dynamic> toJson() {
    return {
      'propietario': propietario,
      'edadPropietario': edadPropietario,
      'modeloAuto': modeloAuto,
      'valorSeguroAuto': valorSeguroAuto,
      'accidentes': accidentes,
    };
  }
}
