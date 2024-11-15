import 'package:flutter/material.dart'; //1
import 'package:johndeereapp/network/api_popular.dart';
import 'package:johndeereapp/screens/detail_movie_screen.dart';
import 'package:johndeereapp/screens/popular_screen.dart';
import 'package:johndeereapp/screens/profile/widgets/custom_bottom_bar.dart';
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
final ApiPopular apiPopular = ApiPopular();
  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas Favoritas"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
          future: apiPopular.getAllFav(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DetailMovieScreenFav(model: model)));
                          },
                          child: Hero(
                              tag: model,
                              child: ItemPopularMovie(
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                );
              }
            }
            return Container();
          }),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        elevation: 12,
        backgroundColor: Color.fromARGB(255, 226, 37, 37),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
          size: 34,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
