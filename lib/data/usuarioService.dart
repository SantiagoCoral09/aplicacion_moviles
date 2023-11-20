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

  Future<void> eliminarUsuario(int userId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:1337/api/users/$userId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el usuario');
    }
  }

  // Tal vez no sea necesaria...
  Future<bool> registrar(Usuario nuevoUser) async {
    final response = await http.post(
      Uri.parse('http://localhost:1337/api/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nuevoUser.nombre,
        'celular': nuevoUser.celular,
        'email': nuevoUser.email,
        'password': nuevoUser.password,
        'username': nuevoUser.email.split(
            '@')[0], // Utiliza la parte antes del símbolo @ como username
      }),
    );

    if (response.statusCode == 200) {
      // Registro exitoso
      return true;
    } else {
      // Error al registrar el usuario
      return false;
    }
  }
}

UsuarioService usuarioService = UsuarioService();
