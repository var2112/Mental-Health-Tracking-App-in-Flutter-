//Mood Tracker by Dhananjay Tore

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_space/controller/mood_controller.dart';
import 'package:my_space/model/add_moods.dart';
import 'package:my_space/model/moods.dart';
import 'package:my_space/pages/home_page.dart';
import 'package:my_space/services/notification_service.dart';
import 'package:my_space/widgets/mood_tile.dart';
import 'package:page_transition/page_transition.dart';

class Moods extends StatefulWidget {
  const Moods({Key? key}) : super(key: key);

  @override
  _MoodsState createState() => _MoodsState();
}

class _MoodsState extends State<Moods> {
  var notifyHelper;
  final _moodController = Get.put(MoodController());
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: Colors.orange,
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
                Text("Track your mood",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/sleepy_emoji.png"),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: subHeadingStyle,
                      ),
                      Text(
                        "Today",
                        style: headingStyle,
                      ),
                    ],
                  ),
                ),
                //MyButton(label: "+ Add Mood", onTap: () => null)
                FlatButton(
                    onPressed: () async {
                      await //Get.to(() => AddMood());
                          await Navigator.of(context).push(PageTransition(
                              child: AddMood(),
                              duration: Duration(milliseconds: 600),
                              reverseDuration: Duration(milliseconds: 700),
                              type: PageTransitionType.rightToLeftWithFade));
                      _moodController.getMoods();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Text(
                      "+ Add Mood",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.blue,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              dayTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
          ),
          _showMoods(),
        ],
      ),
    );
  }

  _showMoods() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _moodController.moodList.length,
            itemBuilder: (_, index) {
              print(_moodController.moodList.length);
              Mood mood = _moodController.moodList[index];
              if (mood.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showSheet(context, mood);
                                print("Tapped");
                              },
                              child: MoodTile(mood),
                            )
                          ],
                        ),
                      ),
                    ));
              } else {
                return Container();
              }
            });
      }),
    );
  }

  _bottonSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
            child: Text(label,
                style: isClose == true
                    ? titleStyle.copyWith(color: Colors.black)
                    : titleStyle.copyWith(color: Colors.white))),
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: isClose == true ? Colors.transparent : clr,
            border: Border.all(
                width: 2, color: isClose == true ? Colors.black : clr),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  showSheet(BuildContext context, Mood mood) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: MediaQuery.of(context).size.height * 0.24,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]),
          ),
          SizedBox(
            height: 15,
          ),
          _bottonSheetButton(
              label: "Delete Mood",
              onTap: () {
                _moodController.delete(mood);
                _moodController.getMoods();
                Get.back();
              },
              clr: Colors.red,
              context: context),
          SizedBox(
            height: 22,
          ),
          _bottonSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.black,
              isClose: true,
              context: context)
        ],
      ),
    ));
  }
}



// return Container(
//                 width: 100,
//                 height: 50,
//                 color: Colors.grey,
//                 margin: EdgeInsets.only(bottom: 10),
//                 child: Text(_moodController.moodList[index].title.toString()),
//               );