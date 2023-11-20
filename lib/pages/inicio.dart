import 'package:flutter/material.dart';
import 'package:app/data/auth.dart';
import 'package:app/data/usuario.dart';
import 'package:app/data/usuarioService.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Usuario? _usuario; // Cambiamos a Usuario? para permitir un valor nulo

  @override
  void initState() {
    super.initState();
    // Inicializamos _usuario en initState utilizando una función asíncrona
    _inicializarUsuario();
  }

  Future<void> _inicializarUsuario() async {
    try {
      // Convertir el ID del usuario a String
      int idUsuario = autenticacion.idUsuario!;
      print('idusuario:${idUsuario}');
      final usuario = await usuarioService.obtenerUsuarioPorId(idUsuario);
      print('Usuario obteniso... ${usuario}');
      setState(() {
        _usuario = usuario;
      });
    } catch (error) {
      print('Error al obtener el usuario: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Verificamos si _usuario está inicializado antes de usarlo
    if (_usuario == null) {
      // Muestra un indicador de carga o maneja el caso cuando _usuario es nulo
      return CircularProgressIndicator(); // Puedes ajustar esto según tus necesidades
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://images.pexels.com/photos/9704348/pexels-photo-9704348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: fullBody(context),
      ),
    );
  }

  Widget fullBody(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(255, 255, 255, 0.2),
          ),
          child: InicioWidget(context),
        ),
      ),
    );
  }

  Widget InicioWidget(BuildContext context) {
    return Stack(children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Bienvenido",
              style: TextStyle(
                fontSize: 55,
              ),
            ),
            Text(
              _usuario!.nombre,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              width: 350,
              decoration: BoxDecoration(
                color: const Color.fromARGB(117, 248, 248, 248),
                borderRadius: BorderRadius.circular(70),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Su saldo actual es:',
                    style: TextStyle(fontSize: 35),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: const Color.fromARGB(117, 255, 255, 255),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.attach_money_outlined, size: 60),
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            _usuario!.saldo.toString(),
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Lógica para el primer botón
                  },
                  icon: const Icon(Icons.arrow_upward, size: 40),
                  label: const Text('Consignar'),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(16.0),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 133, 8, 8),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Lógica para el segundo botón
                  },
                  icon: const Icon(Icons.arrow_downward, size: 40),
                  label: const Text('Retirar'),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(8),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 16),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 133, 8, 8),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                // Lógica para el botón circular
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 3, 8, 56),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(50),
                elevation: 8,
              ),
              child: const Text(
                'Convertir',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      Positioned(
        top: 30,
        right: 5,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Cerrar sesión"),
                  content: const Text("¿Está seguro que desea Cerrar sesión?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        autenticacion.token = null;
                        autenticacion.idUsuario = null;
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      child: const Text("Si"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            padding: const EdgeInsets.all(10.0),
            backgroundColor: const Color.fromARGB(0, 133, 8, 8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.highlight_off,
                size: 55,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
