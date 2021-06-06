class Patient {
  final int? id;
  final String? first_name;
  final String? last_name;
  final bool vaccinated;
  final String? gender;
  final String? birthdate;
  final String? onset_date;
  final bool reinfected;
  final String? other_infections;
  final String? cin;
  final String? chronic_disease;
  final String? doctor;
  final int? doctor_id;

  const Patient(
      {required this.id,
      required this.doctor,
      required this.first_name,
      required this.last_name,
      required this.vaccinated,
      required this.gender,
      required this.birthdate,
      required this.chronic_disease,
      required this.onset_date,
      required this.cin,
      required this.reinfected,
      required this.doctor_id,
      required this.other_infections});
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json['id'],
        doctor: json['medecin_username'].toString(),
        first_name: json['first_name'].toString(),
        last_name: json['last_name'].toString(),
        vaccinated: json['vaccinated'],
        gender: json['gender'].toString(),
        birthdate: json['birthdate'].toString(),
        cin: json['cin'].toString(),
        chronic_disease: json['chronic_disease'].toString(),
        other_infections: json['other_infections'].toString(),
        onset_date: json['onset_date'].toString(),
        reinfected: json['reinfected'],
        doctor_id: json['doctor']);
  }
  Patient copy(
          {int? id,
          String? first_name,
          String? last_name,
          bool? vaccinated,
          bool? reinfected,
          String? gender,
          String? cin,
          String? birthdate,
          String? onset_date,
          String? doctor,
          String? chronic_disease,
          String? other_infections,
          int? doctor_id}) =>
      Patient(
          id: id ?? this.id,
          cin: cin ?? this.cin,
          first_name: first_name ?? this.first_name,
          last_name: last_name ?? this.last_name,
          vaccinated: vaccinated ?? this.vaccinated,
          reinfected: reinfected ?? this.reinfected,
          gender: gender ?? this.gender,
          doctor_id: doctor_id ?? this.doctor_id,
          doctor: doctor ?? this.doctor,
          birthdate: birthdate ?? this.birthdate,
          onset_date: onset_date ?? this.onset_date,
          chronic_disease: chronic_disease ?? this.chronic_disease,
          other_infections: other_infections ?? this.other_infections);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Patient &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          first_name == other.first_name &&
          last_name == other.last_name &&
          cin == other.cin &&
          reinfected == other.reinfected &&
          doctor == other.doctor &&
          other_infections == other.other_infections &&
          birthdate == other.birthdate &&
          onset_date == other.onset_date &&
          chronic_disease == other.chronic_disease &&
          vaccinated == other.vaccinated &&
          doctor_id == other.doctor_id &&
          gender == other.gender;

  @override
  int get hashCode =>
      id.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      reinfected.hashCode ^
      doctor.hashCode ^
      chronic_disease.hashCode ^
      onset_date.hashCode ^
      birthdate.hashCode ^
      doctor_id.hashCode ^
      other_infections.hashCode ^
      gender.hashCode ^
      cin.hashCode ^
      vaccinated.hashCode;
}
