import 'package:app_native_db/domain/entities/poliza.dart';

abstract class PolizaRepository {
  Future<Poliza> crearPoliza(Poliza poliza);
  Future<List<Poliza>> obtenerHistorial();
}
