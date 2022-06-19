import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'joke.dart';
import 'joke_func.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

bool localSaving = true;

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    if (localSaving) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Your Favorite Jokes'),
          actions: [
            IconButton(
                onPressed: () {
                  localSaving = !localSaving;
                  setState(() {});
                },
                icon: const Icon(Icons.change_circle)),
          ],
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: Hive.lazyBox<Joke>('box_for_joke').listenable(),
            builder: (context, LazyBox<Joke> lBox, _) {
              if (lBox.isEmpty) {
                return const Center(
                  child: Text(
                    'Waiting for the best jokes..',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
              return ListView.builder(
                itemCount: lBox.length,
                itemBuilder: (context, index) {
                  Future<Joke?> joke = lBox.getAt(index);
                  return FutureBuilder<Joke?>(
                    future: joke,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text('Waiting for data...');
                      }
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 3, top: 3, bottom: 5, right: 5),
                            child: ColoredBox(
                              color: Colors.black,
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data!.joke,
                                      style: const TextStyle(
                                        color: Color(0xFFF1F1F1),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          lBox.deleteAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 7,
                              child: ColoredBox(color: Colors.black87))
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        //bottomNavigationBar: ,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Shared Favorite Jokes'),
          actions: [
            IconButton(
                onPressed: () {
                  localSaving = !localSaving;
                  setState(() {});
                },
                icon: const Icon(Icons.change_circle)),
          ],
        ),
        body: SafeArea(
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('jokes')
                .doc('jokes')
                .get(),
            builder: (context, value) {
              if (value.connectionState == ConnectionState.none){
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text('Waiting for network.'),
                  ),
                );
              }
              if (!value.hasData || value.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              List<dynamic> list = value.data!.get('strings');
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 3, top: 3, bottom: 5, right: 5),
                        child: ColoredBox(
                          color: Colors.black,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  list[index],
                                  style: const TextStyle(
                                    color: Color(0xFFF1F1F1),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      setState(() {
                                        List<dynamic> temp = list;
                                        temp.removeAt(index);
                                        FirebaseFirestore.instance
                                            .collection('jokes')
                                            .doc('jokes')
                                            .set({'strings': temp});
                                      });
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 7, child: ColoredBox(color: Colors.black87))
                    ],
                  );
                },
              );
            },
          ),
        ),
      );
    }
  }
}

void addToFavor() {
  String toSaving = jokes[0];
  if (localSaving) {
    Hive.lazyBox<Joke>('box_for_joke').add(Joke(joke: toSaving));
    Future.delayed(const Duration(milliseconds: 50));
  } else {
    FirebaseFirestore.instance
        .collection('jokes')
        .doc('jokes')
        .get()
        .then((value) {
      if (value.exists) {
        List<dynamic> a = value.get('strings');
        a.add(toSaving);
        FirebaseFirestore.instance
            .collection('jokes')
            .doc('jokes')
            .set({'strings': a}).then(
                (value) => debugPrint('Joke in the FIRESTORE!'));
      } else {
        FirebaseFirestore.instance.collection('jokes').doc('jokes').set({
          'strings': [toSaving]
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 50));
  }
}
