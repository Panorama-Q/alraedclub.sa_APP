import 'package:alradi_app/components/drawer.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'النبذة التاريخية',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 124, 40, 40),
          centerTitle: true,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          elevation: 10,
          shadowColor: Colors.black,
        ),
        drawer: AppDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF8F9FA),
                Color(0xFFE9ECEF),
                Colors.white,
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                // Hero Section
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                       Radius.circular(40),
                     
                    ),
                    image: const DecorationImage(

                      image: AssetImage('assets/photo_logo.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'رائد التحدي منذ 1374هـ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 124, 40, 40),
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // History Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 124, 40, 40)
                                      ,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.history_edu,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'التأسيس والبدايات',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 124, 40, 40),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'تم تأسيس نادي الرائد السعودي في عام 1374هـ تحت مسمى نادي الأهلي بمبادرة من شباب مدينة بريدة كأول نادي رياضي في منطقة القصيم ومن أوائل الأندية الرياضية في المملكة. وكان أبرز من ساهم في تأسيس النادي عبد العزيز العبودي، وعلي المضيان، وعبد العزيز العمار، ومحمد الفوزان، ويوسف العمار، وغانم الغانم.',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'وفي عام 1382هـ وبعد قرار وزارة المعارف بتوثيق الأندية الرياضية في المملكة، سارع النادي بالتسجيل رسمياً لدى الوزارة، وتم تغيير مسماه في عام 1388هـ إلى نادي الرائد السعودي، ويُكنّى برائد التحدي.',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Football Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 124, 40, 40)
                                      ,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 124, 40, 40)
                                        ,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Image.asset(
                                    'assets/ball.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'كرة القدم',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 124, 40, 40),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'قلب النادي النابض',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: const Text(
                              'واشتهر اسم النادي في لعبة كرة القدم حيث يلعب في الدوري الممتاز منذ عام ١٤٠٦هـ والذي يطلق عليه حاليا اسم دوري محمد بن سلمان للمحترفين. وحقق النادي أفضل ترتيب له في بعض المواسم باحتلاله المركز الخامس، وحصل مرّتين على بطولة دوري الدرجة الأولى السعودي عامي 1992م و2008م، كما فاز بدوري الدرجة الثانية السعودي في عام 2006م، وكأس الأمير فيصل بن فهد لأندية الدرجة الأولى والثانية عام 2006م.',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.6,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: const Text(
                              'ويعتمد النادي أساساً في تزويد الفريق الأول لكرة القدم باللّاعبين على الفئات السنّية التي يعتني النادي بتطويرها إضافة إلى استقطاب عدد محدود من اللّاعبين الأجانب.',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.6,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Sports Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 124, 40, 40)
                                      ,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.sports_score,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'الرياضات الأخرى',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 124, 40, 40),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'يُشارك النادي في عدة ألعاب رياضية مختلفة (غير كرة القدم) وهي: الملاكمة، كرة اليد، الكاراتيه، والألعاب الإلكترونية. وتحقيقاً لتوجهات الهيئة العامة للرياضة بتطوير مختلف الألعاب الرياضية في المملكة، فقد سارع النادي في بداية عام 1441هـ بإنشاء ستة رياضات جديدة وهي: الدراجات، التايكوندو، كرة الطائرة، السباحة، تنس الطاولة، القدرة والتحمل.',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}