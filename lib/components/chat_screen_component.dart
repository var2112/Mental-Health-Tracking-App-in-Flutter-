import 'dart:math';

import 'package:flutter/material.dart';

class ChatScreenComponent extends StatefulWidget {
  const ChatScreenComponent({Key? key}) : super(key: key);

  @override
  State<ChatScreenComponent> createState() => _ChatScreenComponentState();
}

class _ChatScreenComponentState extends State<ChatScreenComponent> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();

    var _work;
    return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black, width: 1.5)),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Text("hello");
                  })),
          SizedBox(
            height: 24,
          ),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _textEditingController,
                  onSubmitted: (v) {
                    print(v);
                  },
                  onEditingComplete: () {
                    print("onEditing Completed");
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type your messages..."),
                )),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    if (_textEditingController.text.isNotEmpty) {
                      getText(_textEditingController.text);
                      _textEditingController.text = "";
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellow[600],
                          border: Border.all(color: Colors.black, width: 1.5)),
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Center(
                          child: Icon(
                            Icons.send,
                            size: 20,
                          ),
                        ),
                      )),
                )
              ],
            ),
          )
        ]));
  }

  static getText(String chatText) {
    List _work = chatText as List;
    print(_work);
  }
}
