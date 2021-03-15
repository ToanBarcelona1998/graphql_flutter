import 'dart:io';
import 'package:demo_grahql_flutter/views/graphql_demo.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.init(directory.path);
  await Hive.openBox("mybox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GrapHqlDemo(),
    );
  }
}

