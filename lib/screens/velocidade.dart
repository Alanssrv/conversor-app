import 'package:conversornafec/widgets/custom_drawer.dart';
import 'package:conversornafec/widgets/text_form.dart';
import 'package:flutter/material.dart';

class Velocidade extends StatefulWidget {

  final PageController pageController;
  final Color color;

  const Velocidade({@required this.pageController, @required this.color});

  @override
  _VelocidadeState createState() => _VelocidadeState();
}

class _VelocidadeState extends State<Velocidade> {

  TextEditingController kmhController = TextEditingController();
  TextEditingController msController = TextEditingController();
  TextEditingController mphController = TextEditingController();
  TextEditingController noController = TextEditingController();

  void _reset(){
    kmhController.clear();
    msController.clear();
    mphController.clear();
    noController.clear();
  }

  void _kmhChanged(String text){
    if(text.isEmpty){
      _reset();
      return ;
    }
    double value = double.parse(text);
    msController.text = (value / 3.6).toStringAsPrecision(4);
    mphController.text = (value * 0.6213).toStringAsPrecision(4);
    noController.text = (value * 1.852).toStringAsPrecision(4);
  }

  void _msChanged(String text){
    if(text.isEmpty){
      _reset();
      return ;
    }
    double value = double.parse(text);
    kmhController.text = (value * 3.6).toStringAsPrecision(4);
    mphController.text = ((value * 3.6) * 0.6213).toStringAsPrecision(4);
    noController.text = ((value * 3.6) * 1.852).toStringAsPrecision(4);
  }

  void _mphChanged(String text){
    if(text.isEmpty){
      _reset();
      return ;
    }
    double value = double.parse(text);
    kmhController.text = (value * 1.6093).toStringAsPrecision(4);
    msController.text = ((value * 1.6093) / 3.6).toStringAsPrecision(4);
    noController.text = ((value * 1.6093) * 1.852).toStringAsPrecision(4);
  }

  void _noChanged(String text){
    if(text.isEmpty){
      _reset();
      return ;
    }
    double value = double.parse(text);
    kmhController.text = (value / 1.852).toStringAsPrecision(4);
    msController.text = ((value / 1.852) / 3.6).toStringAsPrecision(4);
    mphController.text = ((value / 1.852) * 0.6213).toStringAsPrecision(4);
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    List<Map<String, dynamic>> list = [
      {
        'controller': kmhController,
        'label': "Quilômetro por hora (Km/h)",
        'function': _kmhChanged
      },
      {
        'controller': msController,
        'label': "Metro por segundo (m/s)",
        'function': _msChanged
      },
      {
        'controller': mphController,
        'label': "Milha por hora (mph)",
        'function': _mphChanged
      },
      {
        'controller': noController,
        'label': "Nó (no)",
        'function': _noChanged
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(widget.pageController),
      appBar: AppBar(
        title: Text(
          "Velocidade",
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
        child: ListView(
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