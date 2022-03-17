//Crisis by Bhumika Vesvikar

import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  List data = [
    {
      "color": Color(0xffff6968),
      'text': "NHS",
      'bio1': "Urgent mental",
      'bio2': "health helplines",
      'head': "nhs"
    },
    {
      "color": Color(0xff7a54ff),
      'text': "The Mix",
      'bio1': "Supporting Under",
      'bio2': "25s",
      'head': "the mix"
    },
    {
      "color": Color(0xffff8f61),
      'text': "LGBT",
      'bio1': "Supporting LGBT",
      'bio2': "24/7",
      'head': "lgbt"
    },
    {
      "color": Color(0xff2ac3ff),
      'text': "CALM",
      'bio1': "Supporting Men",
      'bio2': "including webchat",
      'head': "calm"
    },
    {
      "color": Color(0xff5a65ff),
      'text': "SANEline",
      'bio1': "out-of-hours",
      'bio2': "mental health helpline",
      'head': "saneline"
    },
    {
      "color": Color(0xff96da45),
      'text': "Samaritian",
      'bio1': "Goods Samaritians",
      'bio2': "All Night",
      'head': "samaritian"
    },
    {
      "color": Color(0xffff6968),
      'text': "BEAT",
      'bio1': "A helping hand",
      'bio2': "available 24/7",
      'head': "beat"
    },
    {
      "color": Color(0xff7a54ff),
      'text': "Shout",
      'bio1': "Support with",
      'bio2': "Eating Disorders",
      'head': "shout"
    },
    {
      "color": Color(0xffff8f61),
      'text': "Alchol",
      'bio1': "free, 24/7 mental",
      'bio2': "health text support",
      'head': "alcohol"
    },
    {
      "color": Color(0xff2ac3ff),
      'text': "Help",
      'bio1': "happy to ",
      'bio2': "help",
      'head': "help"
    },
    {
      "color": Color(0xff5a65ff),
      'text': "BRAVD",
      'bio1': "Meow",
      'bio2': "Ginger & Garlic",
      'head': "bravd"
    },
    {
      "color": Color(0xff96da45),
      'text': "Special",
      'bio1': "Special forces",
      'bio2': "special stuffs",
      'head': "special"
    },
  ];

  final colorwhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // crossAxisSpacing: 10
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {},
                child: Card(
                  color: data[index]["color"],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '  ${data[index]['head']}',
                              style: TextStyle(
                                  color: colorwhite.withOpacity(0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                  color: Color.fromRGBO(255, 255, 255, 0.38)),
                              child: Icon(
                                Icons.topic,
                                color: colorwhite,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 10, bottom: 20),
                            child: Text(
                              '${data[index]['text']}',
                              style: TextStyle(fontSize: 24, color: colorwhite),
                            )),
                        Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${data[index]['bio1']}',
                                  style: TextStyle(
                                      fontSize: 15, color: colorwhite),
                                ),
                                Text(
                                  '${data[index]['bio2']}',
                                  style: TextStyle(
                                      fontSize: 13, color: colorwhite),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
