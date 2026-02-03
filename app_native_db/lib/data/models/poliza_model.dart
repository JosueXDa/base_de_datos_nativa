import 'package:app_native_db/domain/entities/poliza.dart';

class PolizaModel extends Poliza {
  PolizaModel({
    required super.propietario,
    required super.valorAuto,
    required super.modelo,
    required super.edadRango,
    required super.numAccidentes,
    super.costoTotal,
  });

  factory PolizaModel.fromJson(Map<String, dynamic> json) {
    return PolizaModel(
      // Evitamos null en strings
      propietario: json['propietario'] ?? '',

      // --- CORRECCIÓN CLAVE AQUÍ ---
      // 1. Buscamos la llave 'valor_auto' O 'valorAuto'.
      // 2. Usamos .toString() para convertir lo que llegue (sea int o string) a texto.
      // 3. Usamos tryParse para convertirlo a double de forma segura.
      valorAuto: double.tryParse((json['valor_auto'] ?? json['valorAuto']).toString()) ?? 0.0,

      modelo: json['modelo'] ?? 'A',

      edadRango: json['edad_rango'] ?? json['edadRango'] ?? '',

      // Manejo seguro de enteros (por si el backend manda "3" como string)
      numAccidentes: int.tryParse((json['accidentes'] ?? json['numAccidentes']).toString()) ?? 0,

      // --- MANEJO DE COSTO TOTAL ---
      // Verificamos si existe alguno de los dos keys, si sí, parseamos seguro.
      costoTotal: (json['costo_total'] ?? json['costoTotal']) != null
          ? double.tryParse((json['costo_total'] ?? json['costoTotal']).toString())
          : null,
    );
  }

  @override // Es buena práctica marcar override
  Map<String, dynamic> toJson() {
    return {
      'propietario': propietario,
      'valorAuto': valorAuto,       // Se envía como double (no uses .toString() aquí)
      'modelo': modelo,
      'edadRango': edadRango,
      'numAccidentes': numAccidentes, // Se envía como int
      // No enviamos costoTotal porque eso lo calcula el backend
    };
  }

  factory PolizaModel.fromEntity(Poliza poliza) {
    return PolizaModel(
      propietario: poliza.propietario,
      valorAuto: poliza.valorAuto,
      modelo: poliza.modelo,
      edadRango: poliza.edadRango,
      numAccidentes: poliza.numAccidentes,
      costoTotal: poliza.costoTotal,
    );
  }
}
