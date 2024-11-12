import 'package:flutter/material.dart'; //1
import 'package:provider/provider.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/popular_model.dart';
import 'package:johndeereapp/provider/test_provider.dart';
import 'package:johndeereapp/screens/detail_movie_screen_fav.dart';
import 'package:johndeereapp/widgets/item_movie.dart'; //8

class FavMovie extends StatefulWidget {
  const FavMovie({super.key});

  @override
  State<FavMovie> createState() => _FavMovie();
}

class _FavMovie extends State<FavMovie> {
  AgendaDB? agendaDB;


  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Peliculas Favoritas"),
        ),
        body: FutureBuilder(
            future: agendaDB!.GETALLPOPULAR(),
            builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
              if (snapshot.data != null) {
                if (snapshot.data!.isNotEmpty) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: .8,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      PopularModel model = snapshot.data![index];
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DetailMovieScreenFav(model: model)));
                          },
                          child:Hero(tag: model, child: ItemPopularMovie(
                              popularModel: snapshot.data![index])) 
                          
                          /*ItemPopularMovie(
                              popularModel: snapshot.data![index]),*/
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Algo salio mal :()'),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                    itemCount: snapshot.data != null
                        ? snapshot.data!.length
                        : 0, //snapshot.data!.length,
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No te gustan las pelis?',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              }
              return Container();

            }));
  }
}
