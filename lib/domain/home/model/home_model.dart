import 'package:hive_flutter/hive_flutter.dart';
part 'home_model.g.dart';

@HiveType(typeId: 1)
class HomeModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String place;
  @HiveField(3)
  final String number;
  @HiveField(4)
  final String age;
  @HiveField(6)
  final String image;

  HomeModel({
    required this.id,
    required this.name,
    required this.place,
    required this.number,
    required this.age,
    required this.image,
  });
}
