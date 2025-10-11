import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alradi_app/services/firebaseApi.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();
  List<DocumentSnapshot> _matches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    try {
      final matches = await _firebaseApi.getAllMatches();
      if (mounted) {
        setState(() {
          _matches = matches;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ خطأ في تحميل المباريات: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _formatDate(Timestamp timestamp) {
    try {
      final dateTime = timestamp.toDate();
      final months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
      return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
    } catch (e) {
      return '--';
    }
  }

  String _formatTime(Timestamp timestamp) {
    try {
      final dateTime = timestamp.toDate();
      final hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = hour < 12 ? 'ص' : 'م';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:$minute $period';
    } catch (e) {
      return '--:--';
    }
  }

  // دالة لتحديد إذا كانت المباراة قادمة (لم تبدأ بعد)
  bool _isUpcomingMatch(Timestamp matchTime) {
    final now = Timestamp.now();
    return matchTime.compareTo(now) > 0; // الوقت الحالي أقل من وقت المباراة
  }

  // جلب فقط المباريات القادمة
  List<DocumentSnapshot> _getUpcomingMatches() {
    return _matches.where((match) {
      final matchData = match.data() as Map<String, dynamic>;
      final matchTime = matchData['time'] as Timestamp;
      return _isUpcomingMatch(matchTime);
    }).toList();
  }

  Widget _buildMatchCard(DocumentSnapshot match) {
    final matchData = match.data() as Map<String, dynamic>;
    final matchTime = matchData['time'] as Timestamp;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // إزالة قسم حالة المباراة بالكامل
            // const SizedBox(height: 16),
            
            // الفريقين
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الفريق المضيف (الرائد)
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'الرائد',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // VS والنتيجة
                Column(
                  children: [
                    Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // يمكن إضافة النتيجة هنا إذا كانت متاحة
                    // Text('2 - 1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                
                // الفريق الضيف
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.network(
                            matchData['away_team']['image'],
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.sports_soccer, 
                                  size: 24, color: Colors.grey.shade400);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        matchData['away_team']['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // التاريخ والوقت
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.blue.shade600),
                      const SizedBox(width: 6),
                      Text(
                        _formatDate(matchTime),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.orange.shade600),
                      const SizedBox(width: 6),
                      Text(
                        _formatTime(matchTime),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // الملعب
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.stadium, size: 16, color: Colors.green.shade600),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      matchData['location'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade800,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final upcomingMatches = _getUpcomingMatches();

    return Scaffold(
      appBar: CustomAppBar(title: 'مباريات النادي',
        
      ),
      body: _isLoading
          ? _buildLoading()
          : upcomingMatches.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _loadMatches,
                  child: ListView.builder(
                    itemCount: upcomingMatches.length,
                    itemBuilder: (context, index) {
                      return _buildMatchCard(upcomingMatches[index]);
                    },
                  ),
                ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.red.shade600),
          const SizedBox(height: 16),
          const Text(
            'جاري تحميل المباريات...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_soccer, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'لا توجد مباريات قادمة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'سيتم إضافة المباريات قريباً',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadMatches,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('إعادة تحميل'),
          ),
        ],
      ),
    );
  }
}