import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ClubVision extends StatefulWidget {
  const ClubVision({super.key});

  @override
  State<ClubVision> createState() => _ClubVisionState();
}

class _ClubVisionState extends State<ClubVision> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'رؤية النادي',
          showLogo: true,
        ),
        drawer: const AppDrawer(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                
                _buildVisionSection(
                  context,
                  'رؤية النادي',
                  Icons.visibility,
                  'البقاء ضمن الفرق الخمس الأول في دوري المحترفين لكرة القدم ومنافساً في الألعاب المختلفة',
                ),
                
                SizedBox(height: screenHeight * 0.025),
                
                _buildVisionSection(
                  context,
                  'رسالة النادي',
                  Icons.flag,
                  'توفير بيئة رياضية محفّزة للممارسين في مختلف الألعاب الرياضية وجاذبة للاستثمار، مع الالتزام بتفعيل المسؤولية الاجتماعية، لتحقيق تطلعات الشركاء والتوجهات المستقبلية للمملكة.',
                ),
                
                SizedBox(height: screenHeight * 0.025),
                
                _buildVisionSection(
                  context,
                  'قيم النادي',
                  Icons.star,
                  'في ضوء الالتزام بالقيم الإسلامية، يُؤمن نادي الرائد السعودي بالقيّم التالية التي يسعى إلى تطبيقها في كافة أنشطته ومعاملاته، إضافة إلى نشرها لجميع شركائه الداخليين والخارجيين وغرسها في نفوسهم بما يضمن بيئة عمل تنافسية في النادي.  ( التحدي  ،  الاحترافية  ،  الشفافية  ،  العمل الجماعي    ،  الشفافية    ،  العمل الجماعي  ،   الأمانة  ،  الروح الرياضية  ،  الانضباط  )',
                ),
                
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisionSection(BuildContext context, String title, IconData icon, String content) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.025,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color.fromARGB(255, 124, 40, 40),
            const Color.fromARGB(255, 150, 50, 50),
          ],
        ),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: const Color.fromARGB(255, 124, 40, 40),
                  size: screenWidth * 0.06,
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.048,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white,
          ),
          SizedBox(height: screenHeight * 0.015),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
              height: 1.6,
              color: Colors.white,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }
}