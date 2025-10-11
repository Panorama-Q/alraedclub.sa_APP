import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Volunteer extends StatefulWidget {
  const Volunteer({super.key});

  @override
  State<Volunteer> createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  String? _selectedGender;
  String? _selectedEducation;
  String? _selectedVolunteerType;
  String? _selectedParticipationType;
  String? _selectedVolunteerTime;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _ageController.dispose();
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
          title: 'التطوع',
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
                                  Icons.volunteer_activism,
                                  color: Colors.white,
                                  size: iconSize,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Text(
                                'تسجيل في الأعمال التطوعية  ',
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

                        // حقل العمر بنفس الشكل
                        _buildTextField(
                          controller: _ageController,
                          label: 'العمر',
                          hint: 'أدخل عمرك',
                          icon: Icons.cake,
                          screenWidth: screenWidth,
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل الجنس بنفس الشكل
                        _buildDropdownField(
                          value: _selectedGender,
                          label: 'الجنس',
                          hint: 'اختر الجنس',
                          icon: Icons.person_outline,
                          screenWidth: screenWidth,
                          items: ['ذكر', 'أنثى'],
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل المؤهل الدراسي بنفس الشكل
                        _buildDropdownField(
                          value: _selectedEducation,
                          label: 'أخر مؤهل دراسي',
                          hint: 'اختر المؤهل الدراسي',
                          icon: Icons.school,
                          screenWidth: screenWidth,
                          items: [
                            'أقل من ثانوي',
                            'ثانوي',
                            'بكالوريس',
                            'دبلوم عالي',
                            'ماجستير',
                            'دكتوراة',
                            'آخرى'
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedEducation = value;
                            });
                          },
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل نوع العمل التطوعي بنفس الشكل
                        _buildDropdownField(
                          value: _selectedVolunteerType,
                          label: 'نوع العمل التطوعي',
                          hint: 'اختر نوع العمل التطوعي',
                          icon: Icons.work_outline,
                          screenWidth: screenWidth,
                          items: [
                            'رياضي',
                            'إجتماعي',
                            'ثقافي',
                            'صحي',
                            'الكوارث والطوارئ',
                            'آخرى',
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedVolunteerType = value;
                            });
                          },
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل نوع المشاركة بنفس الشكل
                        _buildDropdownField(
                          value: _selectedParticipationType,
                          label: 'نوع المشاركة',
                          hint: 'اختر نوع المشاركة',
                          icon: Icons.group,
                          screenWidth: screenWidth,
                          items: ['قائد', 'عضو'],
                          onChanged: (value) {
                            setState(() {
                              _selectedParticipationType = value;
                            });
                          },
                        ),

                        SizedBox(height: screenWidth * 0.03),

                        // حقل أوقات التطوع بنفس الشكل
                        _buildDropdownField(
                          value: _selectedVolunteerTime,
                          label: 'أوقات التطوع',
                          hint: 'اختر أوقات التطوع',
                          icon: Icons.access_time,
                          screenWidth: screenWidth,
                          items: [
                            'مفتوح',
                            'أيام مناسبات النادي',
                            'أيام الاجازات الصيفية',
                            'أيام اجازة نهاية الاسبوع',
                            'أيام المواسم',
                            'المناسبات العامة',
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedVolunteerTime = value;
                            });
                          },
                        ),

                        SizedBox(height: screenWidth * 0.05),

                        // زر الإرسال بنفس الشكل
                        SizedBox(
                          width: double.infinity,
                          height: screenWidth * 0.13,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle form submission
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
                                  'تسجيل التطوع',
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

  Widget _buildDropdownField({
    required String? value,
    required String label,
    required String hint,
    required IconData icon,
    required double screenWidth,
    required List<String> items,
    required Function(String?) onChanged,
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
        DropdownButtonFormField<String>(
          initialValue: value,
          onChanged: onChanged,
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
            filled: true,
            fillColor: const Color(0xFFFAFAFA),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.02,
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                ),
              ),
            );
          }).toList(),
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: const Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}