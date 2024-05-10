import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
enum CategoryType{
  @HiveField(1)
  income,
  @HiveField(2)
  expense
}
@HiveType(typeId: 1)
class CategoryModel{
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CategoryType type;

  CategoryModel({required this.id,required this.name, this.isDeleted=false,required this.type});

  @override
  String toString() {
    // TODO: implement toString
    return '{$name  $type}';
  }
}