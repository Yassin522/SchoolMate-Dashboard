class Subject {
  String? id;
  String? name;
  String? grade;
  List? teachers;
  List? teachersname;

  Subject({this.name, this.grade, this.id, this.teachers, this.teachersname});
}

List subjects = [
  Subject(name: 'subject 1', grade: 'Grade1'),
  Subject(name: 'subject 2', grade: 'Grade1'),
  Subject(name: 'subject 3', grade: 'Grade1'),
  Subject(name: 'subject 4', grade: 'Grade1'),
  Subject(name: 'subject 5', grade: 'Grade2'),
  Subject(name: 'subject 6', grade: 'Grade2')
];
