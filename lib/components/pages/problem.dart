import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Problem extends StatefulWidget {
  const Problem({super.key});

  @override
  State<Problem> createState() => _ProblemState();
}

class _ProblemState extends State<Problem> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double iconSize = screenWidth * 0.06;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'تسجيل البلاغات والشكاوي',
          showLogo: true,
        ),
        drawer: const AppDrawer(),
        backgroundColor: const Color(0xFFF8F9FA),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              margin: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE0E0E0),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  children: [
                    Column(
                      children: [
                        // العنوان الرئيسي بنفس الشكل
                        Container(
                          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7C2828),
                                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                ),
                                child: Icon(
                                  Icons.report_problem,
                                  color: Colors.white,
                                  size: iconSize,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Text(
                                'تسجيل البلاغات والشكاوي',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.055,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF7C2828),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: screenWidth * 0.04),

                        // حقل الاسم بنفس الشكل
                        _buildTextField(
                          controller: _nameController,
                          label: 'الاسم الكامل',
                          hint: 'أدخل اسمك الكامل',
                          icon: Icons.person,
                          screenWidth: screenWidth,
                        
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل الجوال بنفس الشكل
                        _buildTextField(
                          controller: _phoneController,
                          label: 'رقم الجوال',
                          hint: 'أدخل رقم جوالك',
                          icon: Icons.phone,
                          screenWidth: screenWidth,
                          keyboardType: TextInputType.phone,
                         
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل البريد الإلكتروني بنفس الشكل
                        _buildTextField(
                          controller: _emailController,
                          label: 'البريد الإلكتروني',
                          hint: 'أدخل بريدك الإلكتروني',
                          icon: Icons.email,
                          screenWidth: screenWidth,
                          keyboardType: TextInputType.emailAddress,
                          
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل الموضوع بنفس الشكل
                        _buildTextField(
                          controller: _subjectController,
                          label: 'الموضوع',
                          hint: 'أدخل موضوع الشكوى أو البلاغ',
                          icon: Icons.subject,
                          screenWidth: screenWidth,
                          maxLines: 3,
                          
                        ),

                        SizedBox(height: screenWidth * 0.05),

                        // زر الإرسال بنفس الشكل
                        SizedBox(
                          width: double.infinity,
                          height: screenWidth * 0.13,
                          child: ElevatedButton(
                            onPressed: () {
                              
                              
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7C2828),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                              ),
                              elevation: 4,
                              shadowColor: const Color(0xFF7C2828),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'إرسال البلاغ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: screenWidth * 0.045,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required double screenWidth,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: screenWidth * 0.01, right: screenWidth * 0.01),
          child: Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF424242),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: const Color(0xFF9E9E9E),
              fontSize: screenWidth * 0.035,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.all(screenWidth * 0.015),
              child: Icon(
                icon,
                color: const Color(0xFF7C2828),
                size: screenWidth * 0.045,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              borderSide: const BorderSide(
                color: Color(0xFF7C2828),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            filled: true,
            fillColor: const Color(0xFFFAFAFA),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.03,
            ),
          ),
          style: TextStyle(
            fontSize: screenWidth * 0.038,
            color: const Color(0xFF212121),
          ),
        ),
      ],
    );
  }

}