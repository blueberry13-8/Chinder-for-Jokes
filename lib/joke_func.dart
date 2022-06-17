import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'joke.dart';
import 'package:http/http.dart' as http;

String category = 'random';

Future<Joke> fetchJoke() async {
  final response =
      await http.get(Uri.parse('https://api.chucknorris.io/jokes/$category'));
  if (response.statusCode == 200) {
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load JOKE T_T');
  }
}

const String errorJoke =
        'Please check your connection to network...',
    welcome1 = 'Here will be jokes about Chuck Norris.',
    welcome2 = 'Swipe right for saving jokes in favorite list.';

List<String> jokes = [
  welcome1,
  welcome2,
  errorJoke,
];

void updateJokeList() {
  if (jokes[2] == errorJoke) {
    fetchJoke().then((value) {
      jokes[1] = value.joke;
    });
  }
  debugPrint('0 : ${jokes[0]}');
  debugPrint('1 : ${jokes[1]}');
  debugPrint('2 : ${jokes[2]}');
  debugPrint('***************************');
  jokes[0] = jokes[1];
  jokes[1] = jokes[2];
  jokes[2] = errorJoke;
  fetchJoke().then((value) {
    jokes[2] = value.joke;
  });
  debugPrint('0 : ${jokes[0]}');
  debugPrint('1 : ${jokes[1]}');
  debugPrint('2 : ${jokes[2]}\n');
}
