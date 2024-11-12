import 'package:flutter/material.dart';
import 'package:johndeereapp/consts.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/task_model.dart';
import 'package:johndeereapp/services/local_storage.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late List<DropdownMenuItem<String>> listprof =[];
  DateTime initSelectedDate = DateTime.now();
  DateTime endSelectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1)));

    if (picked != null && picked != endSelectedDate) {
      setState(() {
        print(endSelectedDate.toString().substring(0, 19));
        endSelectedDate = picked;
      });
    }
  }

  Future<void> _selectDateInit(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1)));

    if (picked != null && picked != initSelectedDate) {
      setState(() {
        initSelectedDate = picked;
      });
    }
  }

  String? dropDownValue = "Pendiente";
  String? dropDownProf = "";
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  var indice;
  List<String> dropDownValues = [
    'Pendiente',
    'Completado',
    'Ya la estoy haciendo'
  ];

  AgendaDB? agendaDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.taskModel != null) {
      txtConName.text = widget.taskModel!.nameTask!;
      txtConDsc.text = widget.taskModel!.dscTask!;
      endSelectedDate = DateTime.parse(widget.taskModel!.fecExpiracion!);
      initSelectedDate = DateTime.parse(widget.taskModel!.fecRecordatorio!);

      

      switch (widget.taskModel!.sttTask) {
        case 'E':
          dropDownValue = "Ya la estoy haciendo";
          break;
        case 'C':
          dropDownValue = "Completado";
          break;
        case 'P':
          dropDownValue = "Pendiente";
      }


    }
    agendaDB?.PROFESORES().then((listMap) {
        listMap?.map((map){
          print(map.toString());
          return getDropDownWidget(map);
        }).forEach((dropDownItem) {
          listprof.add(dropDownItem);
         });
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
          label: Text('Titulo de la tarea'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtDscTask = TextField(
      decoration: const InputDecoration(
          label: Text('De que se trata la tarea'),
          border: OutlineInputBorder()),
      maxLines: 6,
      controller: txtConDsc,
    );

    const space = SizedBox(
      height: 10,
    );

    final DropdownButton ddBStatus = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            .map((status) =>
                DropdownMenuItem(value: status, child: Text(status)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    final ElevatedButton btnGuardar = ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: btnColor),
        onPressed: () {
          print(endSelectedDate.toString().substring(0, 19));
          if (widget.taskModel == null) {
            agendaDB!.INSERT('tblTareas', {
              'nameTask': txtConName.text,
              'dscTask': txtConDsc.text,
              'sttTask': dropDownValue!.substring(0, 1),
              'fecExpiracion': endSelectedDate.toString().substring(0, 19),
              'fecRecordatorio': initSelectedDate.toString().substring(0, 19),
              'idProfesor': indice
            }).then((value) {
              var msj = (value > 0) ? 'Tarea guardada!' : 'Algo anda mal';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else {
            agendaDB!.UPDATE('tblTareas', {
              'idTask': widget.taskModel!.idTask,
              'nameTask': txtConName.text,
              'dscTask': txtConDsc.text,
              'sttTask': dropDownValue!.substring(0, 1),
              'fecExpiracion': endSelectedDate.toString().substring(0, 19),
              'fecRecordatorio': initSelectedDate.toString().substring(0, 19),
              'idProfesor': indice
            }).then((value) {
              LocalStorage.flagTask.value = !LocalStorage.flagTask.value;
              var msj = (value > 0) ? 'Tarea Actualizada!' : 'Algo anda mal';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: const Text('Guardar Tarea'));

    return Scaffold(
      appBar: AppBar(
        title: widget.taskModel == null
            ? const Text('Agregar Tarea chida')
            : const Text('Actualizar tarea chida'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              txtNameTask,
              space,
              txtDscTask,
              space,
              ddBStatus,
              space,
              buildDateInitSelector(context, "Fecha Notificar"),
              buildDateEndSelector(context, "Fecha Final"),
              DropdownButton(
                hint: const Text('Profesor'),
                onChanged:(value) {
                  dropDownProf = value;
                  setState(() {});
                  print(dropDownProf);
                  switch(value){
                  case 'Luisito Díaz ':
                    indice=1;
                  case 'Alberto del Rio ':
                    indice=2;
                }
                print(indice);
                },
                items: listprof,
                ),
              btnGuardar,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDateEndSelector(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly:
            true, // Evita que se pueda editar el campo de texto directamente
        controller: TextEditingController(
          text: dateFormat
              .format(endSelectedDate), // Muestra la fecha seleccionada
        ),

        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          _selectDateEnd(
              context); // Abre el selector de fecha al tocar en cualquier parte del campo
        },
        // Añade el sufijo del ícono para indicar que es un campo de fecha
      ),
    );
  }

  Widget buildDateInitSelector(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly:
            true, // Evita que se pueda editar el campo de texto directamente
        controller: TextEditingController(
          text: dateFormat
              .format(initSelectedDate), // Muestra la fecha seleccionada
        ),

        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          _selectDateInit(
              context); // Abre el selector de fecha al tocar en cualquier parte del campo
        },
        // Añade el sufijo del ícono para indicar que es un campo de fecha
      ),
    );
  }
  
  DropdownMenuItem<String> getDropDownWidget(Map<String, dynamic> map) {
    return DropdownMenuItem<String>(
      value: map['nameProfe'],
      child: Text(map['nameProfe']),
    );
  }
}
