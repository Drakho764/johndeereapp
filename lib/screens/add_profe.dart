import 'package:flutter/material.dart';
import 'package:johndeereapp/consts.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/profesor_model.dart';
import 'package:johndeereapp/services/local_storage.dart';

class AddProfesor extends StatefulWidget {
  AddProfesor({super.key, this.profesor});

  Profesor? profesor;

  @override
  State<AddProfesor> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<AddProfesor> {
  late List<DropdownMenuItem<String>> listcar =[];
  String? dropDownValue = "Carrera";
  var indice;
  late DropdownButton<String> dpb;
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  TextEditingController txtConIdCarrera = TextEditingController();
  late List<String> carr;
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if (widget.profesor != null) {
      txtConName.text = widget.profesor!.nameProfe!;
      txtConEmail.text = widget.profesor!.email!;
      //txtConIdCarrera.text = widget.profesor!.idCarrera! as String;

    } else {

    }
    agendaDB?.CARRERA().then((listMap) {
        listMap?.map((map){
          print(map.toString());
          return getDropDownWidget(map);
        }).forEach((dropDownItem) {
          listcar.add(dropDownItem);
         });
        setState(() {});
      });
      //carr= List<String>.from(listcar as List);
  }

  @override
  Widget build(BuildContext context) {
    final txtName = TextField(
      decoration: const InputDecoration(
          label: Text('Nombre profesor'), border: OutlineInputBorder()),
      controller: txtConName,
    );
    final txtEmail = TextField(
      decoration: const InputDecoration(
          label: Text('Email'), border: OutlineInputBorder()),
      controller: txtConEmail,
    );

    const space = SizedBox(height: 10);

    final ElevatedButton btnGuardar = ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: btnColor),
        onPressed: () {
          if (widget.profesor == null) {
            agendaDB!.INSERT('tblProfesor', {
              'nameProfe': txtConName.text,
              'email': txtConEmail.text,
              'idCarrera': indice
            }).then((value) {
              var msj = (value > 0) ? 'La insercion fue correcta' : 'Error';
              var snackBar = const SnackBar(content: Text('Profesor saved'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          } else {
            agendaDB!.UPDATE('tblProfesor', {
              'idProfe': widget.profesor!.idProfe,
              'nameProfe': txtConName.text,
              'email': txtConEmail.text,
              //'sttTask': dropDownValue!.substring(0,1)
            }).then((value) {
              LocalStorage.flagTask.value = !LocalStorage.flagTask.value;
              var msj = (value > 0) ? 'La insercion fue correcta' : 'Error';
              var snackBar = const SnackBar(content: Text('Profesor saved'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          }
        },
        child: const Text('Guardar Profe'));


    return Scaffold(
      appBar: AppBar(
          title: widget.profesor == null
              ? const Text('Nuevo Profe')
              : const Text('Actualiza Profe')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtName,
            space,
            txtEmail,
            space,
            //ddBStatus,
            DropdownButton(
              hint: const Text('Carrera'),
              onChanged:( value) {   
                dropDownValue = value;
                setState(() {
                });
                
                switch(value){
                  case 'Sistemas':
                    indice=1;
                  case 'Quimica':
                    indice=2;
                  case 'Ambiental':
                    indice=3;
                }
                print(indice);
              },
              items: listcar,
              ),
            btnGuardar
          ],
        ),
      ),
    );
  }
    DropdownMenuItem<String> getDropDownWidget(Map<String, dynamic> map) {
    return DropdownMenuItem<String>(
      value: map['nameCarrera'],
      child: Text(map['nameCarrera']),
    );
  }
}
