import 'package:hive/hive.dart';

class User{
  int? id;
  String? fullName;
  String? email;
  int? mobileNumber;


  User({this.id, this.fullName, this.email, this.mobileNumber});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["full_name"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email": email,
    "mobile_number": mobileNumber,
  };

}
