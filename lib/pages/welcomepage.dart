//WelcomePage by Varun Kamble

import 'package:flutter/material.dart';
import 'package:my_space/pages/loginpage.dart';
import 'package:my_space/pages/signup_page.dart';
import 'package:page_transition/page_transition.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/well_background.gif',
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            child: SignUpPage(),
                            duration: Duration(milliseconds: 600),
                            reverseDuration: Duration(milliseconds: 700),
                            type: PageTransitionType.fade));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Color(0xfff7a73e),
                      splashColor: Colors.yellow[400],
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                      child: Text(
                        "Sign Up For Free",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(PageTransition(
                              child: LoginPage(),
                              duration: Duration(milliseconds: 600),
                              reverseDuration: Duration(milliseconds: 700),
                              type: PageTransitionType.rightToLeftWithFade));
                        },
                        child: Text(
                          "Already got an account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        )),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
