import 'package:app_native_db/presentation/organisms/poliza_form.dart';
import 'package:app_native_db/presentation/pages/historial_page.dart';
import 'package:flutter/material.dart';

class CrearPolizaPage extends StatelessWidget {
  const CrearPolizaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Póliza"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistorialPage()),
              );
            },
          )
        ],
      ),
      body: const PolizaForm(),
    );
  }
}
