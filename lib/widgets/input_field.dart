//Mood Tracker by Dhananjay Tore

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_space/services/notification_service.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            margin: EdgeInsets.only(top: 4.0),
            height: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 1.0)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  cursorColor: Colors.white,
                  controller: controller,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: GoogleFonts.nunito(
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    focusedBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 8, top: 8, right: 15),
                  ),
                )),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
