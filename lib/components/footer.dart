import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  
  // دالة محسنة لفتح وسائل التواصل مع معالجة متقدمة للأخطاء

  void _showErrorDialog(String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعذر فتح الرابط'),
        content: Text('الرابط: $url'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  // دالة بديلة لفتح الروابط بشكل مباشر
  Future<void> _launchUrlDirectly(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      
      // محاولة بطرق مختلفة
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        launched = await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
      }

      if (!launched) {
        _showErrorDialog(url);
      }
    } catch (e) {
      print('❌ خطأ مباشر في فتح الرابط: $e');
      _showErrorDialog(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth * 0.04;
    final double verticalPadding = screenWidth * 0.03;
    final double titleFontSize = screenWidth * 0.04;
    final double textFontSize = screenWidth * 0.035;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF320A0A),
            Color(0xFF7C2828),
            Color(0xFF501414),
          ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 30,
            offset: Offset(0, -10),
            spreadRadius: 5,
          ),
          BoxShadow(
            color: Color(0x997C2828),
            blurRadius: 20,
            offset: Offset(0, -5),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // الشريط العلوي: الشعار + وسائل التواصل
          Container(
            padding: EdgeInsets.only(bottom: screenWidth * 0.05),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0x26FFFFFF),
                  width: 0.8,
                ),
              ),
            ),
            child: screenWidth < 600
                ? Column(
                    children: [
                      // الشعار في الموبايل
                      Container(
                        width: screenWidth * 0.18,
                        height: screenWidth * 0.18,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.06),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x4D000000),
                              blurRadius: 25,
                              offset: Offset(0, 8),
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            child: Image.asset('assets/logo.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.04),
                      
                      // وسائل التواصل في الموبايل
                      Text(
                        'تابعنا على',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialSquare('assets/facebook.png', 
                              'https://www.facebook.com/alraedclubsa/', screenWidth),
                          SizedBox(width: screenWidth * 0.02),
                          _buildSocialSquare('assets/instagram.png', 
                              'https://www.instagram.com/alraedclub/', screenWidth),
                          SizedBox(width: screenWidth * 0.02),
                          _buildSocialSquare('assets/new_twitter.png', 
                              'https://twitter.com/alraedclub', screenWidth),
                          SizedBox(width: screenWidth * 0.02),
                          _buildSocialSquare('assets/snapchat.png', 
                              'https://www.snapchat.com/add/alraed_club', screenWidth),
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // الشعار
                      Container(
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.06),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x4D000000),
                              blurRadius: 30,
                              offset: Offset(0, 10),
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            child: Image.asset('assets/logo.png'),
                          ),
                        ),
                      ),

                      // وسائل التواصل
                      Column(
                        children: [
                          Text(
                            'تابعنا على',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.03),
                          Row(
                            children: [
                              _buildSocialSquare('assets/facebook.png', 
                                  'https://www.facebook.com/alraedclubsa/', screenWidth),
                              SizedBox(width: screenWidth * 0.02),
                              _buildSocialSquare('assets/instagram.png', 
                                  'https://www.instagram.com/alraedclub/', screenWidth),
                              SizedBox(width: screenWidth * 0.02),
                              _buildSocialSquare('assets/new_twitter.png', 
                                  'https://twitter.com/alraedclub', screenWidth),
                              SizedBox(width: screenWidth * 0.02),
                              _buildSocialSquare('assets/snapchat.png', 
                                  'https://www.snapchat.com/add/alraed_club', screenWidth),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
          ),

          SizedBox(height: screenWidth * 0.05),

          // الشريط الأوسط: أعمدة للمعلومات
          screenWidth < 600
              ? Column(
                  children: [
                    _buildInfoColumn(
                      icon: Icons.contact_phone_rounded,
                      title: 'معلومات التواصل',
                      items: [
                        'Media@alraedclub.sa',
                        '0163235858',
                      ],
                      screenWidth: screenWidth,
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    _buildInfoColumn(
                      icon: Icons.location_pin,
                      title: 'العنوان',
                      items: [
                        'المملكة العربية السعودية',
                        'القصيم - بريدة',
                      ],
                      screenWidth: screenWidth,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoColumn(
                      icon: Icons.contact_phone_rounded,
                      title: 'معلومات التواصل',
                      items: [
                        'Media@alraedclub.sa',
                        '0163235858',
                      ],
                      screenWidth: screenWidth,
                    ),
                    _buildInfoColumn(
                      icon: Icons.location_pin,
                      title: 'العنوان',
                      items: [
                        'المملكة العربية السعودية',
                        'القصيم - بريدة',
                      ],
                      screenWidth: screenWidth,
                    ),
                  ],
                ),

          SizedBox(height: screenWidth * 0.04),

          // الشريط السفلي: حقوق النشر
          Container(
            padding: EdgeInsets.only(top: screenWidth * 0.04),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0x26FFFFFF),
                  width: 0.8,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '  نادي الرائد - جميع الحقوق محفوظة  ',
                      style: TextStyle(
                        fontSize: textFontSize,
                        color: Color(0xB3FFFFFF),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      ' © 2023  ',
                      style: TextStyle(
                        fontSize: textFontSize,
                        color: Color(0xB3FFFFFF),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  'تصميم وتطوير بانورما القصيم',
                  style: TextStyle(
                    fontSize: textFontSize * 0.85,
                    color: Color(0x99FFFFFF),
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSquare(String iconPath, String url, double screenWidth) {
    final size = screenWidth * 0.12;
    final borderRadius = screenWidth * 0.04;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 15,
            offset: Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () => _launchUrlDirectly(url), // استخدام الدالة المباشرة
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.015),
              child: Image.asset(iconPath),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn({
    required IconData icon,
    required String title,
    required List<String> items,
    required double screenWidth,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.14,
          height: screenWidth * 0.14,
          decoration: BoxDecoration(
            color: Color(0x14FFFFFF),
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            border: Border.all(
              color: Color(0x26FFFFFF),
              width: 1.2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: screenWidth * 0.06,
            color: Colors.white,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenWidth * 0.025),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: screenWidth * 0.015),
          child: Text(
            item,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Color(0xB3FFFFFF),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        )),
      ],
    );
  }
}