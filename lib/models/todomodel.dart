import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

//to generate type adapter
//sync with todomodel adapter
part 'todomodel.g.dart';

//todo model calss
@HiveType(typeId: 2)
class ToDoModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  bool markAsDone;

  //generate random id
  ToDoModel(
      {String? id,
      required this.time,
      required this.title,
      required this.date,
      required this.markAsDone})
      : id = id ?? const Uuid().v4();
}
