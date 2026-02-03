import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_native_db/data/models/poliza_cost_model.dart';
import 'package:app_native_db/domain/entities/poliza_request.dart';

class PolicyRemoteDataSource {
  final http.Client client;

  PolicyRemoteDataSource(this.client);

  Future<PolizaCostModel> createPolicy(PolizaRequest request) async {
    final response = await client.post(
      Uri.parse('http://192.168.18.189:9090/bdd_dto/api/poliza'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PolizaCostModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create policy: ${response.statusCode}');
    }
  }
}
