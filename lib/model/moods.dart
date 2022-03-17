//Mood Tracker by Dhananjay Tore

class Mood {
  int? id;
  String? title;
  String? feeling;
  String? date;
  String? time;
  int? color;

  Mood({this.id, this.title, this.feeling, this.date, this.time, this.color});

  Mood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    feeling = json['feeling'];
    date = json['date'];
    time = json['time'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['feeling'] = this.feeling;
    data['date'] = this.date;
    data['time'] = this.time;
    data['color'] = this.color;
    return data;
  }
}
