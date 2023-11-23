import 'dart:convert';
import 'package:app/data/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  Future<List<Usuario>> obtenerTodosLosUsuarios() async {
    final response = await http.get(
      Uri.parse('http://localhost:1337/api/users'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener todos los usuarios');
    }
  }

  Future<Usuario?> obtenerUsuarioPorId(int id) async {
    final response = await http.get(
      Uri.parse('http://localhost:1337/api/users/$id'),
    );
    print('respuestaaa ${response.body}');
    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener el usuario por ID. ${response.body}');
    }
  }

  Future<void> actualizarUsuario(
      int userId, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('http://localhost:1337/api/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el usuario');
    }
  }

  Future<bool> actualizarSaldoUsuario(int userId, double nuevoSaldo) async {
    final response = await http.put(
      Uri.parse('http://localhost:1337/api/users/$userId'),
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
      Uri.parse('http://localhost:1337/api/users/$userId'),
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

  Future<void> eliminarUsuario(int userId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:1337/api/users/$userId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el usuario');
    }
  }
}

UsuarioService usuarioService = UsuarioService();
