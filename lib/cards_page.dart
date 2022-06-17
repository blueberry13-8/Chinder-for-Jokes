import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'favorite_page.dart';
import 'filter_page.dart';
import 'list_of_cards.dart';
import 'joke.dart';
import 'joke_func.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SwipingCardDeck deck;

  bool first = true;

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  String stringOnDisplay = '';

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      deck = SwipingCardDeck(
        cardDeck: getStartCardDeck(context, [], 2),
        onDeckEmpty: () {
          debugPrint("Card deck empty");
        },
        onLeftSwipe: (Card card) {
          debugPrint("Swiped left!     ${deck.cardDeck.length}");
          setState(() {
            Hive.lazyBox<Joke>('box_for_joke').clear();
            updateCardDeck(context, deck.cardDeck);
          });
        },
        onRightSwipe: (Card card) {
          debugPrint("Swiped right!    ${deck.cardDeck.length}");
          setState(() {
            if (jokes[0].compareTo(errorJoke) != 0 &&
                jokes[0].compareTo(welcome1) != 0 &&
                jokes[0].compareTo(welcome2) != 0) {
              addToFavor();
            }
            updateCardDeck(context, deck.cardDeck);
          });
        },
        cardWidth: MediaQuery.of(context).size.width * 0.9,
        swipeThreshold: MediaQuery.of(context).size.width / 4,
        minimumVelocity: 2000,
        rotationFactor: 0.4 / 3.14,
        swipeAnimationDuration: const Duration(milliseconds: 650),
      );
    }
    if (stringOnDisplay == errorJoke && jokes[0] != errorJoke) {
      setState(() {});
    }
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FilterPage(title: 'Filter')));
            },
            icon: const Icon(Icons.edit, color: Color(0xffffffff)),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      deck,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.favorite),
                iconSize: 35,
                color: Colors.red,
                onPressed:
                    deck.animationActive ? null : () => deck.swipeRight(),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.article),
                iconSize: 35,
                color: Colors.pink,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const FavoritePage(title: 'Favorite'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
