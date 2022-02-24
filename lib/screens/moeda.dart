import 'package:conversornafec/widgets/custom_drawer.dart';
import 'package:conversornafec/widgets/text_form.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Moeda extends StatefulWidget {
  final PageController pageController;
  final Color color;

  const Moeda({@required this.pageController, @required this.color});

  @override
  _MoedaState createState() => _MoedaState();
}

class _MoedaState extends State<Moeda> {
  double euro, dolar, bitCoin;

  TextEditingController realController = TextEditingController();
  TextEditingController euroController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController bitCoinController = TextEditingController();

  var _apiKey = String.fromEnvironment('API_KEY');

  void _reset() {
    realController.clear();
    euroController.clear();
    dolarController.clear();
    bitCoinController.clear();
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _reset();
      return;
    }
    double value = double.parse(text);
    euroController.text = (value / euro).toStringAsPrecision(6);
    dolarController.text = (value / dolar).toStringAsPrecision(6);
    bitCoinController.text = (value / bitCoin).toStringAsPrecision(6);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _reset();
      return;
    }
    double value = double.parse(text);
    value *= this.euro;
    realController.text = (value).toStringAsPrecision(6);
    dolarController.text = (value / dolar).toStringAsPrecision(6);
    bitCoinController.text = (value / bitCoin).toStringAsPrecision(6);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _reset();
      return;
    }
    double value = double.parse(text);
    value *= this.dolar;
    realController.text = (value).toStringAsPrecision(6);
    euroController.text = (value / euro).toStringAsPrecision(6);
    bitCoinController.text = (value / bitCoin).toStringAsPrecision(6);
  }

  void _bitCoinChanged(String text) {
    if (text.isEmpty) {
      _reset();
      return;
    }
    double value = double.parse(text);
    value *= this.bitCoin;
    realController.text = (value).toStringAsPrecision(6);
    euroController.text = (value / euro).toStringAsPrecision(6);
    dolarController.text = (value / dolar).toStringAsPrecision(6);
  }

  Future<Map> getData() async {
    http.Response response = await http
        .get('https://api.hgbrasil.com/finance?format=json&key=$_apiKey');
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    List<Map<String, dynamic>> list = [
      {
        'controller': realController,
        'label': "Reais (R\$)",
        'function': _realChanged,
      },
      {
        'controller': euroController,
        'label': "Euro (€)",
        'function': _euroChanged,
      },
      {
        'controller': dolarController,
        'label': "Dolár (US\$)",
        'function': _dolarChanged,
      },
      {
        'controller': bitCoinController,
        'label': " BitCoin (₿)",
        'function': _bitCoinChanged,
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(widget.pageController),
      appBar: AppBar(
        title: Text(
          "Moeda",
          style: TextStyle(color: widget.color, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: widget.color,
              ),
              onPressed: () {
                _reset();
              }),
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
                colors: [Colors.black, Colors.black54],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      margin: EdgeInsets.all(5),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(widget.color),
                        ),
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error ao Carregando Dados\nRecarregue a página",
                          style: TextStyle(
                              color: widget.color,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      dolar =
                          snapshot.data["results"]["currencies"]["USD"]["buy"];
                      euro =
                          snapshot.data["results"]["currencies"]["EUR"]["buy"];
                      bitCoin =
                          snapshot.data["results"]["currencies"]["BTC"]["buy"];
                      return Form(
                        child: TextForm(list: list, color: widget.color),
                      );
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
