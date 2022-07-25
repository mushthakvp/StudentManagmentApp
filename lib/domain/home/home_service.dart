import 'package:student_model/domain/home/model/home_model.dart';

abstract class HomeService {
  Future<void> addDetails(HomeModel value);
  Future<void> getAllDetails();
  Future<void> updateDetails(HomeModel value);
  Future<void> deleteDetails(String value);
}
