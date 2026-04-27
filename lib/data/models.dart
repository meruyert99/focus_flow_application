class Student {
  final int id;
  final String name;
  Student({required this.id, required this.name});
}

class Activity {
  final int id;
  final int studentId;
  final DateTime timestamp;

  Activity({required this.id, required this.studentId, required this.timestamp});
}
