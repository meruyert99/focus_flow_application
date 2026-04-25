class Repo {
  final studentBox = Hive.box('students');
  final activityBox = Hive.box('activities');

  List<Student> getStudents() => studentBox.values
      .map((e) => Student(id: e['id'], name: e['name']))
      .toList();

  void addStudent(String name) {
    studentBox.add({
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': name,
    });
  }

  void addActivity(int studentId) {
    activityBox.add({
      'id': DateTime.now().millisecondsSinceEpoch,
      'studentId': studentId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  List<Activity> getActivities() => activityBox.values.map((e) {
        return Activity(
          id: e['id'],
          studentId: e['studentId'],
          timestamp: DateTime.parse(e['timestamp']),
        );
      }).toList();
}
