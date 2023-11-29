import 'dart:convert';
import 'package:app/data/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  // String url_api = 'http://localhost:1337';
  String url_api = 'https://cuenta-ahorros.onrender.com';

  Future<Usuario?> obtenerUsuarioPorId(int id) async {
    final response = await http.get(
      Uri.parse('$url_api/api/users/$id'),
    );
    print('respuestaaa ${response.body}');
    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener el usuario por ID. ${response.body}');
    }
  }

  Future<bool> actualizarSaldoUsuario(int userId, double nuevoSaldo) async {
    final response = await http.put(
      Uri.parse('$url_api/api/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'saldo': nuevoSaldo,
      }),
    );
    print('Respuestaa..  ${response.body}');
    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> actualizarMonedaUsuario(
      int userId, double nuevoSaldo, String moneda) async {
    final response = await http.put(
      Uri.parse('$url_api/api/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'saldo': nuevoSaldo,
        'moneda': moneda,
      }),
    );
    print('Respuestaa..  ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

UsuarioService usuarioService = UsuarioService();
