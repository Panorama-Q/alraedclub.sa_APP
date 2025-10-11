import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogo;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showLogo = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: showLogo
          ? [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ]
          : null,
      backgroundColor: const Color.fromARGB(255, 124, 40, 40),
      centerTitle: true,
      toolbarHeight: 70,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      elevation: 10,
      shadowColor: Colors.black,
    );
  }
}