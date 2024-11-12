import 'package:flutter/material.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/profesor_model.dart';
import 'package:johndeereapp/screens/add_profe.dart';
import 'package:johndeereapp/services/local_storage.dart';
import 'package:johndeereapp/widgets/CardProfeWidget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class ProfesorScreen extends StatefulWidget {
  const ProfesorScreen({super.key});

  @override
  State<ProfesorScreen> createState() => _ProfesorScreenState();
}

class _ProfesorScreenState extends State<ProfesorScreen> {
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profesores"),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: ((context)=> AddProfesor()))),
              icon: const Icon(Icons.task))
        ],
      ),
      body: CustomRefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 3)),
        child: ValueListenableBuilder(
            valueListenable: LocalStorage.flagTask,
            builder: (context, value, _) {
              return FutureBuilder(
                  future: agendaDB!.GETALLPROFESOR(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Profesor>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardProfesorWidget(
                                profesor: snapshot.data![index],
                                agendaDB: agendaDB);
                          });
                    } else {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("No hay nadie registrado"),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }
                  });
            }),
        builder: (BuildContext context, Widget child, IndicatorController controller) { return child; },
      ),
    );
  }
}
