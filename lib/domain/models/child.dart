import 'package:santas_list/domain/models/status.dart';

class Child {
  final int? id;
  final String name;
  final String country;
  Status status;

   Child({
    this.id,
    required this.name,
    required this.country,
    required this.status,
  });

  Child copyWith({
    int? id,
    String? name,
    String? country,
    Status? status,
  }) {
    return Child(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      status: status ?? this.status,
    );
  }
}
