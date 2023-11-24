import 'package:app/pages/consignar.dart';
import 'package:app/pages/convertir.dart';
import 'package:app/pages/retirar.dart';
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
      int idUsuario = autenticacion.idUsuario!;
      print('idusuario:${idUsuario}');

      final usuario = await usuarioService.obtenerUsuarioPorId(idUsuario);
      print('Usuario obtenido... ${usuario}');
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
      // Muestra un indicador de carga
      return CircularProgressIndicator();
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
      ),
    );
  }

  Widget fullBody(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Color.fromARGB(120, 255, 255, 255),
          ),
          child: InicioWidget(context),
        ),
      ),
    );
  }

  Widget InicioWidget(BuildContext context) {
    return Stack(children: [
      Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Bienvenido",
            style: TextStyle(
              fontSize: 50,
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
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            padding: EdgeInsets.only(top: 15, bottom: 15),

            // constraints: BoxConstraints(
            //     maxWidth: MediaQuery.of(context).size.width * 0.8),
            height: 180,
            width: 400,
            decoration: BoxDecoration(
              color: const Color.fromARGB(117, 255, 255, 255),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Su saldo actual es:',
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
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
                          _usuario!.saldo.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  _usuario!.moneda == 'cop'
                      ? 'COP'
                      : _usuario!.moneda == 'euro'
                          ? 'Euros'
                          : 'Dólares',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Consignar(usuario: _usuario),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_upward, size: 35),
                label: const Text('Consignar'),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
                width: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Retirar(usuario: _usuario),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_downward, size: 35),
                label: const Text('Retirar'),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(8),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
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
          const Divider(),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Convertir(usuario: _usuario),
                ),
              );
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
      Positioned(
        top: 5,
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
              borderRadius: BorderRadius.circular(50.0),
            ),
            padding: const EdgeInsets.all(5.0),
            backgroundColor: const Color.fromARGB(0, 133, 8, 8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.highlight_off,
                size: 40,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
