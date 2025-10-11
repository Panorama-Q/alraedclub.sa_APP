import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SurveyScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'استطلاع الجمهور',
          showLogo: true,
        ),
        drawer: const AppDrawer(),
        backgroundColor: const Color(0xFFF8F9FA),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.02,
          ),
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C2828),
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          color: Colors.white,
                          size: screenWidth * 0.1,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'استطلاع رأي الجمهور',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              Text(
                                'انطباعات الجماهير تُعد جماهير النادي من أهم شركاء النجاح، ويهمنا دائماً رأيهم لتطوير أداء النادي',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal',
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Content Card
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Personal Information Section
                        _buildSectionHeader(
                          context,
                          'المعلومات الشخصية',
                          Icons.person_outline,
                        ),
                        _buildQuestion(
                          context,
                          'الجنس',
                          [
                            'ذكر',
                            'أنثى',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'العمر',
                          [
                            'أقل من 20 سنة',
                            'من 20 إلى أقل من 30 سنة',
                            'من 30 إلى أقل من 50 سنة',
                            'من 50 سنة فأعلى',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'مكان الإقامة الحالي',
                          [
                            'منطقة القصيم',
                            'خارج منطقة القصيم',
                            'خارج المملكة',
                          ],
                        ),

                        // Marketing Section
                        _buildSectionHeader(
                          context,
                          'التسويق والإعلام',
                          Icons.campaign_outlined,
                        ),
                        _buildQuestion(
                          context,
                          'يقوم النادي بتسويق المباريات عبر وسائل التواصل الاجتماعي والأماكن العامة',
                          [
                            'غير موافق بشدة',
                            'غير موافق',
                            'موافق نوعاً ما',
                            'موافق',
                            'موافق بشدة',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'الأنشطة التسويقية التي يقوم بها النادي لجذب الجماهير لحضور المباريات كافية',
                          [
                            'غير موافق بشدة',
                            'غير موافق',
                            'موافق نوعاً ما',
                            'موافق',
                            'موافق بشدة',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'وسائل التواصل الاجتماعي تغطي أحداث مباريات النادي',
                          [
                            'غير موافق بشدة',
                            'غير موافق',
                            'موافق نوعاً ما',
                            'موافق',
                            'موافق بشدة',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'يستخدم النادي الموقع الإلكتروني الرسمي في الإعلان عن المباريات القادمة',
                          [
                            'نعم',
                            'لا',
                            'لا أعلم',
                          ],
                        ),

                        // Sports Performance Section
                        _buildSectionHeader(
                          context,
                          'الأداء الرياضي',
                          Icons.emoji_events_outlined,
                        ),
                        _buildQuestion(
                          context,
                          'ما مدى رضاك عن مستوى أداء اللاعبين المحليين في المباراتين السابقتين',
                          [
                            'ممتاز',
                            'جيد جداً',
                            'مقبول',
                            'ضعيف',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'ما مدى رضاك عن مستوى أداء الجهاز الفني والإداري للفريق الأول في المباراتين السابقتين',
                          [
                            'ممتاز',
                            'جيد جداً',
                            'مقبول',
                            'ضعيف',
                          ],
                        ),

                        // Services Section
                        _buildSectionHeader(
                          context,
                          'الخدمات والتنظيم',
                          Icons.assignment_outlined,
                        ),
                        _buildQuestion(
                          context,
                          'ما مدى رضاك عن تنظيم المباراة من حيث (تنظيم دخول وخروج الجماهير - توزيع المنظمين داخل المدرجات - توفر اللوحات الارشادية)',
                          [
                            'راضي جداً',
                            'راضي',
                            'غير راضي',
                            'غير راضي جداً',
                            'محايد',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'يلتزم النادي بمعايير الأمان',
                          [
                            'راضي جداً',
                            'راضي',
                            'غير راضي',
                            'غير راضي جداً',
                            'محايد',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'يستهدف النادي فئات مختلفة من المجتمع عند إقامة الأنشطة الترفيهية والفعاليات',
                          [
                            'غير موافق بشدة',
                            'غير موافق',
                            'موافق نوعاً ما',
                            'موافق',
                            'موافق بشدة',
                          ],
                        ),
                        _buildDivider(context),
                        _buildQuestion(
                          context,
                          'تنوع الأطعمة والمشروبات المقدمة من النادي خلال الأنشطة والفعاليات',
                          [
                            'غير موافق بشدة',
                            'غير موافق',
                            'موافق نوعاً ما',
                            'موافق',
                            'موافق بشدة',
                          ],
                        ),

                        // Suggestions Section
                        _buildSectionHeader(
                          context,
                          'مقترحات التطوير',
                          Icons.lightbulb_outline,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            border: Border.all(
                              color: const Color(0xFF7C2828),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ماهي مقترحاتك لتطوير أداء النادي؟',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.038,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF7C2828),
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              FormBuilderTextField(
                                name: 'مقترحات التطوير',
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: 'أدخل مقترحاتك هنا...',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF666666),
                                    fontFamily: 'Tajawal',
                                    fontSize: screenWidth * 0.035,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDDDDDD),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7C2828),
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Submit Button
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.03,
                      bottom: screenHeight * 0.04,
                    ),
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C2828),
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.saveAndValidate() ?? false) {
                              final formData = _formKey.currentState?.value;
                              print(formData);
                              _showSuccessDialog(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.022,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             Text(
                                'إرسال الاستطلاع',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.042,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                               Icon(
                                Icons.send_outlined,
                                color: Colors.white,
                                size: screenWidth * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: screenHeight * 0.03,
        bottom: screenHeight * 0.02,
      ),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFF7C2828),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: screenWidth * 0.05,
          ),
          SizedBox(width: screenWidth * 0.03),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, String question, List<String> options) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: screenWidth * 0.036,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
              fontFamily: 'Tajawal',
              height: 1.4,
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          FormBuilderRadioGroup<String>(
            name: question,
            orientation: OptionsOrientation.vertical,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            wrapSpacing: screenWidth * 0.02,
            wrapRunSpacing: screenHeight * 0.01,
            // إعدادات الألوان
            activeColor: const Color(0xFF7C2828),
            focusColor: const Color(0xFF7C2828),
            hoverColor: const Color(0xFFF8F9FA),
            options: options
                .map((option) => FormBuilderFieldOption(
                      value: option,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005,
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: screenWidth * 0.034,
                            color: const Color(0xFF333333),
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      height: 1,
      color: const Color(0xFFEEEEEE),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                SizedBox(height: 10),
                Text(
                  'شكراً لك',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
            content: Text(
              'تم إرسال استطلاع الرأي بنجاح. نقدر لك وقتك وآرائك القيمة.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Tajawal',
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C2828),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'تم',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}