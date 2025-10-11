import 'package:alradi_app/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'; // لإضافة نسخ الرابط

class store extends StatefulWidget {
  const store({super.key});

  @override
  State<store> createState() => _storeState();
}

class _storeState extends State<store> {
  Future<void> _openBrowser() async {
    const url = 'https://store.alraedclub.sa/';
    
    final Uri uri = Uri.parse(url);
    
    try {
      // فتح الرابط مباشرة في المتصفح الافتراضي
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // هذا يفتح في المتصفح الافتراضي
      )) {
        // إذا فشل، اعرض خيار نسخ الرابط
        _showCopyLinkDialog();
      }
    } catch (e) {
      print('❌ خطأ في فتح الرابط: $e');
      _showCopyLinkDialog();
    }
  }

  void _showCopyLinkDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعذر فتح المتجر'),
        content: const Text('يمكنك نسخ الرابط وفتحه يدوياً في المتصفح'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _copyToClipboard();
            },
            child: const Text('نسخ الرابط'),
          ),
        ],
      ),
    );
  }

  Future<void> _copyToClipboard() async {
    const url = 'https://store.alraedclub.sa/';
    await Clipboard.setData(const ClipboardData(text: url));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ الرابط إلى الحافظة'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '  المتجر  ',
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
                    Icons.local_grocery_store_outlined,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // العنوان الرئيسي فقط
                const Text(
                  '     تصفح المتجر الخاص بنادي الرائد     ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 124, 40, 40),
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // زر فتح الوثيقة - تصميم أكثر احترافية
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
                                Icons.storefront_outlined,
                                size: 20,
                                color: Color.fromARGB(255, 124, 40, 40),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              '  تصفح المتجر',
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

                // زر نسخ الرابط كبديل
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _copyToClipboard,
                  child: const Text(
                    'نسخ الرابط',
                    style: TextStyle(
                      color: Color.fromARGB(255, 124, 40, 40),
                      fontSize: 14,
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