import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:app_native_db/data/datasources/policy_remote_data_source.dart';
import 'package:app_native_db/data/repositories/policy_repository_impl.dart';
import 'package:app_native_db/domain/entities/poliza_cost.dart';
import 'package:app_native_db/domain/entities/poliza_request.dart';
import 'package:app_native_db/domain/use_cases/create_policy_use_case.dart';

part 'policy_provider.g.dart';

@riverpod
class PolicyNotifier extends _$PolicyNotifier {
  @override
  FutureOr<PolizaCost?> build() {
    return null;
  }

  Future<void> calculatePolicy({
    required String nombre,
    required int edad,
    required String modelo,
    required double valor,
    required int accidentes,
  }) async {
    state = const AsyncValue.loading();

    try {
      // Composition Root (Simplified for this exercise)
      final client = http.Client();
      final dataSource = PolicyRemoteDataSource(client);
      final repository = PolicyRepositoryImpl(dataSource);
      final createPolicyUseCase = CreatePolicyUseCase(repository);

      final request = PolizaRequest(
        propietario: nombre,
        edadPropietario: edad,
        modeloAuto: modelo,
        valorSeguroAuto: valor,
        accidentes: accidentes,
      );

      final result = await createPolicyUseCase(request);
      state = AsyncValue.data(result);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
