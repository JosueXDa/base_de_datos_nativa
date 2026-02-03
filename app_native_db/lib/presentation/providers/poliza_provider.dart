import 'dart:async'; // ⬅️ AGREGAR ESTA IMPORTACIÓN
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:app_native_db/data/datasources/poliza_remote_datasource.dart';
import 'package:app_native_db/data/repositories/poliza_repository_impl.dart';
import 'package:app_native_db/domain/entities/poliza.dart';
import 'package:app_native_db/domain/repositories/poliza_repository.dart';

// --- Dependency Injection Providers ---

// Provide http Client
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

// Provide Remote DataSource
final polizaRemoteDataSourceProvider = Provider<PolizaRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  return PolizaRemoteDataSourceImpl(client: client);
});

// Provide Repository
final polizaRepositoryProvider = Provider<PolizaRepository>((ref) {
  final dataSource = ref.watch(polizaRemoteDataSourceProvider);
  return PolizaRepositoryImpl(remoteDataSource: dataSource);
});

// --- Application Logic Providers ---

// Notifier to handle Policy Creation
final polizaCreationProvider = AsyncNotifierProvider.autoDispose<PolizaNotifier, double?>(
  PolizaNotifier.new,
);

// ⬇️ CAMBIAR AutoDisposeAsyncNotifier por AsyncNotifier
class PolizaNotifier extends AsyncNotifier<double?> {
  @override
  FutureOr<double?> build() {
    // Initial state is null
    return null;
  }

  Future<void> crearPoliza(Poliza poliza) async {
    final repository = ref.read(polizaRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await repository.crearPoliza(poliza);
      return result.costoTotal;
    });
  }
}

// FutureProvider to get History
final historialPolizasProvider = FutureProvider.autoDispose<List<Poliza>>((ref) async {
  final repository = ref.watch(polizaRepositoryProvider);
  return await repository.obtenerHistorial();
});