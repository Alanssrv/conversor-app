import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {

  final List<Map<String, dynamic>> list;
  final Color color;

  TextForm({@required this.list, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list.map((l){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            cursorColor: color,
            controller: l['controller'],
            onChanged: l['function'],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color)
              ),
              contentPadding: EdgeInsets.all(5),
              hintText: FocusScope.of(context).hasFocus ? "" : l['label'],
              hintStyle: TextStyle(
                color: color,
                fontWeight: FontWeight.w300
              ),
              labelText: l['label'],
              labelStyle: TextStyle(
                color: color,
                fontWeight: FontWeight.w300
              ),
            ),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w300,
              fontSize: 20
            ),
          ),
        );
      }).toList()
    );
  }
}