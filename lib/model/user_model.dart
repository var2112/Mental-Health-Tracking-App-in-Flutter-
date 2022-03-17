//Signup by Varun Kamble

class UserModel {
  String? uid;
  String? email;
  String? name;

  UserModel({this.uid, this.email, this.name});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
