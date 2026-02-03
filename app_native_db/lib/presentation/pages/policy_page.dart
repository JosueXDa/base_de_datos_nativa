import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_native_db/presentation/atoms/app_text.dart';
import 'package:app_native_db/presentation/organisms/policy_form.dart';
import 'package:app_native_db/presentation/providers/policy_provider.dart';

class PolicyPage extends ConsumerWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyState = ref.watch(policyNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear Póliza',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const PolicyForm(),
            if (policyState.value != null) ...[
              const Divider(height: 48, thickness: 2),
              AppText.title('Resultado de la Póliza'),
              const SizedBox(height: 16),
              _ResultRow('Propietario:', policyState.value!.propietario),
              _ResultRow('Modelo:', policyState.value!.modeloAuto),
              _ResultRow(
                'Costo Total:',
                '\$${policyState.value!.costoTotal.toStringAsFixed(2)}',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;

  const _ResultRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [AppText.body(label), AppText.label(value)],
      ),
    );
  }
}
