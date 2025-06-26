import 'package:flutter/material.dart';
import 'package:practice_api/pro.dart';
import 'PostApi.dart';
import 'complexApi.dart';
import 'exomerce.dart';
import 'imageuploadonserver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:   EcomerceApi( ),
    );
  }
}


