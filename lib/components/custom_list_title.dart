//Songs by Bhumika Vesvikar

import 'package:flutter/material.dart';

Widget customListTile(
    {required String title,
    required String singer,
    required String cover,
    onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: [
            Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.black, width: 1.5),
                  image: DecorationImage(
                      image: NetworkImage(cover), fit: BoxFit.fill)),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  singer,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
