import 'package:flutter/material.dart';
import 'package:flutter_application_4/Login/splash.dart';
import 'package:flutter_application_4/models/category/category_model.dart';
import 'package:flutter_application_4/models/transaction/transaction_model.dart';
import 'package:flutter_application_4/screens/add_transaction/screen_add_transation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/home/screen_home.dart';

Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primaryColor: Colors.blue),home: ScreenSplash(),routes: {
      ScreenAddTransaction.routeName:(ctx)=>const ScreenAddTransaction(),
    },);
  }
}