//note model class
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

//to generate type adapter
//sync with notemodel adapter
part 'notemodel.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final DateTime dateTime;

  //generate random id
  NoteModel(
      {String? id,
      required this.category,
      required this.title,
      required this.description,
      required this.dateTime})
      : id = id ?? const Uuid().v4();
}
