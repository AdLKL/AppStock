import 'package:appstock/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SideMenuList extends StatelessWidget {
  final GlobalKey<SideMenuState> menuKey;
  const SideMenuList({Key? key, required this.menuKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: ListView(
        children: [
          const ListTile(
            leading: CircleAvatar(
              maxRadius: 40,
              // backgroundImage: AssetImage(AutofillHints.photo),
            ),
            title: Text('User',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                )),
            subtitle: Text('email@email.com',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            color: Color.fromARGB(137, 255, 255, 255),
          ),
          const SizedBox(
            height: 18,
          ),
          buttonDecoration(
              name: 'Home',
              iconData: Icons.home,
              boxColor: Color.fromARGB(255, 11, 165, 236),
              onTap: () {
                if (menuKey.currentState!.isOpened) {
                  menuKey.currentState!.closeSideMenu();
                } else {
                  menuKey.currentState!.openSideMenu();
                }
              }),
          const SizedBox(
            height: 40,
          ),
          buttonDecoration(
              name: 'Profile',
              iconData: Icons.person,
              boxColor: Colors.transparent,
              onTap: () {}),
          const SizedBox(
            height: 40,
          ),
          buttonDecoration(
              name: 'Stock',
              iconData: Icons.add_box,
              boxColor: Colors.transparent,
              onTap: () {}),
          const SizedBox(
            height: 40,
          ),
          buttonDecoration(
              name: 'Settings',
              iconData: Icons.settings,
              boxColor: Colors.transparent,
              onTap: () {}),
          const SizedBox(
            height: 34,
          ),
          const Divider(
            color: Color.fromARGB(137, 255, 255, 255),
          ),
          const SizedBox(
            height: 40,
          ),
          buttonDecoration(
              name: 'Log out',
              iconData: Icons.logout,
              boxColor: Colors.transparent,
              onTap: () {
                context.read<SignInBloc>().add(const SignOutRequired());
              }),
        ],
      ),
    );
  }

  buttonDecoration({
    required String name,
    required IconData iconData,
    required VoidCallback onTap,
    required Color boxColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: boxColor,
        ),
        child: Row(
          children: [
            Icon(iconData, size: 28, color: Color.fromARGB(255, 255, 255, 255)),
            const SizedBox(
              width: 15,
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
