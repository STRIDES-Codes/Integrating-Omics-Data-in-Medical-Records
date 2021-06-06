class Doctor {
  final int id;
  final String first_name;
  final String last_name;
  final bool is_active;
  final String function;
  final String email;
  final String username;
  final String phone;
  final String cin;
  final String id_pro;
  final int user;

  const Doctor(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.is_active,
      required this.function,
      required this.email,
      required this.username,
      required this.phone,
      required this.cin,
      required this.id_pro,
      required this.user});
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      cin: json['cin'],
      function: json['function'],
      is_active: json['is_active'],
      user: json['user'],
      id_pro: json['id_pro'],
    );
  }
  Doctor copy({
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
    String? hospital,
    int? hospital_id,
    String? id_pro,
    String? hospital_city,
    int? user,
  }) =>
      Doctor(
          id: id ?? this.id,
          cin: cin ?? this.cin,
          first_name: first_name ?? this.first_name,
          last_name: last_name ?? this.last_name,
          is_active: is_active ?? this.is_active,
          email: email ?? this.email,
          function: function ?? this.function,
          username: username ?? this.username,
          id_pro: id_pro ?? this.id_pro,
          user: user ?? this.user,
          phone: phone ?? this.phone);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Doctor &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          first_name == other.first_name &&
          last_name == other.last_name &&
          cin == other.cin &&
          phone == other.phone &&
          // password == other.password &&
          email == other.email &&
          // is_active == other.is_active &&
          username == other.username &&
          id_pro == other.id_pro;
  // function == other.function &&

  @override
  int get hashCode =>
      id.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      username.hashCode ^
      user.hashCode ^
      id_pro.hashCode ^
      function.hashCode ^
      cin.hashCode ^
      is_active.hashCode;
}
