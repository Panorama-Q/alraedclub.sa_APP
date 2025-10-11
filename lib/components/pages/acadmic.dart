import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AcademyPage extends StatefulWidget {
  const AcademyPage({super.key});

  @override
  State<AcademyPage> createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage> {
  static const String _academyText =
      'واشتهر اسم النادي في لعبة كرة القدم حيث يلعب في الدوري الممتاز منذ عام ١٤٠٦هـ والذي يطلق عليه حاليا اسم دوري محمد بن سلمان للمحترفين. وحقق النادي أفضل ترتيب له في بعض المواسم باحتلاله المركز الخامس، وحصل مرّتين على بطولة دوري الدرجة الأولى السعودي عامي 1992م و2008م، كما فاز بدوري الدرجة الثانية السعودي في عام 2006م، وكأس الأمير فيصل بن فهد لأندية الدرجة الأولى والثانية عام 2006م.ويعتمد النادي أساساً في تزويد الفريق الأول لكرة القدم باللّاعبين على الفئات السنّية التي يعتني النادي بتطويرها إضافة إلى استقطاب عدد محدود من اللّاعبين الأجانب.';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'الأكاديمية',
          showLogo: true,
        ),
        drawer: const AppDrawer(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.28,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  right: screenWidth * 0.04,
                  left: screenWidth * 0.04,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  image: const DecorationImage(
                    image: AssetImage('assets/photo_logo.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: screenHeight * 0.03),
              
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.035,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'عن الأكاديمية',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 124, 40, 40),
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _academyText,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w500,
                        height: 1.8,
                        color: Colors.black87,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}