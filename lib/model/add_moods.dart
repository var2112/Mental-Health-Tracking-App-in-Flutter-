//Mood Tracker by Dhananjay Tore

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_space/controller/mood_controller.dart';
import 'package:my_space/model/moods.dart';
import 'package:my_space/services/notification_service.dart';
import 'package:my_space/ui/moodsDatabase.dart';
import 'package:my_space/widgets/input_field.dart';

class AddMood extends StatefulWidget {
  const AddMood({Key? key}) : super(key: key);

  @override
  State<AddMood> createState() => _AddMoodState();
}

class _AddMoodState extends State<AddMood> {
  final MoodController _moodController = Get.put(MoodController());
  final TextEditingController _titleController = new TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _time = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _selectedFeeling = "Calm";
  List<String> feelingList = [
    'Calm',
    'Relaxed',
    'Enthusiastic',
    'Confident',
    'Focused',
    'Energetic',
    'Cheerful',
    'Proud'
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/addMoods.gif',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Moods()),
                            );
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          )),
                      Text("Add your mood",
                          style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyInputField(
                        title: "Title",
                        hint: "Enter title",
                        controller: _titleController,
                      ),
                      MyInputField(
                          title: 'How are you feeling?',
                          hint: "$_selectedFeeling",
                          widget: DropdownButton(
                            items: feelingList.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(value.toString()),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedFeeling = newValue!;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 32,
                            ),
                            elevation: 4,
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(color: Colors.black)),
                            underline: Container(
                              height: 0,
                            ),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: MyInputField(
                              title: "Date",
                              hint: DateFormat.yMd().format(_selectedDate),
                              widget: IconButton(
                                icon: Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  print("Hi there");
                                  getDateFromUser();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: MyInputField(
                            title: "Time",
                            hint: _time,
                            widget: IconButton(
                              onPressed: () {
                                getTimeFromUser();
                              },
                              icon: Icon(
                                Icons.access_time_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rate your mood",
                            style: titleStyle,
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            children: List<Widget>.generate(5, (int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = index;
                                  });
                                  print(_selectedColor);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 4),
                                  child: (Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 115,
                                    decoration: BoxDecoration(
                                      color: index == 0
                                          ? Colors.green
                                          : index == 1
                                              ? Colors.deepPurple
                                              : index == 2
                                                  ? Colors.orange
                                                  : index == 3
                                                      ? Colors.red[900]
                                                      : index == 4
                                                          ? Color(0xff924b0c)
                                                          : index ==
                                                                  _selectedColor
                                                              ? Colors.grey[900]
                                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Text(
                                      index == 0
                                          ? "Great"
                                          : index == 1
                                              ? "Good"
                                              : index == 2
                                                  ? "Okay"
                                                  : index == 3
                                                      ? "Bad"
                                                      : "Awful",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: FlatButton(
                            onPressed: () {
                              validateTitle();
                            },
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 25),
                            child: Text(
                              "Create Mood",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  validateTitle() {
    if (_titleController.text.isEmpty) {
      Get.snackbar("Required", "Please enter a title",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red,
          icon: Icon(Icons.warning_amber_outlined));
    } else if (_titleController.text.isNotEmpty) {
      addMoodToDb();
      Get.back();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Moods()));
    }
  }

  getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Its null or something is wrong");
    }
  }

  getTimeFromUser() async {
    var _pickedTime = await _showTimePicker();
    String _formattedTime = _pickedTime.format(context);
    if (_pickedTime == null) {
      print("Time cancelled");
    }
    setState(() {
      _time = _formattedTime;
    });
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_time.split(":")[0]),
            minute: int.parse(_time.split(":")[1].split(" ")[0])));
  }

  addMoodToDb() async {
    int value = await _moodController.addMood(
        mood: Mood(
            title: _titleController.text,
            feeling: _selectedFeeling,
            date: DateFormat.yMd().format(_selectedDate),
            time: _time,
            color: _selectedColor));

    print("My is is" + "$value");
  }
}
