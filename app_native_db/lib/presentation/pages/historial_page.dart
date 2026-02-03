import 'package:app_native_db/presentation/providers/poliza_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistorialPage extends ConsumerWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialAsync = ref.watch(historialPolizasProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Pólizas")),
      body: historialAsync.when(
        data: (polizas) {
          if (polizas.isEmpty) {
            return const Center(child: Text("No hay pólizas registradas"));
          }
          return ListView.builder(
            itemCount: polizas.length,
            itemBuilder: (context, index) {
              final p = polizas[index];
              return ListTile(
                title: Text(p.propietario),
                subtitle: Text("Modelo: ${p.modelo} | Edad: ${p.edadRango}"),
                trailing: Text("\$${p.costoTotal?.toStringAsFixed(2) ?? '0.00'}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              );
            },
          );
        },
        error: (err, stack) => Center(child: Text("Error: $err")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
