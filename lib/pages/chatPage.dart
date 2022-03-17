import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_space/components/chat_screen_component.dart';
import 'package:my_space/pages/home_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

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
                      color: Color(0xff888BD9),
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
                Text("Cope with Pain",
                    style: GoogleFonts.manrope(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    )),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChatScreenComponent()))
        ],
      ),
    );
  }
}
