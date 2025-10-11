import 'package:alradi_app/screens/about.dart';
import 'package:alradi_app/screens/homepage.dart';
import 'package:alradi_app/screens/news.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var pages = [
    const HomePage(
     
    ),
    const NewsPage(),
    const About(),
  ];
  int _selectedPage = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl, 
        child: pages[_selectedPage],
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl, 
        child: SalomonBottomBar(
          currentIndex: _selectedPage,
          onTap: (i) => setState(() => _selectedPage = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(EneftyIcons.home_2_outline),
              title: const Text("الرئيسية"),
              selectedColor: const Color.fromARGB(255, 175, 35, 35),
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(EneftyIcons.book_outline),
              title: const Text("الاخبار"),
              selectedColor: const Color.fromARGB(255, 175, 35, 35),
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(EneftyIcons.undo_outline),
              title: const Text("عن النادي"),
              selectedColor: const Color.fromARGB(255, 175, 35, 35),
            ),
          ],
        ),
      ),
    );
  }
}