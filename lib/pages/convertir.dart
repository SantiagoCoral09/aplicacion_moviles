import 'package:app/data/moneda.dart';
import 'package:app/data/usuario.dart';
import 'package:app/data/usuarioService.dart';
import 'package:app/pages/inicio.dart';
import 'package:flutter/material.dart';

String? monedaSeleccionada; // Servira para el desplegable de moneda

///son los valores para los tipos de moneda
List<String> opcionesMoneda = ['cop', 'dolar', 'euro'];

class Convertir extends StatelessWidget {
  final Usuario? usuario;

  Convertir({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    "https://images.pexels.com/photos/9704348/pexels-photo-9704348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  ),
                  fit: BoxFit.cover)),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              height: 250,
              // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(120, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Convertir",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: DropdownButtonFormField<String>(
                            value: monedaSeleccionada,
                            items: opcionesMoneda.map((String moneda) {
                              ///se recorre los items de la lista de monedas para mostrarlos en el desplegable
                              return DropdownMenuItem<String>(
                                //menu desplegable para las monedaes
                                value: moneda,
                                child: Text(
                                  moneda == 'cop'
                                      ? 'Pesos colombianos'
                                      : moneda == 'euro'
                                          ? 'Euros'
                                          : 'Dólares',
                                  style: const TextStyle(
                                    // color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              ///al seleccionar un item se actualiza el valor de la variable para guardar
                              monedaSeleccionada = newValue;
                              // print(monedaSeleccionada);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Seleccione la moneda'; // Mensaje de validación en caso que no haya seleccionado una moneda
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                                labelText: "Elija el tipo de moneda:",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 4, 0, 43)),
                                fillColor: Color.fromARGB(230, 255, 255, 255),
                                filled: true),
                          ),
                        )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                            child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(8),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 15),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 21, 54, 114))),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Confirmar')
                            ],
                          ),
                          onPressed: () async {
                            if (monedaSeleccionada == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Seleccione una moneda a cambiar',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              try {
                                int idUsuario = usuario!.id!;
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Confirmar moneda a Convertir"),
                                        content:
                                            Text(monedaSeleccionada == 'cop'
                                                ? 'Pesos colombianos'
                                                : monedaSeleccionada == 'euro'
                                                    ? 'Euros'
                                                    : 'Dólares'),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                double saldoActual =
                                                    usuario!.saldo;
                                                String monedaActual =
                                                    usuario!.moneda;
                                                double nuevoSaldo =
                                                    convertirMoneda(
                                                        saldoActual,
                                                        monedaActual,
                                                        monedaSeleccionada!);
                                                print(
                                                    'Nuevo saldo: $nuevoSaldo');
                                                usuario!.saldo = nuevoSaldo;
                                                if (await usuarioService
                                                    .actualizarMonedaUsuario(
                                                        idUsuario,
                                                        nuevoSaldo,
                                                        monedaSeleccionada!)) {
                                                  // Se registra exitosamente
                                                  // Muestra un mensaje de éxito
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Se ha cambiado el tipo de moneda!!!',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                  );
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Inicio(),
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Se produjo un error',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              125, 25, 12, 15),
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text("OK")),
                                          TextButton(
                                              onPressed: () {
                                                //Si da clic en cancelar no se guarda la informacion
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancelar"))
                                        ],
                                      );
                                    });
                              } catch (e) {
                                print('Error al actualizar el usuario: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Error al actualizar el usuario',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Center(
                            child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(8),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 15)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 114, 21, 26))),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.cancel),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Cancelar')
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ))
                      ],
                    )
                  ]),
            ),
          )),
    );
  }
}
