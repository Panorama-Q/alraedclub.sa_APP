import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';

class GoalsClub extends StatefulWidget {
  const GoalsClub({super.key});

  @override
  State<GoalsClub> createState() => _GoalsClubState();
}

class _GoalsClubState extends State<GoalsClub> {
  final List<String> _strategicGoals = [
    'تحسين تنافسية كرة القدم والألعاب المختلفة',
    'زيادة مشجعي النادي وطنياً ودولياً',
    'تطوير أداء المسؤولية الاجتماعية',
    'تطوير البنية التحتية للنادي',
    'تحسين الأداء الإداري المؤسسي',
    'تنمية الاستثمار والاستدامة المالية',
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'الأهداف الإستراتيجية',
          showLogo: true,
        ),
        drawer: const AppDrawer(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: ListView.separated(
            itemCount: _strategicGoals.length,
            separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.015),
            itemBuilder: (context, index) {
              return Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.025,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 124, 40, 40),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: Text(
                          _strategicGoals[index],
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 50, 50, 50),
                            fontFamily: 'Tajawal',
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}