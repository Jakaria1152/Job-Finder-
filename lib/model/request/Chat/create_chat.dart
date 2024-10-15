// To parse this JSON data, do
//
//     final createChat = createChatFromJson(jsonString);
/*
{
    "userId": "66fcd2d58002a13228932b01"
}
this json convert to dart https://app.quicktype.io/ this website( turn off Types only)
 */
import 'dart:convert';

CreateChat createChatFromJson(String str) => CreateChat.fromJson(json.decode(str));

String createChatToJson(CreateChat data) => json.encode(data.toJson());

class CreateChat {
  String userId;

  CreateChat({
    required this.userId,
  });

  factory CreateChat.fromJson(Map<String, dynamic> json) => CreateChat(
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
  };
}
