import 'package:app_native_db/domain/entities/poliza_cost.dart';
import 'package:app_native_db/domain/entities/poliza_request.dart';
import 'package:app_native_db/domain/repositories/policy_repository.dart';

class CreatePolicyUseCase {
  final PolicyRepository repository;

  CreatePolicyUseCase(this.repository);

  Future<PolizaCost> call(PolizaRequest request) {
    return repository.createPolicy(request);
  }
}
