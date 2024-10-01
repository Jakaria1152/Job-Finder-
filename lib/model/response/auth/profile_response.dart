import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  final String id;
  final String username;
  final String email;
  final bool? isAdmin; // Changed to nullable
  final bool? isAgent; // Changed to nullable
  final List<String> skills;
  final String profile;
  final String location;
  final String? phone; // Changed to nullable

  ProfileResponse({
    required this.id,
    required this.username,
    required this.email,
    this.isAdmin, // Changed
    this.isAgent, // Changed
    required this.skills,
    required this.profile,
    required this.location,
    this.phone, // Changed
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    isAdmin: json["isAdmin"] ?? false, // Default to false if not present
    isAgent: json["isAgent"] ?? false, // Default to false if not present
    skills: List<String>.from(json["skills"].map((x) => x)),
    profile: json["profile"],
    location: json["location"],
    phone: json["phone"], // Will be null if not present
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "isAdmin": isAdmin,
    "isAgent": isAgent,
    "skills": List<dynamic>.from(skills.map((x) => x)),
    "profile": profile,
    "location": location,
    "phone": phone,
  };
}
