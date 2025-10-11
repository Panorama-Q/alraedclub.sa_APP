import 'package:alradi_app/components/coming_match.dart';
import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/components/footer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alradi_app/components/pages/players_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  GlobalKey playersKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth * 0.04;
    final double verticalPadding = screenWidth * 0.03;
    final double titleFontSize = screenWidth * 0.05;
    final double iconSize = screenWidth * 0.05;

    List<GlobalKey> keys = [playersKey];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: AppDrawer(keys: keys),
        appBar: CustomAppBar(title: 'نادي الرائد'),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: screenWidth * 0.05),
                        child: const UpComingMatch(),
                      ),
                      Container(
                        key: playersKey,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE0E0E0),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(screenWidth * 0.02),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 124, 40, 40),
                                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                    ),
                                    child: Icon(
                                      Icons.people_alt,
                                      color: Colors.white,
                                      size: iconSize,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.03),
                                  Text(
                                    'قائمة اللاعبين',
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(255, 124, 40, 40),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.04),
                            const playersCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.06),
                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}