import 'package:flutter/material.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/task_model.dart';
import 'package:johndeereapp/screens/add_task.dart';
import 'package:johndeereapp/services/local_storage.dart';

class CardTaskWidget extends StatelessWidget {
  CardTaskWidget({super.key, required this.taskModel, this.agendaDB});
  String profe='';
  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    switch(taskModel.idProfe){
   case 1:
     profe='Luisito Díaz';
    case 2:
      profe='Alberto del Rio';
  }
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(taskModel.nameTask!,style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Text(taskModel.dscTask!, style: const TextStyle( fontSize: 10),),
              const SizedBox(height: 10,),
              
              Row(children: [const Text('Se entrega el'),
                const SizedBox(width: 12,),
                Text(taskModel.fecExpiracion!, style: const TextStyle(
                      fontWeight: FontWeight.bold)),],),
              Row(children: [const Text('Estado'),
                const SizedBox(width: 12,),
                Text(taskModel.sttTask!, style: const TextStyle(
                      fontWeight: FontWeight.bold)),],),
              Row(children: [const Text('Profesor'),
                const SizedBox(width: 12,),
                Text(profe, style: const TextStyle(
                      fontWeight: FontWeight.bold)),],)
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTask(taskModel: taskModel))),
                  child: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Mensaje del sistema'),
                          content: const Text('¿Deseas eliminar la tarea?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETE('tblTareas', taskModel.idTask!)
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
