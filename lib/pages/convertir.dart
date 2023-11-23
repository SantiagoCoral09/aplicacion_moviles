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
    // Usar el usuario aquí
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    "https://images.pexels.com/photos/9704348/pexels-photo-9704348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  ),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Convertir",
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
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
                          decoration: const InputDecoration(
                              labelText: "Elija el tipo de moneda:",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Color.fromARGB(50, 217, 214, 214),
                              filled: true),
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: ElevatedButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add),
                            SizedBox(
                              width: 7,
                            ),
                            Text('Confirmar')
                          ],
                        ),
                        onPressed: () async {
                          if (monedaSeleccionada == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Seleccione una moneda a cambiar'),
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
                                      content: Text(monedaSeleccionada == 'cop'
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
                                              print('Nuevo saldo: $nuevoSaldo');
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
                                                        'Se ha cambiado el tipo de moneda!!!'),
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
                                                        'Se produjo un error'),
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
                                  content:
                                      Text('Error al actualizar el usuario'),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add),
                            SizedBox(
                              width: 7,
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
          )),
    );
  }
}
