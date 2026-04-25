abstract class Event {}
class Load extends Event {}
class AddStudent extends Event { final String name; AddStudent(this.name); }
class AddAct extends Event { final int id; AddAct(this.id); }
class Filter extends Event { final int? studentId; Filter(this.studentId); }

abstract class State {}
class Init extends State {}
class Loaded extends State {
  final List<Student> students;
  final List<Activity> activities;
  final int? filterId;

  Loaded(this.students, this.activities, this.filterId);
}

class AppBloc extends Bloc<Event, State> {
  final repo = Repo();
  int? filterId;

  AppBloc() : super(Init()) {
    on<Load>((e, emit) {
      emit(Loaded(repo.getStudents(), repo.getActivities(), filterId));
    });

    on<AddStudent>((e, emit) {
      repo.addStudent(e.name);
      add(Load());
    });

    on<AddAct>((e, emit) {
      repo.addActivity(e.id);
      add(Load());
    });

    on<Filter>((e, emit) {
      filterId = e.studentId;
      add(Load());
    });
  }
}
