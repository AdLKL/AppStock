import 'dart:convert';
import 'dart:io';

import 'package:appstock/screens/home/side_menu_list.dart';
import 'package:appstock/screens/profile_page.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  List<List<dynamic>> _data = [];
  String? filePath;

  Future<void> _checkPermissionAndUpload() async {
    if (await Permission.storage.request().isGranted) {
      _pickFile();
    } else {
      // If permissions are not granted, request them again
      await Permission.storage.request();
      if (await Permission.storage.isGranted) {
        _pickFile();
      } else {
        // Permissions denied by the user
        // Handle accordingly (e.g., show an error message)
      }
    }
  }

// navigate to profile page
  void goToProfilePage() {
    // pop the menu drawer
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ));
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    filePath = result.files.first.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);

    setState(() {
      _data = fields;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: sideMenuKey,
      background: const Color(0xff19143b),
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
          body: Column()),
    );
  }
}
