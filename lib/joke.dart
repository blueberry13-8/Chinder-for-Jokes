import 'dart:convert';
import 'package:http/http.dart' as http;

class Joke {
  final String joke;

  const Joke({
    required this.joke,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      joke: json['value'],
    );
  }
}

Future<Joke> fetchJoke() async {
  final response =
  await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
  if (response.statusCode == 200) {
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load JOKE T_T');
  }
}