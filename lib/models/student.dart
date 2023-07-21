class Student {
  var id;
  String firstName;
  String lastName;
  String email;
  var average;
  String? fatherName;
  String? motherName;
  String? parentEmail;
  String? parentPhone;
  String? additional;
  String? studentGrade;
  String? studentClass;
  String? studentClassref;
  String? fees;
  String? phone;
  bool exists;

  Student({
    required this.firstName,
    required this.lastName,
    this.email = '',
     this.average,
     this.fatherName,
     this.motherName,
     this.parentEmail,
     this.parentPhone,
     this.studentGrade,
     this.studentClass,
    this.additional = '',
    this.studentClassref,
    this.fees,
    this.id,
    this.phone,
    this.exists=true
  });
}

List students = [
  Student(
      firstName: 'firstName',
      lastName: 'lastName',
      average: 50,
      fatherName: 'fatherName',
      motherName: 'motherName',
      parentEmail: 'parentEmail',
      parentPhone: 'parentPhone',
      studentGrade: 'studentGrade',
      studentClass: 'studentClass'),
  Student(
      firstName: 'firstName',
      lastName: 'lastName',
      average: 50,
      fatherName: 'fatherName',
      motherName: 'motherName',
      parentEmail: 'parentEmail',
      parentPhone: 'parentPhone',
      studentGrade: 'studentGrade',
      studentClass: 'studentClass'),
  Student(
      firstName: 'firstName',
      lastName: 'lastName',
      average: 50,
      fatherName: 'fatherName',
      motherName: 'motherName',
      parentEmail: 'parentEmail',
      parentPhone: 'parentPhone',
      studentGrade: 'studentGrade',
      studentClass: 'studentClass'),
  Student(
      firstName: 'firstName',
      lastName: 'lastName',
      average: 50,
      fatherName: 'fatherName',
      motherName: 'motherName',
      parentEmail: 'parentEmail',
      parentPhone: 'parentPhone',
      studentGrade: 'studentGrade',
      studentClass: 'studentClass'),
  Student(
      firstName: 'firstName',
      lastName: 'lastName',
      average: 50,
      fatherName: 'fatherName',
      motherName: 'motherName',
      parentEmail: 'parentEmail',
      parentPhone: 'parentPhone',
      studentGrade: 'studentGrade',
      studentClass: 'studentClass')
];
