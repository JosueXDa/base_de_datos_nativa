import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_native_db/data/models/poliza_model.dart';
import 'dart:io';

abstract class PolizaRemoteDataSource {
  Future<PolizaModel> crearPoliza(PolizaModel poliza);
  Future<List<PolizaModel>> obtenerHistorial();
}

class PolizaRemoteDataSourceImpl implements PolizaRemoteDataSource {
  final http.Client client;

  PolizaRemoteDataSourceImpl({required this.client});

  // Use 10.0.2.2 for Android Emulator, localhost for iOS Simulator
  String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000/api';
    }
    return 'http://localhost:3000/api';
  }

  @override
  Future<PolizaModel> crearPoliza(PolizaModel poliza) async {
    final response = await client.post(
      Uri.parse('$baseUrl/polizas'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(poliza.toJson()),
    );

    if (response.statusCode == 201) {
      return PolizaModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear póliza: ${response.statusCode}');
    }
  }

  @override
  Future<List<PolizaModel>> obtenerHistorial() async {
    final response = await client.get(Uri.parse('$baseUrl/polizas'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => PolizaModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener historial');
    }
  }
}
