import 'package:app_native_db/domain/entities/poliza.dart';
import 'package:app_native_db/presentation/atoms/custom_text_field.dart';
import 'package:app_native_db/presentation/molecules/radio_selector.dart';
import 'package:app_native_db/presentation/providers/poliza_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PolizaForm extends ConsumerStatefulWidget {
  const PolizaForm({super.key});

  @override
  ConsumerState<PolizaForm> createState() => _PolizaFormState();
}

class _PolizaFormState extends ConsumerState<PolizaForm> {
  final _nombreCtrl = TextEditingController();
  final _valorCtrl = TextEditingController();
  final _accidentesCtrl = TextEditingController();
  String _modeloSel = 'A';
  String _edadSel = '18-23';

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _valorCtrl.dispose();
    _accidentesCtrl.dispose();
    super.dispose();
  }

  void _enviar() {
    // Basic validation
    if (_nombreCtrl.text.isEmpty || _valorCtrl.text.isEmpty || _accidentesCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor llena todos los campos')));
      return;
    }

    final poliza = Poliza(
      propietario: _nombreCtrl.text,
      valorAuto: double.tryParse(_valorCtrl.text) ?? 0,
      modelo: _modeloSel,
      edadRango: _edadSel,
      numAccidentes: int.tryParse(_accidentesCtrl.text) ?? 0,
    );
    ref.read(polizaCreationProvider.notifier).crearPoliza(poliza);
  }

  @override
  Widget build(BuildContext context) {
    final estadoPoliza = ref.watch(polizaCreationProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(controller: _nombreCtrl, label: "Propietario"),
          CustomTextField(controller: _valorCtrl, label: "Valor del auto", isNumber: true),

          RadioSelector<String>(
            title: "Modelo de auto:",
            groupValue: _modeloSel,
            options: [
              RadioOption(label: "Modelo A", value: "A"),
              RadioOption(label: "Modelo B", value: "B"),
              RadioOption(label: "Modelo C", value: "C"),
            ],
            onChanged: (v) => setState(() => _modeloSel = v!),
          ),

          RadioSelector<String>(
            title: "Edad propietario:",
            groupValue: _edadSel,
            options: [
              RadioOption(label: "18 a 23 años", value: "18-23"),
              RadioOption(label: "23 a 55 años", value: "23-55"),
              RadioOption(label: "Mayor de 55 años", value: "55+"),
            ],
            onChanged: (v) => setState(() => _edadSel = v!),
          ),

          CustomTextField(controller: _accidentesCtrl, label: "Número de accidentes", isNumber: true),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: estadoPoliza.isLoading ? null : _enviar,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: estadoPoliza.isLoading
                ? const CircularProgressIndicator()
                : const Text("CREAR PÓLIZA"),
          ),

          const SizedBox(height: 20),

          estadoPoliza.when(
            data: (costo) => costo != null
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Column(
                      children: [
                        const Text("Costo Total Calculado", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("\$${costo.toStringAsFixed(2)}", style: const TextStyle(fontSize: 24, color: Colors.green)),
                      ],
                    ),
                  )
                : const SizedBox(),
            error: (err, _) => Container(
              padding: const EdgeInsets.all(16),
              color: Colors.red[100],
              child: Text("Error: $err", style: const TextStyle(color: Colors.red)),
            ),
            loading: () => const SizedBox(),
          ),
        ],
      ),
    );
  }
}
