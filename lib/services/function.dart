import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';



Future<void> openSocialMedia(String url) async {
  try {
    final Uri uri = Uri.parse(url);
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      final Uri webUri = Uri.parse(url);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(
          webUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'تعذر فتح الرابط: $url';
      }
    }
  } catch (e) {
    print('❌ خطأ في فتح الرابط: $e');
    rethrow;
  }
}
void sortList(List<DocumentSnapshot> myList) {
  myList.removeWhere((element) {
    Map<String, dynamic> temp = element.data() as Map<String, dynamic>;

    return temp.containsKey("time") == false;
  });
  myList.sort((a, b) {
    DateTime firstMap = a["time"].toDate();

    DateTime secMap = b["time"].toDate();

    return secMap.compareTo(firstMap);
  });
}
