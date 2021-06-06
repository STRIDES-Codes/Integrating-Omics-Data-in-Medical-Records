import 'package:frontend/models/patients.dart';

is_mine(doctor, patients) {
  final List<Patient> mine = [];
  for (var patient in patients) {
    // print(patient.doctor);
    // print(doctor);
    if (patient.doctor_id.hashCode == doctor.hashCode) {
      // print(doctor);
      // print(patient.doctor);
      mine.add(patient);
    } else {
      print("none");
    }
  }
  return mine;
}
