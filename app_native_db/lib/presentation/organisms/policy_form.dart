import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_native_db/presentation/atoms/app_button.dart';
import 'package:app_native_db/presentation/atoms/app_input.dart';
import 'package:app_native_db/presentation/atoms/app_text.dart';
import 'package:app_native_db/presentation/molecules/radio_group.dart';
import 'package:app_native_db/presentation/providers/policy_provider.dart';

class PolicyForm extends ConsumerStatefulWidget {
  const PolicyForm({super.key});

  @override
  ConsumerState<PolicyForm> createState() => _PolicyFormState();
}

class _PolicyFormState extends ConsumerState<PolicyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _valorController = TextEditingController();
  final _accidentesController = TextEditingController();

  String _selectedModel = 'A';
  int _selectedAgeBase = 18; // Default to first range (18-23)

  @override
  void dispose() {
    _nombreController.dispose();
    _valorController.dispose();
    _accidentesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(policyNotifierProvider.notifier)
          .calculatePolicy(
            nombre: _nombreController.text,
            edad: _selectedAgeBase, // Use the base age of the selected range
            modelo: _selectedModel,
            valor: double.parse(_valorController.text),
            accidentes: int.parse(_accidentesController.text),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final policyState = ref.watch(policyNotifierProvider);

    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Propietario (Rounded Gray)
          AppInput(
            hint: 'Propietario',
            controller: _nombreController,
            validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
          ),

          // 2. Valor del seguro (Rounded Gray)
          AppInput(
            hint: 'Valor del seguro',
            controller: _valorController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Requerido';
              if (double.tryParse(v) == null) return 'Valor inválido';
              return null;
            },
          ),

          // 3. Modelo de auto (Radio Group)
          AppRadioGroup<String>(
            title: 'Modelo de auto:',
            groupValue: _selectedModel,
            onChanged: (val) => setState(() => _selectedModel = val!),
            options: [
              AppRadioOption(label: 'Modelo A', value: 'A'),
              AppRadioOption(label: 'Modelo B', value: 'B'),
              AppRadioOption(label: 'Modelo C', value: 'C'),
            ],
          ),

          // 4. Edad propietario (Radio Group with Ranges)
          AppRadioGroup<int>(
            title: 'Edad propietario:',
            groupValue: _selectedAgeBase,
            onChanged: (val) => setState(() => _selectedAgeBase = val!),
            options: [
              AppRadioOption(label: 'Mayor igual a 18 y menor a 24', value: 18),
              AppRadioOption(label: 'Mayor igual a 24 y menor a 53', value: 24),
              AppRadioOption(label: 'Mayor igual 53', value: 53),
            ],
          ),

          // 5. Número de accidentes (Rounded Gray)
          AppInput(
            hint: 'Número de accidentes',
            controller: _accidentesController,
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Requerido';
              if (int.tryParse(v) == null) return 'Valor inválido';
              return null;
            },
          ),

          const SizedBox(height: 16),
          AppButton(
            label: 'CREAR PÓLIZA',
            onPressed: _submit,
            isLoading: policyState.isLoading,
          ),

          if (policyState.hasError) ...[
            const SizedBox(height: 16),
            AppText.body('Error: ${policyState.error}'),
          ],
        ],
      ),
    );
  }
}
