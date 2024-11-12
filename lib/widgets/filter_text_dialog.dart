import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/task_model.dart';
import 'package:johndeereapp/services/task_provider.dart';


class FilterTextWidget extends StatelessWidget {
  FilterTextWidget({super.key});

  TextEditingController txtController = TextEditingController();
  AgendaDB agendaDB = AgendaDB();

  List<TaskModel> filtered = [];

  @override
  Widget build(BuildContext context) {
    final updateTask = Provider.of<TaskProvider>(context);
    return Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Search Bar'),
                border: OutlineInputBorder(),
              ),
              controller: txtController,
            ),
            ElevatedButton(
              onPressed: () {
                agendaDB.getTaskByText('%${txtController.text}%').then((value) {
                  if (value.isNotEmpty) {
                    updateTask.isUpdated = true;
                    filtered = value;
                  } else {
                    updateTask.isUpdated = true;
                    filtered = [];
                  }
                });
              },
              child: const Text("Find"),
            )
          ],
        ));
  }
}
