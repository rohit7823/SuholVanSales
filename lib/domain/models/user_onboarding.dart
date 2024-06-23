class UserOnboarding {
  final String? type;

  final String? email;

  final String? password;

  final String? name;

  UserOnboarding({this.type, this.password, this.email, this.name});

  UserOnboarding copyWith({
    String? type,
    String? email,
    String? password,
    String? name,
  }) {
    return UserOnboarding(
      type: type ?? this.type,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }
}
