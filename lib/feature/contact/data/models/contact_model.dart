import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {

  const ContactModel({
    this.avatar,
    this.createdAt,
    this.email,
    this.gender,
    this.id,
    this.name,
    this.numberPhone,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    avatar: json['avatar'],
    createdAt: json['createdAt'],
    email: json['email'],
    gender: json['gender'],
    id: json['id'],
    name: json['name'],
    numberPhone: json['numberPhone'],
  );

  ContactModel copyWith({
    String? createdAt,
    String? name,
    String? avatar,
    String? email,
    String? numberPhone,
    String? id,
    String? gender,
  }) => ContactModel(
    avatar: avatar ?? this.avatar,
    createdAt: createdAt ?? this.createdAt,
    email: email ?? this.email,
    numberPhone: numberPhone ?? this.numberPhone,
    id: id ?? this.id,
    gender: gender ?? this.gender,
    name: name ?? this.name
  );

  Map<String, dynamic> toJson() => {
    'email' : email,
    'createdAt' : createdAt,
    'name' : name,
    'gender' : gender,
    'id' : id,
    'numberPhone' : numberPhone,
    'avatar' : avatar
  };

  final String? createdAt;
  final String? name;
  final String? avatar;
  final String? email;
  final String? numberPhone;
  final String? id;
  final String? gender;

  @override
  List<Object?> get props => [
    avatar,
    createdAt,
    gender,
    email,
    name,
    numberPhone,
    id,
  ];

}