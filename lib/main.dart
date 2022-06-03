import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Chinder for Jokes',
      theme: ThemeData(
        //primarySwatch: Colors,
        colorScheme: const ColorScheme.dark(),
      ),
      home: const MyHomePage(title: 'Jokes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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

class _MyHomePageState extends State<MyHomePage> {
  var r = Random();
  var numImages = 26;

  Future<Joke> fetchJoke() async {
    final response =
        await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load JOKE T_T');
    }
  }

  List<Card> cardDeck = [];

  @override
  Widget build(BuildContext context) {
    SwipingCardDeck deck = SwipingCardDeck(
      cardDeck: getCardDeck(context),
      onDeckEmpty: () {
        debugPrint("Card deck empty");
      },
      onLeftSwipe: (Card card) {
        debugPrint("Swiped left!     " + cardDeck.length.toString());
        cardDeck.removeAt(0);
        setState(() {});
      },
      onRightSwipe: (Card card) {
        debugPrint("Swiped right!    " + cardDeck.length.toString());
        cardDeck.removeAt(0);
        setState(() {});
      },
      cardWidth: MediaQuery.of(context).size.width * 0.9,
      swipeThreshold: MediaQuery.of(context).size.width / 4,
      minimumVelocity: 1500,
      rotationFactor: 0.4 / 3.14,
      swipeAnimationDuration: const Duration(milliseconds: 600),
    );
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: deck,
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: IconButton(
            icon: const Icon(Icons.favorite),
            iconSize: 35,
            color: Colors.red,
            onPressed: deck.animationActive ? null : () => deck.swipeRight(),
          ),
        ),
      ],
    );
  }

  List<Card> getCardDeck(BuildContext context) {
    int j = 0;
    if (cardDeck.isEmpty) {
      j = 1;
    }
    for (int i = 0; i < 1 + j; ++i) {
      int index = r.nextInt(numImages);
      cardDeck.add(
        Card(
          color: Colors.black26,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/chuck$index.png',
                    height: 2000,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6, left: 2, right: 2),
                    alignment: Alignment.bottomCenter,
                    child: ColoredBox(
                      color: Colors.black54,
                      child: FutureBuilder(
                        future: fetchJoke(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Joke> snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data!.joke);
                            return Text(
                              snapshot.data!.joke,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            );
                          } else {
                            return const Text(
                              "Waiting for a REAL JOKE...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      //setState(() {});
    }
    return cardDeck;
  }
}
