import 'dart:convert';

BookMarkRes bookMarkResFromJson(String str) => BookMarkRes.fromJson(jsonDecode(str));

String bookMarkResToJson(BookMarkRes data) => jsonEncode(data.toJson());

class BookMarkRes {
  final String job;
  final String userId;
  final String id;

  BookMarkRes({
    required this.job,
    required this.userId,
    required this.id,
  });

  factory BookMarkRes.fromJson(Map<String, dynamic> json) => BookMarkRes(
    job: json["job"],
    userId: json["userId"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "job": job,
    "userId": userId,
    "_id": id,
  };
}