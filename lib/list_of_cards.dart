import 'dart:math';
import 'package:flutter/material.dart';
import 'joke_func.dart';

var _r = Random();
var _numImages = 26;

void updateCardDeck(BuildContext context, List<Card> cardDeck) {
  updateJokeList();
  int index = _r.nextInt(_numImages);
  cardDeck.insert(
    0,
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
                  color: Colors.black87,
                  child: Text(
                    jokes[1],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

List<Card> getStartCardDeck(BuildContext context, List<Card> cardDeck, int N) {
  for (int i = 0; i < N; i++) {
    int index = _r.nextInt(_numImages);
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
                    color: Colors.black87,
                    child: Text(
                      jokes[i],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  updateJokeList();
  return cardDeck;
}

/*
FutureBuilder<Joke>(
                      future: fetchJoke(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.joke,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Check your Internet Connection!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          );
                        }
                        return const Text(
                          'Waiting for a REAL JOKE...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
 */
