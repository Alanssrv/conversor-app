import 'package:conversornafec/screens/moeda.dart';
import 'package:conversornafec/screens/temperatura.dart';
import 'package:conversornafec/screens/velocidade.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor NAFeC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Velocidade(pageController: _pageController, color: Colors.red,),
            Temperatura(pageController: _pageController, color: Colors.blue),
            Moeda(pageController: _pageController, color: Colors.orange,),
          ],
        ),
      )
    );
  }
}