import 'package:flutter/material.dart';
import "dart:math";
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:share_plus/share_plus.dart';

class Cards extends StatefulWidget {
  final List facts;

  Cards({required this.facts});

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    Random _random = Random();

    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.deepPurple,
      Colors.deepOrange,
      Colors.amber,
      Colors.black,
      Colors.indigo,
      Colors.brown,
      Colors.teal,
    ];

    Color randomColor = Colors.black;

    return SizedBox(
      height: 450,
      width: 400,
      child: Swiper(
        onIndexChanged: (val) {
          randomColor = colors[_random.nextInt(colors.length)];
        },
        control: SwiperControl(
            color: Colors.white,
            iconNext: Icons.navigate_next_rounded,
            iconPrevious: Icons.navigate_before_rounded),
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            color: randomColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async {
                      Share.share(
                          "Did You Know?\n\n${widget.facts[index]}\n\nFacts from the Numberrs app!");
                    },
                    icon: Icon(Icons.share_rounded),
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '"${widget.facts[index]}"',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "Raleway"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: widget.facts.length,
        itemWidth: 400,
      ),
    );
  }
}
