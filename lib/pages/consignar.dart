import 'package:app/data/usuario.dart';
import 'package:app/data/usuarioService.dart';
import 'package:app/pages/inicio.dart';
import 'package:flutter/material.dart';

final TextEditingController valorController = TextEditingController();

class Consignar extends StatelessWidget {
  final Usuario? usuario;

  Consignar({Key? key, required this.usuario}) : super(key: key);

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
              height: 200,
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
                      "Consignar a su cuenta",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: valorController,
                        validator: (value) {
                          ///Validar que se ingresen datos en el cmpo de texto
                          if (value!.isEmpty) {
                            return 'Ingrese el valor a consignar';
                          }
                          // Validar que el valor sea mayor que cero
                          double valor = double.tryParse(value) ?? 0.0;
                          if (valor <= 0) {
                            return 'Ingrese un valor mayor que cero';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            labelText: "Valor a consignar:",
                            labelStyle:
                                TextStyle(color: Color.fromARGB(255, 4, 0, 43)),
                            fillColor: Color.fromARGB(230, 255, 255, 255),
                            filled: true),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
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
                            double valor =
                                double.tryParse(valorController.text) ?? 0.0;
                            if (valor > 0) {
                              try {
                                int idUsuario = usuario!.id!;
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Confirmar valor a consignar"),
                                        content: Text("$valor"),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                double nuevoSaldo =
                                                    usuario!.saldo + valor;
                                                usuario!.saldo = nuevoSaldo;
                                                if (await usuarioService
                                                    .actualizarSaldoUsuario(
                                                        idUsuario,
                                                        nuevoSaldo)) {
                                                  // Se registra exitosamente
                                                  // Limpia los campos después de guardar
                                                  valorController.clear();
                                                  // Muestra un mensaje de éxito
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Consignación exitosa!!!',
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
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Ingrese valores correctos',
                                      style: TextStyle(fontSize: 15)),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
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
