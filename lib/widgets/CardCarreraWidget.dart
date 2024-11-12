import 'package:flutter/material.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/carrera_model.dart';
import 'package:johndeereapp/screens/add_carrera.dart';
import 'package:johndeereapp/services/local_storage.dart';

class CardCarreraWidget extends StatelessWidget {
  CardCarreraWidget({super.key, required this.carreraModel, this.agendaDB});

  Carrera carreraModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Row(
        children: [
          Column(
            children: [
              Text(carreraModel.nameCarrera?? "null"),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddCarrera(carreraModel: carreraModel))),
                  child: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Mensaje del sistema'),
                          content: const Text('¿Deseas eliminar la carrera?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETE(
                                          'tblCarrera', carreraModel.idCarrera!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    LocalStorage.flagTask.value =
                                        !LocalStorage.flagTask.value;
                                  });
                                },
                                child: const Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('No'))
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
