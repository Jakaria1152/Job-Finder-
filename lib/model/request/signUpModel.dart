import 'dart:convert';

class SignUpModel{
  final String username;
  final String email;
  final String password;

  SignUpModel({required this.email, required this.password,required this.username});

  factory SignUpModel.fromMap(Map<String,dynamic> json)
  {
    return SignUpModel(
      username: json['username'],
        email: json['email'],
        password: json['password']
    );
  }
  Map<String,dynamic> toMap()=>{
    "username":username,
    "email":email,
    "password": password
  };

  String toJson()=> jsonEncode(toMap());
  factory SignUpModel.fromJson(String source)=> SignUpModel.fromMap(jsonDecode(source));

}