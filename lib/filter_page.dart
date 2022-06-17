import 'package:flutter/material.dart';
import 'package:test_flutter/joke_func.dart';
import 'package:toggle_switch/toggle_switch.dart';

int _index = 0;

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double border = MediaQuery.of(context).size.height / 16;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select jokes filter'),
        ),
        body: SingleChildScrollView(
          child: ToggleSwitch(
            customHeights: [
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
              border,
            ],
            fontSize: 20,
            activeFgColor: Colors.black45,
            dividerColor: Colors.black45,
            inactiveBgColor: Colors.black38,
            isVertical: true,
            minWidth: MediaQuery.of(context).size.width,
            radiusStyle: true,
            cornerRadius: 20,
            initialLabelIndex: _index,
            activeBgColors: const [
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
              [Colors.white38],
            ],
            labels: const [
              'Random',
              'Animal',
              'Career',
              'Celebrity',
              'Dev',
              'Explicit',
              'Fashion',
              'Food',
              'History',
              'Money',
              'Movie',
              'Music',
              'Political',
              'Religion',
              'Science',
              'Sport',
              'Travel',
            ],
            onToggle: (index) {
              _index = index!;
              switch (index) {
                case 0:
                  category = 'random';
                  break;
                case 1:
                  category = 'random?category=animal';
                  break;
                case 2:
                  category = 'random?category=career';
                  break;
                case 3:
                  category = 'random?category=celebrity';
                  break;
                case 4:
                  category = 'random?category=dev';
                  break;
                case 5:
                  category = 'random?category=explicit';
                  break;
                case 6:
                  category = 'random?category=fashion';
                  break;
                case 7:
                  category = 'random?category=food';
                  break;
                case 8:
                  category = 'random?category=history';
                  break;
                case 9:
                  category = 'random?category=money';
                  break;
                case 10:
                  category = 'random?category=movie';
                  break;
                case 11:
                  category = 'random?category=music';
                  break;
                case 12:
                  category = 'random?category=political';
                  break;
                case 13:
                  category = 'random?category=religion';
                  break;
                case 14:
                  category = 'random?category=science';
                  break;
                case 15:
                  category = 'random?category=sport';
                  break;
                case 16:
                  category = 'random?category=travel';
                  break;
              }
            },
          ),
        ),
    );
  }
}
