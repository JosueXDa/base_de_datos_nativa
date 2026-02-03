import 'package:app_native_db/data/datasources/policy_remote_data_source.dart';
import 'package:app_native_db/domain/entities/poliza_cost.dart';
import 'package:app_native_db/domain/entities/poliza_request.dart';
import 'package:app_native_db/domain/repositories/policy_repository.dart';

class PolicyRepositoryImpl implements PolicyRepository {
  final PolicyRemoteDataSource remoteDataSource;

  PolicyRepositoryImpl(this.remoteDataSource);

  @override
  Future<PolizaCost> createPolicy(PolizaRequest request) async {
    return await remoteDataSource.createPolicy(request);
  }
}
