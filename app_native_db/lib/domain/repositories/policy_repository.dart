import 'package:app_native_db/domain/entities/poliza_cost.dart';
import 'package:app_native_db/domain/entities/poliza_request.dart';

abstract class PolicyRepository {
  Future<PolizaCost> createPolicy(PolizaRequest request);
}
