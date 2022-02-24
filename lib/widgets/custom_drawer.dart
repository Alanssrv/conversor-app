import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
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
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              drawerTile(context, Icons.shutter_speed, "Velocidade", pageController, Colors.red, 0),
              drawerTile(context, Icons.wb_sunny, "Temperatura", pageController, Colors.blue, 1),
              drawerTile(context, Icons.attach_money, "Moeda", pageController, Colors.orange, 2),
            ],
          )
        ],
      ),
    );
  }
}

Widget drawerTile(BuildContext context, IconData icon, String text, PageController controller, Color color, int page){
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: (){
        Navigator.of(context).pop();
        controller.jumpToPage(page);
      },
      child: Container(
        height: 60.0,
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                icon,
                size: controller.page.round() == page ?
                40 : 25,
                color: color,
              ),
            ),
            SizedBox(width: 20,),
            Text(
              text,
              style: TextStyle(
                fontSize: controller.page.round() == page ?
                25 : 15,
                color: color,
                fontWeight: FontWeight.w300
              ),
            )
          ],
        ),
      ),
    ),
  );
}
