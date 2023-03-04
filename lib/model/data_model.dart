import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String phnNumber;

  @HiveField(5)
  final String photo;

  StudentModel(
      {required this.name,
      required this.age,
      required this.address,
      required this.phnNumber,
      required this.photo,
      this.id});
}
