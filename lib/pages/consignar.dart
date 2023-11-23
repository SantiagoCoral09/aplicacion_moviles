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
                    "Consignar",
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
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
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "Valor a consignar:",
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Color.fromARGB(50, 217, 214, 214),
                          filled: true),
                    ),
                  ),
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
                                                      idUsuario, nuevoSaldo)) {
                                                // Se registra exitosamente
                                                // Limpia los campos después de guardar
                                                valorController.clear();
                                                // Muestra un mensaje de éxito
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Consignación exitosa!!!'),
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
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ingrese valores correctos'),
                                backgroundColor: Colors.red,
                              ),
                            );
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

      // Resto del código de la pantalla...
    );
  }
}
