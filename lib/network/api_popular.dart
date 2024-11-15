import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:johndeereapp/models/actor_model.dart';
import 'package:johndeereapp/models/popular_model.dart';

class ApiPopular {
  String apiKey = '185e67e9899908fff4736fb3b2d68ae7'; 
  String sessionId = '33c1ff3b2d405de74590c9cdb92fbe5f2ae88957';
  int accountId = 21630747;
  bool favorite = true;
  Uri link = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1');
  Uri favo =
      Uri.parse('https://api.themoviedb.org/3/account/21630747/favorite');
  Uri linkf = Uri.parse(
      'https://api.themoviedb.org/3/account/21630747/favorite/movies?language=en-US&page=1&sort_by=created_at.asc');

  Future<List<PopularModel>?> getAllPopular() async {
    var response = await http.get(link);
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['results'] as List;
      return jsonResult
          .map((popular) => PopularModel.fromMap(popular))
          .toList();
    }
    return null;
  }
    Future<void> removeFav(int movieId,) async {
  // Construye la URL del endpoint
  final url = Uri.parse(
      'https://api.themoviedb.org/3/account/$accountId/favorite?api_key=$apiKey&session_id=$sessionId');

  // Cuerpo de la solicitud
  final Map<String, dynamic> body = {
    'media_type': 'movie',
    'media_id': movieId,
    'favorite': false,
  };

  try {
    // Realiza la solicitud POST
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    // Verifica la respuesta
    if (response.statusCode == 200) {
      print('Película eliminada como favorita con éxito: ${response.body}');
    } else {
      print('Error al eliminar la película: ${response.statusCode}');
      print('Mensaje: ${response.body}');
    }
  } catch (e) {
    print('Excepción durante la solicitud: $e');
  }

}

  Future<void> addFav(int movieId,) async {
  // Construye la URL del endpoint
  final url = Uri.parse(
      'https://api.themoviedb.org/3/account/$accountId/favorite?api_key=$apiKey&session_id=$sessionId');

  // Cuerpo de la solicitud
  final Map<String, dynamic> body = {
    'media_type': 'movie',
    'media_id': movieId,
    'favorite': true,
  };

  try {
    // Realiza la solicitud POST
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    // Verifica la respuesta
    if (response.statusCode == 200) {
      print('Película añadida como favorita con éxito: ${response.body}');
    } else {
      print('Error al añadir la película: ${response.statusCode}');
      print('Mensaje: ${response.body}');
    }
  } catch (e) {
    print('Excepción durante la solicitud: $e');
  }

}
Future<List<PopularModel>?> SimilarMovies( int movieId,) async {
  // Construye la URL del endpoint
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$apiKey&language=en-US&page=1');

  try {
    // Realiza la solicitud GET
    final response = await http.get(url);

    // Verifica la respuesta
    if (response.statusCode == 200) {
       var jsonResult = jsonDecode(response.body)['results'] as List;
      return jsonResult
          .map((popular) => PopularModel.fromMap(popular))
          .toList();
    } else {
      print('Error al buscar películas similares: ${response.statusCode}');
      print('Mensaje: ${response.body}');
    }
  } catch (e) {
    print('Excepción durante la solicitud: $e');
  }
  return null;
}

  Future<List<PopularModel>?> getAllFav() async {
  // Construye la URL del endpoint
  final url = Uri.parse(
      'https://api.themoviedb.org/3/account/$accountId/favorite/movies?api_key=$apiKey&session_id=$sessionId');

  try {
    // Realiza la solicitud GET
    final response = await http.get(url);

    // Verifica la respuesta
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['results'] as List;
      return jsonResult
          .map((popular) => PopularModel.fromMap(popular))
          .toList();
    } else {
      print('Error al obtener las películas favoritas: ${response.statusCode}');
      print('Mensaje: ${response.body}');
    }
  } catch (e) {
    print('Excepción durante la solicitud: $e');
  }
  return null;
}

  Future<String> getVideo(int id) async {
    final URL =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=4cdb6e42e276c71ca9dbe088cc455570';
    final response = await http.get(Uri.parse(URL));
    var listVideo = jsonDecode(response.body)['results'] as List;
    if (response.statusCode == 200) {
      listVideo = jsonDecode(response.body)['results'] as List;
    }
    for (var element in listVideo) {
      if (element['type'] == 'Trailer') {
        return element['key'];
      }
    }
    return '';
  }

  Future<List<ActorModel>?> getAllActors(PopularModel popularModel) async {
    final URL =
        'https://api.themoviedb.org/3/movie/${popularModel.id}/credits?api_key=4cdb6e42e276c71ca9dbe088cc455570';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var listActor = jsonDecode(response.body)['cast'] as List;
      return listActor.map((actor) => ActorModel.fromMap(actor)).toList();
    }
    return null;
  }
}
