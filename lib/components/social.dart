import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaPage extends StatelessWidget {
  final String imgUrl;
  final String text;
  final String whatsappUrl;
  final String facebookUrl;
  final String instagramUrl;

  const SocialMediaPage({super.key, 
    required this.imgUrl,
    required this.text,
    required this.whatsappUrl,
    required this.facebookUrl,
    required this.instagramUrl,
  });


  // دالة مساعدة للتعامل مع الروابط بشكل أكثر أماناً
  Future<void> _launchSocialMedia(String url) async {
    final Uri uri = Uri.parse(url);
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      // محاولة فتح في المتصفح إذا فشل التطبيق
      final Uri webUri = Uri.parse(url.replaceFirst('https', 'http'));
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('وسائل التواصل الاجتماعي'),
        backgroundColor: const Color.fromARGB(255, 124, 40, 40),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // الصورة
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey.shade400,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // النص
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // أزرار وسائل التواصل
              _buildSocialButton(
                'واتساب',
                Icons.chat,
                Colors.green,
                () => _launchSocialMedia(whatsappUrl),
              ),
              
              const SizedBox(height: 16),
              
              _buildSocialButton(
                'فيسبوك',
                Icons.facebook,
                Colors.blue,
                () => _launchSocialMedia(facebookUrl),
              ),
              
              const SizedBox(height: 16),
              
              _buildSocialButton(
                'انستجرام',
                Icons.camera_alt,
                Colors.pink,
                () => _launchSocialMedia(instagramUrl),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: SocialMediaPage(
        imgUrl: 'https://example.com/image.jpg',
        text: 'تابعنا على وسائل التواصل الاجتماعي',
        whatsappUrl: 'https://wa.me/966XXXXXXXXX',
        facebookUrl: 'https://www.facebook.com/alraedclubsa/',
        instagramUrl: 'https://www.instagram.com/alraedclubsa/',
      ),
    );
  }
}