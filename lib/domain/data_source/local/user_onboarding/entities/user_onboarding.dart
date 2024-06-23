import 'package:objectbox/objectbox.dart';

@Entity()
class UserOnboardingDB {
  int? id;

  String? type;

  @Unique(onConflict: ConflictStrategy.fail)
  String? email;

  String? password;

  String? name;

  UserOnboardingDB(
      {this.id = 0, this.name, this.email, this.password, this.type});

  UserOnboardingDB copyWith({
    int? id,
    String? type,
    String? email,
    String? password,
    String? name,
  }) {
    return UserOnboardingDB(
      id: id ?? this.id,
      type: type ?? this.type,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }
}
