import 'package:alradi_app/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Document extends StatefulWidget {
  const Document({super.key});

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  Future<void> _openBrowser() async {
    const url = 'https://alraedclub.sa/site/img/%D8%A7%D8%B3%D8%AA%D8%B1%D8%A7%D8%AA%D9%8A%D8%AC%D9%8A%D8%A9%20%D9%86%D8%A7%D8%AF%D9%8A%20%D8%A7%D9%84%D8%B1%D8%A7%D8%A6%D8%AF.pdf';
    
    final Uri uri = Uri.parse(url);
    
    try {
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تعذر فتح الوثيقة. يرجى المحاولة لاحقاً'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('❌ خطأ في فتح الرابط: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('حدث خطأ أثناء فتح الوثيقة'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'إعادة المحاولة',
            onPressed: _openBrowser,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'وثيقة نادي الرائد',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
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
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
        ),
        drawer: AppDrawer(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                const Color.fromARGB(255, 250, 250, 250),
                const Color.fromARGB(255, 245, 245, 245),
                const Color.fromARGB(255, 240, 240, 240),
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 140, 45, 45),
                        Color.fromARGB(255, 124, 40, 40),
                        Color.fromARGB(255, 110, 35, 35),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 124, 40, 40),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.description,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                const Text(
                  'الخطة الإستراتيجية لنادي الرائد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 124, 40, 40),
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 50),
                
                Container(
                  width: 280,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 140, 45, 45),
                        Color.fromARGB(255, 124, 40, 40),
                        Color.fromARGB(255, 110, 35, 35),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 124, 40, 40),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _openBrowser,
                      borderRadius: BorderRadius.circular(16),
                      splashColor: Colors.white,
                      highlightColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.open_in_new,
                                size: 20,
                        color: Color.fromARGB(255, 124, 40, 40),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'فتح الوثيقة',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
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
    );
  }
}