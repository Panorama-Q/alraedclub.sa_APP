import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========== الأخبار ==========
  Future<void> createNews(String title, String imageUrl, String category,
      String content, String time) async {
    final CollectionReference newsCollection = _firestore.collection('news');
    await newsCollection.add({
      'title': title,
      'imageUrl': imageUrl,
      'category': category,
      'content': content,
      'time': time,
    });
  }

  Future<List<DocumentSnapshot>> getData(String collectionName) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      return documents;
    } catch (e) {
      print('Error reading documents: $e');
      return [];
    }
  }

  // ========== اللاعبين ==========
  Future<List<Map<String, dynamic>>> getPlayers() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('players').get();

      List<Map<String, dynamic>> players = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String imageUrl = data['playerImage'] ?? '';

        if (imageUrl.contains('alraedclub.sa')) {
          imageUrl = 'https://corsproxy.io/?${Uri.encodeFull(imageUrl)}';
        }

        players.add({
          'Image': imageUrl,
          'Name': data['playerName'] ?? '',
          'POS': data['playerPosition'] ?? '',
        });
      }

      print('✅ تم جلب ${players.length} لاعب من Firebase');
      return players;
    } catch (e) {
      print('❌ Error getting players: $e');
      return [];
    }
  }

  // ========== المباريات ==========

  // 1. جلب المباراة القادمة (الأقرب موعداً)
  Future<DocumentSnapshot?> getNextMatch() async {
    try {
      final query = await _firestore
          .collection('matches')
          .orderBy('time', descending: false)
          .get();

      final now = Timestamp.now();
      DocumentSnapshot? nextMatch;

      // نبحث عن المباراة القادمة (الأولى بعد الوقت الحالي)
      for (var doc in query.docs) {
        final matchData = doc.data();
        final matchTime = matchData['time'] as Timestamp;

        // إذا المباراة قادمة
        if (matchTime.compareTo(now) > 0) {
          nextMatch = doc;
          break; // نأخذ أول مباراة قادمة
        }
      }

      if (nextMatch != null) {
        final matchData = nextMatch.data() as Map<String, dynamic>;
        final matchTime = matchData['time'] as Timestamp;
        print(
            '✅ تم العثور على المباراة القادمة: ${matchData['away_team']['name']}');
        print('⏰ الوقت: ${matchTime.toDate()}');
      } else {
        print('❌ لا توجد مباريات قادمة');
      }

      return nextMatch;
    } catch (e) {
      print('❌ Error getting next match: $e');
      return null;
    }
  }

  // 2. جلب كل المباريات القادمة
  Future<List<DocumentSnapshot>> getUpcomingMatches() async {
    try {
      final query = await _firestore
          .collection('matches')
          .orderBy('time', descending: false)
          .get();

      final now = Timestamp.now();
      final upcomingMatches = <DocumentSnapshot>[];

      for (var doc in query.docs) {
        final matchData = doc.data();
        final matchTime = matchData['time'] as Timestamp;
        if (matchTime.compareTo(now) > 0) {
          upcomingMatches.add(doc);
        }
      }

      print('✅ تم جلب ${upcomingMatches.length} مباراة قادمة');
      return upcomingMatches;
    } catch (e) {
      print('❌ Error getting upcoming matches: $e');
      return [];
    }
  }

  // 3. جلب المباريات حسب الحالة
  Future<List<DocumentSnapshot>> getMatchesByStatus(String status) async {
    try {
      final query = await _firestore
          .collection('matches')
          .where('status', isEqualTo: status)
          .orderBy('time', descending: false)
          .get();

      return query.docs;
    } catch (e) {
      print('❌ Error getting matches by status: $e');
      return [];
    }
  }

  // 4. تحديث حالة المباراة
  Future<void> updateMatchStatus(String matchId, String status) async {
    try {
      await _firestore
          .collection('matches')
          .doc(matchId)
          .update({'status': status});

      print('✅ تم تحديث حالة المباراة إلى: $status');
    } catch (e) {
      print('❌ Error updating match status: $e');
    }
  }

  // 5. جلب المباريات في نطاق زمني
  Future<List<DocumentSnapshot>> getMatchesInTimeRange(
      DateTime start, DateTime end) async {
    try {
      final startTimestamp = Timestamp.fromDate(start);
      final endTimestamp = Timestamp.fromDate(end);

      final query = await _firestore
          .collection('matches')
          .orderBy('time', descending: false)
          .get();

      final matchesInRange = <DocumentSnapshot>[];

      for (var doc in query.docs) {
        final matchData = doc.data();
        final matchTime = matchData['time'] as Timestamp;
        if (matchTime.compareTo(startTimestamp) > 0 &&
            matchTime.compareTo(endTimestamp) < 0) {
          matchesInRange.add(doc);
        }
      }

      return matchesInRange;
    } catch (e) {
      print('❌ Error getting matches in time range: $e');
      return [];
    }
  }

  // في ملف firebaseApi.dart - أضف هذه الدالة
  Future<List<DocumentSnapshot>> getAllMatches() async {
    try {
      final query = await _firestore
          .collection('matches')
          .orderBy('time', descending: false)
          .get();

      print('✅ تم جلب ${query.docs.length} مباراة');
      return query.docs;
    } catch (e) {
      print('❌ Error getting all matches: $e');
      return [];
    }
  }

  // ========== التقرير السنوي ==========

  // دالة تجيب سنة التقرير من الفايربيز
  Future<String?> getReportYear() async {
    try {
      final reportDoc = await _firestore
          .collection('annual_report')
          .doc('tpoKaF6XT78Gvr4dgm69')
          .get();

      if (reportDoc.exists) {
        final data = reportDoc.data() as Map<String, dynamic>;
        return data['year'] as String?; // ترجع السنة أو null
      } else {
        return null; // مفيش بيانات
      }
    } catch (e) {
      print('❌ خطأ في جلب سنة التقرير: $e');
      return null; // في حالة خطأ
    }
  }
}
