import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_model/domain/add/addphoto.dart';
import 'package:student_model/domain/home/model/home_model.dart';
import 'package:student_model/infrastructure/home/home_impliment.dart';
import 'package:student_model/presentation/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(HomeModelAdapter().typeId)) {
    Hive.registerAdapter(HomeModelAdapter());
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeImpl>(create: (BuildContext context) => HomeImpl()),
        ChangeNotifierProvider<AddPhotoPov>(create: (BuildContext context) => AddPhotoPov()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudentMangement',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}
