import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:student_model/domain/home/home_service.dart';
import 'package:student_model/domain/home/model/home_model.dart';

class HomeImpl extends HomeService with ChangeNotifier {
  String dbName = 'HomeDb';
  List<HomeModel> listNotifier = [];

  @override
  Future<void> addDetails(HomeModel value) async {
    final obj = await Hive.openBox<HomeModel>(dbName);
    await obj.put(value.id, value);
  }

  @override
  Future<void> getAllDetails() async {
    final obj = await Hive.openBox<HomeModel>(dbName);
    listNotifier.clear();
    listNotifier.addAll(obj.values.toList().reversed);
    notifyListeners();
  }

  @override
  Future<void> updateDetails(HomeModel value) async {
    final obj = await Hive.openBox<HomeModel>(dbName);
    obj.put(value.id, value);
    getAllDetails();
  }

  @override
  Future<void> deleteDetails(String value) async {
    final obj = await Hive.openBox<HomeModel>(dbName);
    obj.delete(value);
    getAllDetails();
  }
}
