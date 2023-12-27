import 'package:equatable/equatable.dart';

class ContactParamEntity extends Equatable {

  const ContactParamEntity({
    this.limit,
    this.page,
    this.name
  });

  final int? page;
  final int? limit;
  final String? name;

  ContactParamEntity copyWith({
    int? page,
    int? limit,
    String? name,
  }) => ContactParamEntity(
    page: page ?? this.page,
    limit: limit ?? this.limit,
    name : name ?? this.name
  );

  Map<String, dynamic> toJsonParam() => {
    'page' : page,
    'limit' : limit,
  };

  Map<String, dynamic> toJsonParamSearch() => {
    'name' : name
  };

  @override
  List<Object?> get props => [
    page,
    limit,
    name,
  ];

}
