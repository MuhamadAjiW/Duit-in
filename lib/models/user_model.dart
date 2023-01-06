import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String uid;
  final String email;
  final String name;

  UserModel({
    required this.uid,
    required this.email,
    required this.name
  });

  @override
  List<Object?> get props {
    return [uid, email, name];
  }
}