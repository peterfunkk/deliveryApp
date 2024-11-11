import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = "http://localhost:4001";
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: "token", value: data["token"]);
      return data;
    } else {
      throw Exception("Error en login");
    }
  }

  Future<Map<String, dynamic>> register(String username, String password, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user": username, "password": password, "email": email,}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await storage.write(key: "token", value: data["token"]);
      return data;
    } else {
      throw Exception("Error en login");
    }
  }

  Future<Map<String, dynamic>> getOrders() async {
    final token = await storage.read(key: "token");
    final response = await http.get(
      Uri.parse('$baseUrl/orders'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error obteniendo órdenes");
    }
  }



  // Agrega otros métodos para tus endpoints (registro, direcciones, etc.)
}


