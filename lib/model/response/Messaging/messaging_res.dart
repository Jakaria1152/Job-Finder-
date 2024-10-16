// To parse this JSON data, do
//
//     final receivedMessage = receivedMessageFromJson(jsonString);

import 'dart:convert';

List<ReceivedMessages> receivedMessagesFromJson(String str) => List<ReceivedMessages>.from(json.decode(str).map((x) => ReceivedMessages.fromJson(x)));


class ReceivedMessages {
  final String id;
  final Sender sender;
  final String content;
  final String? receiver;
  final Chat? chat;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ReceivedMessages({
    required this.id,
    required this.sender,
    required this.content,
    this.receiver,
    this.chat,
    this.createdAt,
    this.updatedAt,
  });

  factory ReceivedMessages.fromJson(Map<String, dynamic> json) => ReceivedMessages(
    id: json["_id"],
    sender: Sender.fromJson(json["sender"]),
    content: json["content"],
    receiver: json["receiver"],
    chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender.toJson(),
    "content": content,
    "receiver": receiver,
    "chat": chat?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Chat {
  final String? id;
  final String? chatName;
  final bool? isGroup;
  final List<User>? users;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? latestMessage;

  Chat({
    this.id,
    this.chatName,
    this.isGroup,
    this.users,
    this.createdAt,
    this.updatedAt,
    this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["_id"],
    chatName: json["chatName"],
    isGroup: json["isGroup"],
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    latestMessage: json["latestMessage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatName": chatName,
    "isGroup": isGroup,
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "latestMessage": latestMessage,
  };
}

class User {
  final String? id;
  final String? username;
  final String? email;
  final String? profile;

  User({
    this.id,
    this.username,
    this.email,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "profile": profile,
  };
}

class Sender {
  final String id;
  final String? username;
  final String? email;
  final String? profile;

  Sender({
    required this.id,
    this.username,
    this.email,
    this.profile,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "profile": profile,
  };
}


