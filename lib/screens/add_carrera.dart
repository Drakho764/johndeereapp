import 'package:flutter/material.dart';
import 'package:johndeereapp/consts.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/carrera_model.dart';
import 'package:johndeereapp/services/local_storage.dart';

class AddCarrera extends StatefulWidget {
  AddCarrera({super.key, this.carreraModel});

  Carrera? carreraModel;

  @override
  State<AddCarrera> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddCarrera> {
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConId = TextEditingController();

  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.carreraModel != null) {
      txtConName.text = widget.carreraModel!.nameCarrera!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameCarrera = TextFormField(
      decoration: const InputDecoration(
          label: Text('Carrera'), border: OutlineInputBorder()),
      controller: txtConName,
    );
    const space = SizedBox(
      height: 10,
    );

    final ElevatedButton btnGuardar = ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: btnColor),
        onPressed: () {
          if (widget.carreraModel == null) {
            agendaDB!.INSERT('tblCarrera', {
              'nameCarrera': txtConName.text,
            }).then((value) {
              var msj = (value > 0)
                  ? 'La inserción fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else {
            agendaDB!.UPDATE('tblCarrera', {
              'idCarrera': widget.carreraModel!.idCarrera,
              'nameCarrera': txtConName.text,
            }).then((value) {
              LocalStorage.flagTask.value = !LocalStorage.flagTask.value;
              var msj = (value > 0)
                  ? 'La actualización fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: const Text('Guardar Carrera'));

    return Scaffold(
      appBar: AppBar(
        title: widget.carreraModel == null
            ? const Text('Nueva carrera')
            : const Text('Actualiza Carrera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameCarrera,
            space,
            btnGuardar,
          ],
        ),
      ),
    );
  }
}
