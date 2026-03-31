import 'package:equatable/equatable.dart';

class SignUpRequest extends Equatable {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String avatar;

  const SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.avatar,
  });

  @override
  List<Object?> get props => [name, email, password, phone, avatar];
}