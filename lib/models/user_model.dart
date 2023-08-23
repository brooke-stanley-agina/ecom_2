import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;

  const User({
    this.id,
    this.fullName = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.country = '',
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? address,
    String? city,
    String? country,
  }) {
    return User(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        address: address ?? this.address,
        city: city ?? this.city,
        country: country ?? this.country);
  }

  factory User.fromSnapshot(DocumentSnapshot snap) {
    return User(
      id: snap.id,
      fullName: snap['fullName'],
      email: snap['email'],
      address: snap['address'],
      city: snap['city'],
      country: snap['country'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'fullName': fullName!,
      'email': email!,
      'address': address!,
      'city': city!,
      'country': country!
    };
  }

  @override
  List<Object?> get props => [id, fullName, email, address, city, country];
}
