import 'dart:convert';

class ProfileUpdateModel{
  final String location;
  final String phone;
  final String profile;
  final List<String> skills;

  ProfileUpdateModel({required this.location,
    required this.phone,
    required this.profile,
    required this.skills});

  factory ProfileUpdateModel.fromMap(Map<String,dynamic> json)
  {
    return ProfileUpdateModel(
        location: json['location'],
        phone: json['phone'],
        profile: json['profile'],
        skills: List<String>.from(json['skills']??[])
    );
  }
  Map<String,dynamic> toMap()=>{
    "location":location,
    "phone" : phone,
    "profile": profile,
    "skills": skills
  };

  String toJson()=> jsonEncode(toMap());
  factory ProfileUpdateModel.fromJson(String source)=> ProfileUpdateModel.fromMap(jsonDecode(source));

}