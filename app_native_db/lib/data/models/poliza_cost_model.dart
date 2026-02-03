import 'package:app_native_db/domain/entities/poliza_cost.dart';

class PolizaCostModel extends PolizaCost {
  PolizaCostModel({
    required super.propietario,
    required super.modeloAuto,
    required super.valorSeguroAuto,
    required super.edadPropietario,
    required super.accidentes,
    required super.costoTotal,
  });

  factory PolizaCostModel.fromJson(Map<String, dynamic> json) {
    return PolizaCostModel(
      propietario: json['propietario'],
      modeloAuto: json['modeloAuto'],
      valorSeguroAuto: (json['valorSeguroAuto'] as num).toDouble(),
      edadPropietario: json['edadPropietario'],
      accidentes: json['accidentes'],
      costoTotal: (json['costoTotal'] as num).toDouble(),
    );
  }
}
