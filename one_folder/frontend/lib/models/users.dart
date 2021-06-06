class User {
  final int id;
  final String first_name;
  final String last_name;
  final bool is_active;
  final String function;
  final String email;
  final String username;
  // final String password;
  final String phone;
  final String cin;

  const User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.is_active,
      required this.function,
      required this.email,
      required this.username,
      // required this.password,
      required this.phone,
      required this.cin});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      // password: json['password'],
      cin: json['cin'],
      function: json['function'],
      is_active: json['is_active'],
    );
  }
  User copy({
    int? id,
    String? first_name,
    String? last_name,
    bool? is_active,
    String? function,
    String? email,
    String? username,
    String? password,
    String? phone,
    String? cin,
  }) =>
      User(
          id: id ?? this.id,
          cin: cin ?? this.cin,
          first_name: first_name ?? this.first_name,
          last_name: last_name ?? this.last_name,
          is_active: is_active ?? this.is_active,
          email: email ?? this.email,
          function: function ?? this.function,
          username: username ?? this.username,
          // password: password ?? this.password,
          phone: phone ?? this.phone);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          first_name == other.first_name &&
          last_name == other.last_name &&
          cin == other.cin &&
          phone == other.phone &&
          // password == other.password &&
          email == other.email &&
          // is_active == other.is_active &&
          username == other.username;
  // function == other.function &&

  @override
  int get hashCode =>
      id.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      username.hashCode ^
      // password.hashCode ^
      function.hashCode ^
      cin.hashCode ^
      is_active.hashCode;
}
