// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String name;
  String address;
  SocialMedia socialMedia;
  List<String> hobbies;

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.socialMedia,
    required this.hobbies,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    socialMedia: SocialMedia.fromJson(json["social_media"]),
    hobbies: List<String>.from(json["hobbies"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "social_media": socialMedia.toJson(),
    "hobbies": List<dynamic>.from(hobbies.map((x) => x)),
  };
}

class SocialMedia {
  String instagram;
  String twitter;

  SocialMedia({required this.instagram, required this.twitter});

  factory SocialMedia.fromJson(Map<String, dynamic> json) =>
      SocialMedia(instagram: json["instagram"], twitter: json["twitter"]);

  Map<String, dynamic> toJson() => {"instagram": instagram, "twitter": twitter};
}
