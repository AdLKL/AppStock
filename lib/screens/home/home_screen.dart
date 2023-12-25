import 'package:appstock/screens/home/side_menu_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: sideMenuKey,
      background: Color(0xff19143b),
      menu: SideMenuList(
        menuKey: sideMenuKey,
      ),
      maxMenuWidth: 360,
      type: SideMenuType.slideNRotate,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.deepPurple.shade900,
          leading: IconButton(
            onPressed: () {
              if (sideMenuKey.currentState!.isOpened) {
                sideMenuKey.currentState!.closeSideMenu();
              } else {
                sideMenuKey.currentState!.openSideMenu();
              }
            },
            icon: Icon(Icons.menu),
          ),
          title: const Text('Welcome, you are In !'),
        ),
        body: const Center(
            child: Text('Home',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      ),
    );
  }
}
