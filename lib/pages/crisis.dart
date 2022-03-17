//Crisis by Bhumika Vesvikar

import 'package:flutter/material.dart';
import 'package:my_space/pages/home_page.dart';
import 'package:my_space/widgets/card_widget.dart';

class Crisis extends StatefulWidget {
  const Crisis({Key? key}) : super(key: key);

  @override
  _CrisisState createState() => _CrisisState();
}

class _CrisisState extends State<Crisis> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.all(
              16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      border: Border.all(color: Colors.black, width: 1.5),
                      shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  width: 60,
                ),
                Text(
                  "Need more help?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(24)),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicator: CircleTabIndicator(color: Colors.black, radius: 4),
                tabs: [
                  Tab(
                    text: 'India',
                  ),
                  Tab(
                    text: "US",
                  ),
                  Tab(
                    text: "World",
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Emergency",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "If you need help for a mental health crisis, emergency or breakdow, you should get immediate expert advice and assessment.",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.red[900],
                      padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                      child: Text(
                        "Dial 991",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 415,
            child: TabBarView(
              controller: _tabController,
              children: [CardWidget(), CardWidget(), CardWidget()],
            ),
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;

    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
