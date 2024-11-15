import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:johndeereapp/screens/fav_movie.dart';
import 'package:johndeereapp/screens/profile/widgets/custom_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:johndeereapp/database/agendadb.dart';
import 'package:johndeereapp/models/actor_model.dart';
import 'package:johndeereapp/models/popular_model.dart';
import 'package:johndeereapp/network/api_popular.dart';
import 'package:johndeereapp/provider/test_provider.dart';
import 'package:johndeereapp/widgets/ItemActorMovie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreenFav extends StatefulWidget {
  final PopularModel model;
  const DetailMovieScreenFav({super.key, required this.model});

  @override
  State<DetailMovieScreenFav> createState() => __DetailMovieFavScreenState();
}

int fav = 0;

class __DetailMovieFavScreenState extends State<DetailMovieScreenFav> {
  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
  }

  final ApiPopular apiPopular = ApiPopular();
  Color iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Hero(
        tag: widget.model.id!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500/${widget.model.backdropPath}'),
                        fit: BoxFit.fitHeight,
                        opacity: 0.3)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.model.title.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          alignment: Alignment.center,
                          onPressed: () => {
                                setState(() {
                                  int? idd = widget.model.id;
                                  if (idd! == true) {
                                  } else {
                                    apiPopular.removeFav(idd);
                                    AnimatedSnackBar.material(
                                            'Eliminada de Favoritos',
                                            type: AnimatedSnackBarType.error)
                                        .show(context);
                                    Future.delayed(const Duration(seconds: 3));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const FavMovie())));
                                  }
                                }),
                              },
                          icon: const Icon(
                            Icons.heart_broken,
                            color: Colors.red,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            height: 200,
                            width: 100,
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${widget.model.posterPath}'),
                          ),
                          Container(
                            child: RatingBar(
                              initialRating: widget.model.voteAverage! / 2,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star,
                                      color: Colors.yellow),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Colors.yellow,
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline,
                                    color: Colors.yellow,
                                  )),
                              ignoreGestures: true,
                              onRatingUpdate: (value) {},
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Sinopsis',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          widget.model.overview.toString(),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                        future: apiPopular.getVideo(widget.model.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: snapshot.data.toString(),
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: true,
                                    captionLanguage: AutofillHints.countryName,
                                  )),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Actores',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<List<ActorModel>?>(
                        future: apiPopular.getAllActors(widget.model),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  ActorModel actor = snapshot.data![index];
                                  return CardActor(
                                    name: actor.name.toString(),
                                    photo: actor.profilePath != null
                                        ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                                        : 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg',
                                    character: actor.character!,
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 226, 37, 37),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const FavMovie())));
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
