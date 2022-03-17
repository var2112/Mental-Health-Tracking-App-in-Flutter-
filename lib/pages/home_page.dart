//HomePage by Varun Kamble

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_space/controller/mood_controller.dart';
import 'package:my_space/model/user_model.dart';
import 'package:my_space/pages/category.dart';
import 'package:my_space/pages/chatPage.dart';
import 'package:my_space/pages/crisis.dart';
import 'package:my_space/pages/home_screen.dart';
import 'package:my_space/pages/loginpage.dart';
import 'package:my_space/ui/moodsDatabase.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final style = TextStyle(color: Colors.grey[700]);
  final _moodController = Get.put(MoodController());

  var images = {
    "happy.jpg": "Happy",
    "sad_emoji.png": "Sad",
    "angry_emoji.png": "Angry",
    "stressed_emoji.png": "Stressed",
    "focused_emoji.png": "Focused",
    "workout_emoji.png": "Workout",
    "sleepy_emoji.png": "Sleepy",
  };

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    setBottomBarIndex(index) {
      setState(() {
        currentIndex = index;
      });
    }

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Row(
                    children: [
                      Text("My Space",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900))
                          //TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              child: Crisis(),
                              duration: Duration(milliseconds: 600),
                              reverseDuration: Duration(milliseconds: 700),
                              type: PageTransitionType.topToBottom));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: const Text(
                            "Crisis",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      PopupMenuButton(
                          icon: Icon(
                            Icons.settings,
                            size: 30,
                          ),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.bedtime,
                                      color: Colors.black,
                                    ),
                                    FlatButton(
                                        onPressed: () {}, child: Text("Theme"))
                                  ],
                                )),
                                PopupMenuItem(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      color: Colors.black,
                                    ),
                                    FlatButton(
                                        onPressed: () {},
                                        child: Text("About Us"))
                                  ],
                                )),
                                PopupMenuItem(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: Colors.black,
                                    ),
                                    FlatButton(
                                        onPressed: () {
                                          logOut(context);
                                        },
                                        child: Text("Log Out"))
                                  ],
                                ))
                              ]),
                      // IconButton(
                      //     onPressed: () {
                      //       logOut(context);
                      //     },
                      //     icon: const Icon(
                      //       Icons.settings,
                      //       size: 30,
                      //     ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg"),
                              fit: BoxFit.fill),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello ${loggedInUser.name}",
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Let's explore all the features here",
                              style: GoogleFonts.nunito(textStyle: style))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Powered by Headspace',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color(0xfff7a73e),
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tune in",
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w700))),
                              const SizedBox(
                                height: 8,
                              ),
                              Text("Videos tailored for you",
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[800])))
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageTransition(
                                  child: HomeScreen(),
                                  duration: Duration(milliseconds: 600),
                                  reverseDuration: Duration(milliseconds: 700),
                                  type: PageTransitionType.fade));
                            },
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: const Center(
                                  child: const Icon(Icons.play_arrow_rounded),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "Self Care",
                      style: GoogleFonts.nunito(textStyle: TextStyle()),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          "See All",
                          style: GoogleFonts.nunito(textStyle: TextStyle()),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 2,
                          width: 50,
                          decoration: BoxDecoration(color: Color(0xfff7a73e)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Songs()),
                                );
                              },
                              child: Container(
                                height: 64,
                                width: 64,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/images/" +
                                            images.keys.elementAt(index)),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(images.values.elementAt(index),
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w300),
                                ))
                          ],
                        ),
                      );
                    },
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("My 4 Am Friends",
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                      color: Color(0xff888BD9),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      Container(
                        height: 110,
                        width: 94,
                        decoration: const BoxDecoration(
                            image: const DecorationImage(
                                image: const AssetImage(
                                    "assets/images/flamingo.png"),
                                fit: BoxFit.fitHeight)),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("How are you feeling?",
                              style: GoogleFonts.nunito(
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                    color: Colors.black, width: 1.0)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Center(
                              child: Text(
                                "Talk Now",
                                style: GoogleFonts.nunito(),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 1, right: 1),
                child: Container(
                  width: size.width,
                  height: 80,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: BNBCustomPainter(),
                      ),
                      Center(
                        heightFactor: 0.6,
                        child: FloatingActionButton(
                            backgroundColor: Colors.amber,
                            child: Icon(Icons.play_arrow),
                            elevation: 0.1,
                            onPressed: () {
                              Navigator.of(context).push(PageTransition(
                                  child: HomeScreen(),
                                  duration: Duration(milliseconds: 600),
                                  reverseDuration: Duration(milliseconds: 700),
                                  type: PageTransitionType.fade));
                            }),
                      ),
                      Container(
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setBottomBarIndex(0);
                                },
                                splashColor: Colors.white,
                                icon: Icon(
                                  Icons.home,
                                  color: currentIndex == 0
                                      ? Colors.orange
                                      : Colors.grey.shade400,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(PageTransition(
                                      child: Songs(),
                                      duration: Duration(milliseconds: 600),
                                      reverseDuration:
                                          Duration(milliseconds: 700),
                                      type: PageTransitionType.fade));
                                  setBottomBarIndex(1);
                                },
                                icon: Icon(
                                  Icons.multitrack_audio_rounded,
                                  color: currentIndex == 1
                                      ? Colors.orange
                                      : Colors.grey.shade400,
                                )),
                            Container(
                              width: size.width * 0.20,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(PageTransition(
                                      child: Moods(),
                                      duration: Duration(milliseconds: 600),
                                      reverseDuration:
                                          Duration(milliseconds: 700),
                                      type: PageTransitionType.fade));
                                  setBottomBarIndex(2);
                                  _moodController.getMoods();
                                },
                                icon: Icon(
                                  Icons.insights,
                                  color: currentIndex == 2
                                      ? Colors.orange
                                      : Colors.grey.shade400,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(PageTransition(
                                      child: ChatPage(),
                                      duration: Duration(milliseconds: 600),
                                      reverseDuration:
                                          Duration(milliseconds: 700),
                                      type: PageTransitionType.fade));

                                  setBottomBarIndex(3);
                                },
                                icon: Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  color: currentIndex == 3
                                      ? Colors.orange
                                      : Colors.grey.shade400,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
