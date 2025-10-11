import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class pagevisit extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  pagevisit({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'استطلاع الزوار',
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
                          Icons.people_outline,
                          color: Colors.white,
                          size: screenWidth * 0.1,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'استبيان الزوار',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              Text(
                                'يهدف هذا الاستبيان إلى إتاحة الفرصة لزوار نادي الرائد السعودي لإبداء آرائهم عن مرافق النادي بهدف التحسين والتطوير، علمًا بأن المعلومات المقدمة ستبقى سريّة.',
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
                        // Facilities Section
                        _buildSectionHeader(
                          context,
                          'تقييم المرافق والخدمات',
                          Icons.place_outlined,
                        ),
                        
                        _buildQuestion(
                          context,
                          ' موقع النادي مناسب للزوار',
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
                          ' يوجد في منشأة النادي مسبح قانوني ومميز',
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
                          ' يوجد في منشأة النادي مبنى إداري مهيأ وفيه جميع التجهيزات',
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
                          'يوجد لوحات توعوية للمحافظة على مرافق النادي',
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
                          ' دورات المياة بمنشأة النادي كافية ونظيفة',
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
                          ' يوجد بمنشأة النادي أماكن لجلوس الزوار',
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
                          ' أدوات السلامة في منشأة النادي متوفرة في اماكن واضحة',
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
                          'الأجهزة الطبية بصالة العلاج الطبيعي جيدة',
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
                          ' صيانة مرافق منشأة النادي والحفاظ عليها واضح لزوار النادي',
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
                          ' صالة الألعاب المغطاة بمنشأة النادي مميزة',
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
                                'أيّ تعليقات أو ملحوظات أو اقتراحات يمكن إضافتها حول مرافق النادي',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.038,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF7C2828),
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              FormBuilderTextField(
                                name: 'مقترحات_الزوار',
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
                                'إرسال الاستبيان',
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
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Tajawal',
              ),
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
              'تم إرسال استبيان الزوار بنجاح. نقدر لك وقتك وآرائك القيمة.',
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