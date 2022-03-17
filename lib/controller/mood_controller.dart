//Mood Tracker by Dhananjay Tore

import 'package:get/get.dart';
import 'package:my_space/db/db_helper.dart';
import 'package:my_space/model/moods.dart';

class MoodController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var moodList = <Mood>[].obs;

  void getMoods() async {
    List<Map<String, dynamic>> moods1 = await DBHelper.query();
    moodList.assignAll(moods1.map((data) => new Mood.fromJson(data)).toList());
  }

  Future<int> addMood({Mood? mood}) async {
    return await DBHelper.insert(mood);
  }

  void delete(Mood mood) {
    DBHelper.delete(mood);
  }
}
