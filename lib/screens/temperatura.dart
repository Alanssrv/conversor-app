import 'package:conversornafec/widgets/custom_drawer.dart';
import 'package:conversornafec/widgets/text_form.dart';
import 'package:flutter/material.dart';

class Temperatura extends StatefulWidget {

  final PageController pageController;
  final Color color;

  const Temperatura({@required this.pageController, @required this.color});

  @override
  _TemperaturaState createState() => _TemperaturaState();
}

class _TemperaturaState extends State<Temperatura> {

  TextEditingController celsiusController = TextEditingController();
  TextEditingController farenheitController = TextEditingController();
  TextEditingController kelvinController = TextEditingController();

  void _reset(){
    celsiusController.clear();
    farenheitController.clear();
    kelvinController.clear();
  }

  void _celsiusChanged(String text) {
    if (text.isEmpty) {
      _reset();
      return ;
    }
    double value = double.parse(text);
    farenheitController.text = (1.8 * value + 32).toStringAsPrecision(4);
    kelvinController.text = (value + 273).toStringAsPrecision(4);
  }

  void _farenheitChanged(String text) {
    if (text.isEmpty) {
      _reset();
      return ;
    }
    double value = double.parse(text);
    celsiusController.text = ((value-32)/1.8).toStringAsPrecision(4);
    kelvinController.text = (((value-32)/1.8) + 273).toStringAsPrecision(4);
  }

  void _kelvinChanged(String text) {
    if (text.isEmpty) {
      _reset();
      return ;
    }
    double value = double.parse(text);
    celsiusController.text = (value-273).toStringAsPrecision(4);
    farenheitController.text = ((value-273) + 32).toStringAsPrecision(4);
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    List<Map<String, dynamic>> list = [
      {
        'controller': celsiusController,
        'label': "Celcius (ºC)",
        'function': _celsiusChanged
      },
      {
        'controller': farenheitController,
        'label': "Farenheit (ºF)",
        'function': _farenheitChanged
      },
      {
        'controller': kelvinController,
        'label': "Kelvin (ºK)",
        'function': _kelvinChanged
      }
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(widget.pageController),
      appBar: AppBar(
        title: Text(
          "Temperatura",
          style: TextStyle(
            color: widget.color,
            fontWeight: FontWeight.w300
          ),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: widget.color,
            ),
            onPressed: (){
              _reset();
            }
          ),
        ],
        leading: IconButton(
          icon: new Icon(
            Icons.dehaze,
            color: widget.color,
          ),
          onPressed: () => (_scaffoldKey.currentState.openDrawer()),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black54
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child:ListView(
          children: <Widget>[
            Form(
              child: TextForm(list: list, color: widget.color),
            )
          ],
        ),
      ),
    );
  }
}

