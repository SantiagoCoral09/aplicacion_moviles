import 'package:app/data/cuenta.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  final Cuenta? cuentaUsuario;
  const Inicio({Key? key, this.cuentaUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),

          // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 70),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://i.pinimg.com/236x/bb/ff/28/bbff28112f4c75cf11e37360ea0f24af.jpg"),
                  fit: BoxFit.fitHeight)),
          child: fullBody(context)),
    );
  }

  Widget fullBody(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            decoration: BoxDecoration(
                // color: const Color.fromRGBO(159, 201, 218, 25),
                borderRadius: BorderRadius.circular(10)),
            child: InicioWidget(context)),
      ),
    );
  }

  Widget InicioWidget(BuildContext context) {
    return Stack(
      children: [
        // Contenido principal de la pantalla
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                textAlign: TextAlign.center,
                "Bienvenido",
                style: TextStyle(
                  fontSize: 55,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "${cuentaUsuario?.email}",
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 180,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(117, 248, 248, 248),
                      borderRadius: BorderRadius.circular(70)),
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
                                // color: Color.fromARGB(117, 232, 249, 255),
                                padding: const EdgeInsets.all(15.0),
                                child: const Text("30000",
                                    style: TextStyle(fontSize: 40)),
                              )
                            ],
                          ),
                        )
                      ])),
              const SizedBox(height: 30),
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 133, 8, 8)),
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
                              horizontal: 25.0, vertical: 16)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 133, 8, 8)),
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
              // Botón en la parte inferior
              ElevatedButton(
                onPressed: () {
                  // Lógica para el botón circular
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 3, 8, 56),
                  shape: const CircleBorder(),
                  padding:
                      const EdgeInsets.all(50), // Color del texto del botón
                  elevation: 8, // Ajusta la altura de la sombra
                ),
                child: const Text(
                  'Convertir',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        // Botón en la esquina superior derecha
        Positioned(
            top: 30,
            right: 5,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(
                    8), // Ajusta la altura de la sombra
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        35.0), // Ajusta el radio para hacerlo circular
                  ),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(0, 133, 8, 8)),
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
              onPressed: () {
                //cerrrar sesion
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Cerrar sesión"),
                        content:
                            const Text("¿Está seguro que desea Cerrar sesión?"),
                        actions: [
                          //se muestran los 2 botones ya sea para confirmar o cancelar
                          TextButton(
                              onPressed: () {
                                //Se guarda false para saber que cerro sesion
                                // usuarioLogin.login = false;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Main(),
                                  ),
                                );
                              },
                              child: const Text("Si")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);

                                ///se regresa alos detalles de la tarea si presiona NO
                              },
                              child: const Text("No"))
                        ],
                      );
                    });
              },
            )),
      ],
    );
  }
}
