import 'package:app_native_db/data/datasources/poliza_remote_datasource.dart';
import 'package:app_native_db/data/models/poliza_model.dart';
import 'package:app_native_db/domain/entities/poliza.dart';
import 'package:app_native_db/domain/repositories/poliza_repository.dart';

class PolizaRepositoryImpl implements PolizaRepository {
  final PolizaRemoteDataSource remoteDataSource;

  PolizaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Poliza> crearPoliza(Poliza poliza) async {
    final polizaModel = PolizaModel.fromEntity(poliza);
    return await remoteDataSource.crearPoliza(polizaModel);
  }

  @override
  Future<List<Poliza>> obtenerHistorial() async {
    return await remoteDataSource.obtenerHistorial();
  }
}
