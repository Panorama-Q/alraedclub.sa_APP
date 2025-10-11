import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/components/footer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double iconSize = screenWidth * 0.06;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'اتصل بنا'),
        drawer: AppDrawer(),
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
                        // العنوان الرئيسي
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 124, 40, 40),
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.02),
                                ),
                                child: Icon(
                                  Icons.contact_mail,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  size: iconSize,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Text(
                                'تواصل معنا',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.055,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 124, 40, 40),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: screenWidth * 0.04),

                        // حقل الاسم
                        _buildTextField(
                          controller: _nameController,
                          label: 'الاسم الكامل',
                          hint: 'أدخل اسمك الكامل',
                          icon: Icons.person,
                          screenWidth: screenWidth,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال الاسم';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل الجوال
                        _buildTextField(
                          controller: _phoneController,
                          label: 'رقم الجوال',
                          hint: 'أدخل رقم جوالك',
                          icon: Icons.phone,
                          screenWidth: screenWidth,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال رقم الجوال';
                            }
                            if (value.length < 10) {
                              return 'رقم الجوال يجب أن يكون 10 أرقام على الأقل';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل البريد الإلكتروني
                        _buildTextField(
                          controller: _emailController,
                          label: 'البريد الإلكتروني',
                          hint: 'أدخل بريدك الإلكتروني',
                          icon: Icons.email,
                          screenWidth: screenWidth,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            if (!value.contains('@')) {
                              return 'يرجى إدخال بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل الموضوع
                        _buildTextField(
                          controller: _subjectController,
                          label: 'الموضوع',
                          hint: 'أدخل موضوع الرسالة',
                          icon: Icons.subject,
                          screenWidth: screenWidth,
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال الموضوع';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: screenWidth * 0.05),

                        // زر الإرسال
                        SizedBox(
                          width: double.infinity,
                          height: screenWidth * 0.13,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // إرسال البيانات
                                _submitForm();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 124, 40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.03),
                              ),
                              elevation: 4,
                              shadowColor:
                                  const Color.fromARGB(255, 124, 40, 40),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'إرسال الرسالة',
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

                        SizedBox(height: screenWidth * 0.06),

                        const Footer(),
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
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: screenWidth * 0.01, right: screenWidth * 0.01),
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
          validator: validator,
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
                color: const Color.fromARGB(255, 124, 40, 40),
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
                  color: Color.fromARGB(255, 124, 40, 40), width: 1.5),
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

  void _submitForm() {
    // هنا بيكون كود إرسال البيانات للخادم
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إرسال رسالتك بنجاح'),
        backgroundColor: const Color.fromARGB(255, 124, 40, 40),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // تنظيف الحقول بعد الإرسال
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _subjectController.clear();
  }
}
