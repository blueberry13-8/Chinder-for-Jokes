import 'package:hive/hive.dart';
part 'joke.g.dart';

@HiveType(typeId: 0)
class Joke {
  @HiveField(0)
  final String joke;

  const Joke({
    required this.joke,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      joke: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': joke,
    };
  }
}
